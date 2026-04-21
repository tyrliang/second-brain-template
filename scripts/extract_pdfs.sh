#!/bin/bash

# Extract all PDFs from raw/ folder to markdown format
# This script requires: brew install poppler (pdftotext)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PDF_DIR="$SCRIPT_DIR/../raw"
OUTPUT_DIR="$PDF_DIR"

# Check if pdftotext is available
if ! command -v pdftotext &> /dev/null; then
    echo "Installing poppler for PDF text extraction..."
    brew install poppler
fi

# Get all PDF files
pdf_count=$(find "$PDF_DIR" -maxdepth 1 -name "*.pdf" -type f | wc -l)
echo "Found $pdf_count PDF files to extract"

# Process each PDF
find "$PDF_DIR" -maxdepth 1 -name "*.pdf" -type f | while read -r pdf_path; do
    filename=$(basename "$pdf_path")
    md_name="${filename%.pdf}.md"
    md_path="$OUTPUT_DIR/$md_name"

    echo "Extracting: $filename -> $md_name"

    # Use pdftotext to extract text
    pdftotext "$pdf_path" - | while IFS= read -r line; do
        echo "$line"
    done > "$md_path"

    echo "✓ Successfully extracted to $md_name"
done

echo "✓ All PDFs extracted to markdown files"
