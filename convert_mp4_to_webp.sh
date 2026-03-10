#!/bin/bash

# Script to convert MP4 files to WebP format
# Path to the dataset directory
DATASET_PATH="/mnt/datadisk/andreim/hal-mount/HRIA/pose/datasets/Dataset-HAR-output"

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install it first:"
    echo "sudo apt update && sudo apt install ffmpeg"
    exit 1
fi

# Counter for processed files
processed=0
failed=0

echo "Starting MP4 to WebP conversion..."
echo "Dataset path: $DATASET_PATH"
echo

# Iterate through all subdirectories
for dir in "$DATASET_PATH"/*; do
    if [ -d "$dir" ]; then
        # Get the directory name (movie name)
        movie_name=$(basename "$dir")
        mp4_file="$dir/$movie_name.mp4"
        webp_file="$dir/$movie_name.webp"
        
        # Check if MP4 file exists
        if [ -f "$mp4_file" ]; then
            echo "Processing: $movie_name"
            
            # Convert MP4 to WebP using ffmpeg
            if ffmpeg -i "$mp4_file" -c:v libwebp -quality 80 -preset default -an "$webp_file" -y 2>/dev/null; then
                echo "  ✓ Converted: $movie_name.mp4 -> $movie_name.webp"
                ((processed++))
            else
                echo "  ✗ Failed to convert: $movie_name"
                ((failed++))
            fi
        else
            echo "  ⚠ No MP4 file found in: $movie_name"
        fi
    fi
done

echo
echo "Conversion complete!"
echo "Successfully processed: $processed files"
echo "Failed conversions: $failed files"
