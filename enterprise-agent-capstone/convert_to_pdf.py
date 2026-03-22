from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Preformatted
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib.enums import TA_LEFT
import markdown

# Read the markdown file
with open('WARP.md', 'r', encoding='utf-8') as f:
    md_content = f.read()

# Convert markdown to HTML
html_content = markdown.markdown(md_content, extensions=['fenced_code', 'codehilite'])

# Create PDF
pdf_file = 'WARP.pdf'
doc = SimpleDocTemplate(pdf_file, pagesize=letter)
story = []

# Get styles
styles = getSampleStyleSheet()
styles.add(ParagraphStyle(name='Code', fontName='Courier', fontSize=9, leftIndent=20))

# Split content by lines and process
lines = md_content.split('\n')
in_code_block = False
code_lines = []

for line in lines:
    if line.strip().startswith('```'):
        if in_code_block:
            # End of code block
            if code_lines:
                code_text = '\n'.join(code_lines)
                story.append(Preformatted(code_text, styles['Code']))
                story.append(Spacer(1, 0.2*inch))
                code_lines = []
            in_code_block = False
        else:
            # Start of code block
            in_code_block = True
        continue
    
    if in_code_block:
        code_lines.append(line)
    elif line.strip():
        if line.startswith('#'):
            # Headers
            level = len(line) - len(line.lstrip('#'))
            text = line.lstrip('#').strip()
            if level == 1:
                style = styles['Heading1']
            elif level == 2:
                style = styles['Heading2']
            else:
                style = styles['Heading3']
            story.append(Paragraph(text, style))
            story.append(Spacer(1, 0.2*inch))
        elif line.startswith('-'):
            # Bullet points
            text = line.lstrip('- ').strip()
            story.append(Paragraph(f'• {text}', styles['Normal']))
        elif line.strip().startswith('**') and line.strip().endswith('**'):
            # Bold text
            text = line.strip().strip('*')
            story.append(Paragraph(f'<b>{text}</b>', styles['Normal']))
            story.append(Spacer(1, 0.1*inch))
        else:
            # Normal text
            story.append(Paragraph(line, styles['Normal']))
    else:
        story.append(Spacer(1, 0.1*inch))

# Build PDF
doc.build(story)
print("✓ Successfully converted WARP.md to WARP.pdf")
print(f"PDF saved at: C:\\Users\\Admin\\Documents\\enterprise-agent-capstone\\WARP.pdf")
