#!/bin/bash
#SBATCH --job-name=trust4_fastq
#SBATCH --account=a_kelvin_tuong
#SBATCH --output=trust4run_fastq_phs002599.output
#SBATCH --error=trust4run_fastq_phs002599.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=32G
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=1

dir_path="$2"
output_dir="$1"
reference_file="$3"
srun trust4_run_fastq.sh "$output_dir" "$dir_path" "$reference_file"
