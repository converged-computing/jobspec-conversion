#!/bin/bash
#FLUX: --job-name=sequential_job
#FLUX: -c=2
#FLUX: --queue=quicktest
#FLUX: -t=1800
#FLUX: --priority=16

shopt -s nullglob
FILES=()
for file in *_thermal*.sh; do
    FILES+=("$file")
done
for file in *_nonthermal*.sh; do
    FILES+=("$file")
done
shopt -u nullglob
if [ ${#FILES[@]} -eq 0 ]; then
    echo "No eligible files found."
    exit 1
fi
for file in "${FILES[@]}"; do
    echo "$file"
    current_file="$(realpath "$file")"  # Store the full file path
    echo $current_file
    base_name="${current_file%.*}"
    source /nfs/scratch/projects/icm/AMI_git/profile/sourceme.sh
    /nfs/scratch/projects/icm/AMI_git/profile/profile.linux < "$current_file" > "${base_name}_profile_2.out"
done
