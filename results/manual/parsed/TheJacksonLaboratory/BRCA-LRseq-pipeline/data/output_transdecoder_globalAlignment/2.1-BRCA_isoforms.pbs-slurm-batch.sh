#!/bin/bash
#SBATCH --job-name=transdecoder_downstream
#SBATCH --output=%x.out
#SBATCH --error=%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=12:00:00
#SBATCH --chdir=/projects/dveiga/analysis/git/BRCA_isoforms/transdecoder_globalAlignment

set -u
dir_r=/projects/banchereau-lab/tools/3_4_4/bin
$dir_r/R CMD BATCH /projects/dveiga/analysis/git/BRCA_isoforms/transdecoder_globalAlignment/2.1-BRCA_isoforms.R
