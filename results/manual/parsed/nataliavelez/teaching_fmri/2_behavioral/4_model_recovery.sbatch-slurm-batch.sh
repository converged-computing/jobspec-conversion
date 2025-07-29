#!/bin/bash
#SBATCH --output=reports/lookahead_%x_%A_%a.out
#SBATCH --error=reports/lookahead_%x_%A_%a.err
#SBATCH --mail-user=nvelez@fas.harvard.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=08:00:00
#SBATCH --partition=fasse

module load ncf
module load Anaconda/5.0.1-fasrc01
source activate py3
python 4_model_recovery.py $1 ${SLURM_ARRAY_TASK_ID}
