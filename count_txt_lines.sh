#!/bin/bash

# Script to find .txt files in the home directory
# Counts the lines in each file and sorts them by line count

echo "Searching for .txt files in the home directory..."
echo "=============================================="
# Temporary array to store results
declare -a results

# Search for all .txt files in the home directory
while IFS= read -r -d '' file; do
    # Count lines in the file
    lines=$(wc -l < "$file" 2>/dev/null)
    # Store result
    results+=("$lines|$file")
done < <(find "$HOME" -type f -name "*.txt" -print0 2>/dev/null)

# Sort results by number of lines and display
printf '%s\n' "${results[@]}" | sort -t'|' -k1 -nr | while IFS='|' read -r lines file; do
    printf "%6d líneas: %s\n" "$lines" "$file"
done

echo "=============================================="
echo "Search complete"
