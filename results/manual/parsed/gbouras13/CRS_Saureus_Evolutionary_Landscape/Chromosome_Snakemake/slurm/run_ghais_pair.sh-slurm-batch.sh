#!/bin/bash
#SBATCH --job-name=ghais_pair
#SBATCH --output=ghais_pair.out
#SBATCH --error=ghais_pair.err
#SBATCH --mail-user=george.bouras@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=75GB
#SBATCH --time=12:00:00
#SBATCH --partition=batch

PROF_DIR="/hpcfs/users/a1667917/snakemake_slurm_profile"
cd ..
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -c 32 -s runner_ghais.smk --use-conda  --conda-frontend conda  \
--config csv=ghais_metadata.csv Output=../Paper_1_Snakemake_Output 
conda deactivate
