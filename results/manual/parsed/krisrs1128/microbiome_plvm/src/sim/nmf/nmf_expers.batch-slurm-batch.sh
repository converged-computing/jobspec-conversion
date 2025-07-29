#!/bin/bash
#SBATCH --job-name=nmf_expers
#SBATCH --output=pipeline%j.out
#SBATCH --error=pipeline%j.err
#SBATCH --mail-user=kriss1@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12G
#SBATCH --time=1-16:00:00
#SBATCH --qos=normal

module load llvm/4.0.0
module load R/3.4.0
module load python/3.6.1
cd /scratch/users/kriss1/programming/research/microbiome_plvm/src/sim/nmf/
Rscript nmf_expers.R
