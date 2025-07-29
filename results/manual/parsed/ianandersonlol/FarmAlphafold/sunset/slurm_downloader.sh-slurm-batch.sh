#!/bin/bash
#SBATCH --job-name=alphafoldDownloadMove
#SBATCH --output=/home/icanders/slurm-log/downloader.txt
#SBATCH --error=/home/icanders/slurm-log/downloadererrors.txt
#SBATCH --mail-user=icanderson@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=6-06:00:00
#SBATCH --chdir=/home/icanders

module load spack/aria2
bash /home/icanders/alphafold/scripts/download_all_data.sh /home/icanders/alphafoldDownload/
