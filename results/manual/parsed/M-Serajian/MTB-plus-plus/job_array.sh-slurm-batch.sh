#!/bin/bash
#SBATCH --job-name=31mer_analysis
#SBATCH --output=/blue/boucher/share/MTB/MTB_Database/BV_BRC_MTB++_temp_files/logs/%x_%j.out
#SBATCH --mail-user=m.serajian@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10gb
#SBATCH --time=20:00:00
#SBATCH --array=0-0

export OMP_NUM_THREADS='16'

date;
export OMP_NUM_THREADS=16
ml python
ml perl
perl 31mer_analysis.pl \
    -i resistant_genomes.csv \
    -o . \
    -b /blue/boucher/share/MTB/MTB_Database/BV_BRC_corrected \
    -f fna \
    -t /blue/boucher/share/MTB/MTB_Database/BV_BRC_MTB++_temp_files
date;
