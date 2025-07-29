#!/bin/bash
#SBATCH --job-name=Tit
#SBATCH --output=ntr.%j.out
#SBATCH --error=ntr.%j.err
#SBATCH --mail-user=john.mendieta@uga.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=100gb
#SBATCH --time=4-00:00:00

cd $SLURM_SUBMIT_DIR
source /apps/lmod/lmod/init/zsh
ml Python/3.8.2-GCCcore-8.3.
ml STAR
ml BEDTools
ml SAMtools 
ml bioawk 
ml Trimmomatic
ml snakemake
ml BLAST+
ml Anaconda3
source activate snakemake_6
