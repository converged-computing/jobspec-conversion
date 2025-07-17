#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load apptainer/1.2.5
device="A100" 
for index in {1..5}; do
outfile="gpu_cuda_${device}_${index}.out"
apptainer exec --nv namd3.simg namd3 namd3_input.in > $outfile
done
cat /proc/cpuinfo | grep "model name" | uniq
grep  TIMING: gpu_cuda_0_*.out | awk '{printf "Performance %f %s ",\$9,\$10}'
echo -n $1 "GPUs, " 
hostname -s
output_file="${device}_results_namd.dat"
temp_file="tmpl"
rm "$output_file"
for file in gpu_cuda_${device}_*.out; do
    if [[ -f "$file" ]]; then
        # Calculate the line number for the last 10th line
        total_lines=$(wc -l < "$file")
        line_number=$((total_lines - 23))
        # Extracting the last 10th line from each file
        last_line=$(sed -n "${line_number}p" "$file")
        # Writing the results to the temporary file
        echo "$last_line" >> "$temp_file"
    fi
done
grep "TIMING: " tmpl | awk '{print $9}' > "$output_file"
rm "$temp_file"
echo "Extracted data saved to $output_file"
