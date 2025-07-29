#!/bin/bash
#SBATCH --job-name=prepvae
#SBATCH --output=output_%a.txt
#SBATCH --error=error_%a.txt
#SBATCH --mail-user=hungyi_wu@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:00:10
#SBATCH --partition=short

module load gcc/6.2.0 python/3.7.4
source /home/hw233/virtualenv/py374/bin/activate
python prep_vae.py $SLURM_ARRAY_TASK_ID
