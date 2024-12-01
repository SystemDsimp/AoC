#!/usr/bin/env bash

# Check if the user provided a URL
if [ -z "$1" ]; then
  echo "Usage: $0 <URL> <SESSION-COOKIE>"
  exit 1
fi

# Extract year and day from the URL
url="$1"
if [[ $url =~ adventofcode\.com/([0-9]+)/day/([0-9]+)/input ]]; then
  year="${BASH_REMATCH[1]}"
  day="${BASH_REMATCH[2]}"
else
  echo "Error: The URL must match the format 'https://adventofcode.com/<year>/day/<day>/input'"
  exit 1
fi

# Pad the day with leading zero if needed
day=$(printf "%02d" "$day")

# Define the target folder
folder="${year}/${day}"

# Create the folder if it doesn't exist
mkdir -p "$folder"

# Define the output file path
output_file="${folder}/input.txt"

# Download the input
curl -sSL "$url" -o "$output_file" --header "Cookie: $2"

if [ $? -eq 0 ]; then
  echo "Input successfully downloaded to ${output_file}"
else
  echo "Failed to download the input from ${url}"
  exit 1
fi