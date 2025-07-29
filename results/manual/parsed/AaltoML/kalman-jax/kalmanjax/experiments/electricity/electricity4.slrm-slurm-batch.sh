#!/bin/bash
#SBATCH --output=electricity-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=1-00:00:00
#SBATCH --array=0-9

module load miniconda
source activate venv
srun python electricity.py 4 $SLURM_ARRAY_TASK_ID
