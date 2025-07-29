#!/bin/bash
#SBATCH --job-name=sequential_job
#SBATCH --output=output_%A_%j.out
#SBATCH --error=error_%A_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=5G
#SBATCH --time=00:30:00

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
