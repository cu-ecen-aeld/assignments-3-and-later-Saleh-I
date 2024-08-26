#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <search-string>"
    exit 1
fi

# Assign arguments to variables
filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: '$filesdir' is not a directory or does not exist."
    exit 1
fi

# Initialize counters
file_count=0
matching_lines_count=0

# Find all files in the directory and its subdirectories
while IFS= read -r -d '' file; do
    file_count=$((file_count + 1))
    # Count lines containing the search string in each file
    matching_lines_count=$((matching_lines_count + $(grep -c "$searchstr" "$file")))
done < <(find "$filesdir" -type f -print0)

# Print the results
echo "The number of files are $file_count and the number of matching lines are $matching_lines_count"

