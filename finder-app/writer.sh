#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file-path> <string-to-write>"
    exit 1
fi

# Assign arguments to variables
writefile="$1"
writestr="$2"

# Create the directory path if it does not exist
dirpath=$(dirname "$writefile")
if [ ! -d "$dirpath" ]; then
    echo "Directory '$dirpath' does not exist. Creating it now."
    mkdir -p "$dirpath" || {
        echo "Error: Could not create directory '$dirpath'."
        exit 1
    }
fi

# Create or overwrite the file with the provided string
echo "$writestr" > "$writefile" || {
    echo "Error: Could not create or write to file '$writefile'."
    exit 1
}

echo "File '$writefile' created and written successfully."

