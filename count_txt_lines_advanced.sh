#!/bin/bash

# Improved script for finding .txt files
# Accepts base directory as an argument
# Saves results to a file

# Function to show usage
show_usage() {
    echo "Use: $0 [DIRECTORY] [OUTPUT_FILE]"
    echo ""
    echo "Search for .txt files in DIRECTORY and count their lines"
    echo ""
    echo "Args:"
    echo "  DIRECTORY      Base directory for searching (default: \$HOME)"
    echo "  OUTPUT_FILE  File where to save results (default: txt_lines_report.txt)"
    echo ""
    echo "Examples:"
    echo "  $0                          # Search in \$HOME, save to txt_lines_report.txt"
    echo "  $0 /etc                     # Search in /etc, save to txt_lines_report.txt"
    echo "  $0 /var/log results.txt     # Search in /var/log, save to results.txt"
}

BASE_DIR="${1:-$HOME}"
OUTPUT_FILE="${2:-txt_lines_report.txt}"

# Validate that the directory exists
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: The directory '$BASE_DIR' doesn´t exist"
    echo ""
    show_usage
    exit 1
fi

# Initial information
echo "=============================================="
echo "Searching for .txt files
echo "=============================================="
echo "Base directory: $BASE_DIR"
echo "Output file: $OUTPUT_FILE"
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================================="
echo ""

# Start output file
{
    echo "=============================================="
    echo "Report of .txt files by number of lines"
    echo "=============================================="
    echo "Base directory: $BASE_DIR"
    echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=============================================="
    echo ""
} > "$OUTPUT_FILE"

# Temporary array to store results
declare -a results
count=0

echo "Searching for files .txt..."

# Search for all .txt files in the specified directory
while IFS= read -r -d '' file; do
    # Count lines in the file
    lines=$(wc -l < "$file" 2>/dev/null)
    results+=("$lines|$file")
    ((count++))
done < <(find "$BASE_DIR" -type f -name "*.txt" -print0 2>/dev/null)

echo "Found $count files .txt"
echo ""

# If no files were found
if [ $count -eq 0 ]; then
    echo "No file found .txt in $BASE_DIR"
    echo ""
    echo "No file found .txt in $BASE_DIR" >> "$OUTPUT_FILE"
    exit 0
fi

# Sort and display results
echo "Results (ordered by number of lines):"
echo "--------------------------------------------"
total_lines=0
printf '%s\n' "${results[@]}" | sort -t'|' -k1 -nr | while IFS='|' read -r lines file; do
    # Display on screen
    printf "%8d líneas: %s\n" "$lines" "$file"
    # Save to file
    printf "%8d líneas: %s\n" "$lines" "$file" >> "$OUTPUT_FILE"
done

# Final summary
echo ""
echo "=============================================="
echo "Summary:"
echo "  Total .txt files: $count"
echo "  Results saved in: $OUTPUT_FILE"
echo "=============================================="
{
    echo ""
    echo "=============================================="
    echo "Summary:"
    echo "  Total number of .txt files found: $count"
    echo "=============================================="
} >> "$OUTPUT_FILE"

echo ""
echo "Process completed successfully"
