#!/bin/bash
#FLUX: --job-name=scruptious-gato-0663
#FLUX: --urgency=16

export PATH='$PATH:/usr/local/cuda/bin'

export PATH=$PATH:/usr/local/cuda/bin
LD_LIBRARY_PATH="/home/santiago/local/lib"
export LD_LIBRARY_PATH
EXECUTABLE="./genmat"
if [ ! -x "$EXECUTABLE" ]; then
    echo "The 'execute.out' executable does not exist in the current directory or is not executable."
    exit 1
fi
MATRIX_NAME=("generator1.mtx"
"generator2.mtx"
"generator3.mtx"
"generator4.mtx"
"generator5.mtx"
"generator6.mtx"
"generator7.mtx"
"generator8.mtx"
"generator9.mtx"
"generator10.mtx"
)
mkdir -p /work/$USER/tmp1
OUTPUT_DIR="/global/D1/homes/santiago/reorderings/original/"   
for matrix_name in "${MATRIX_NAME[@]}"; do
    # Extract the matrix name and the group name
    group_name="generator"
    # Create a folder with the group name if it doesn't exist
    mkdir -p "$OUTPUT_DIR$group_name"
    # Run the program with the input matrix
    # 1000000 1000000 -d 0.0002 (1-4)
    # 1000000 1000000 -d 0.0001 (5-8)
    # 10000000 10000000 -d 0.000004 (9-10)
    "$EXECUTABLE" 1000000 1000000 -d 0.0001 -s 1 -i 1 -o "/work/$USER/tmp1/$matrix_name"
    # Rename the generated output to the desired name and desired folder
    mv "/work/$USER/tmp1/$matrix_name" "$OUTPUT_DIR$group_name/$matrix_name"
    # Compress the output file to a .gz file
    gzip -c "$OUTPUT_DIR$group_name/$matrix_name" > "$OUTPUT_DIR$group_name/$matrix_name.gz"
    # Remove the original .mtx file to free up space
    rm "$OUTPUT_DIR$group_name/$matrix_name"
    echo "Processed $matrix_name and saved as $output_file"
done
