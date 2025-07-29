#!/bin/bash
#SBATCH --job-name=trust4
#SBATCH --account=a_kelvin_tuong
#SBATCH --output=trust4run_phs002517.output
#SBATCH --error=trust4run_phs002517.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=150
#SBATCH --mem=64G
#SBATCH --time=14-00:00:00
#SBATCH --partition=general
#SBATCH --constraint=ntasks-per-node=1

output_dir="$1"
bam_files_dir="$2"
reference_file="$3"
srun trust4run.sh "$output_dir" "$bam_files_dir" "$reference_file"
