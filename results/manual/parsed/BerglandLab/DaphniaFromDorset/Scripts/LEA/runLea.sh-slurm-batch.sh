#!/bin/bash
#SBATCH --job-name=split_and_run
#SBATCH --account=berglandlab
#SBATCH --output=/scratch/aob2x/lea.%A_%a.out
#SBATCH --error=/scratch/aob2x/lea.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=10

module load intel/18.0 intelmpi/18.0 R/3.6.3
wd=/scratch/aob2x/daphnia_hwe_sims/
Rscript ${wd}/DaphniaPulex20162017Sequencing/AlanAnalysis/LEA/runLea.R
