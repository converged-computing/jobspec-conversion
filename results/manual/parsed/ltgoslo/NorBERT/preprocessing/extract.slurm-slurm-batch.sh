#!/bin/bash
#SBATCH --job-name=preprocessing
#SBATCH --account=YOUR_PROJECT_NUMBER
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --time=23:59:00

umask 0007
module purge   # Recommended for reproducibility
module load Python/3.7.4-GCCcore-8.3.0
./extract_text_from_xml.sh
