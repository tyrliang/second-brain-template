import pdfplumber
import sys

if len(sys.argv) < 2:
    print("Usage: python extract_pdf.py <path/to/file.pdf>")
    sys.exit(1)

pdf_path = sys.argv[1]

with pdfplumber.open(pdf_path) as pdf:
    print(f"Title: {pdf.metadata.get('Title', 'N/A')}")
    print(f"Author: {pdf.metadata.get('Author', 'N/A')}")
    print(f"Number of pages: {len(pdf.pages)}")
    print()

    full_text = ""
    for i, page in enumerate(pdf.pages, 1):
        text = page.extract_text()
        if text:
            full_text += f"\n{'='*50}\nPage {i}\n{'='*50}\n\n{text}"
        print(f"Processed page {i}/{len(pdf.pages)}")

    print("\n\n" + "="*80)
    print("FULL TEXT CONTENT")
    print("="*80)
    print(full_text)
