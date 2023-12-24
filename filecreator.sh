#!/bin/bash

# Find the maximum number of files in the current directory
max=$(ls | grep -c "^file[0-9]\{1,\}$")

# Create 25 files with increasing numbers
for i in $(seq 1 25); do
    touch "file$((max + i))"
    echo "Created file file$((max + i))"
done


