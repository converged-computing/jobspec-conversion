#!/bin/bash
#SBATCH --account=def-ichiro
#SBATCH --output=run_output/2_output_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=12500M
#SBATCH --time=5-00:00:00
#SBATCH --array=97

module load python/3.8
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install google==3.0.0
pip install openpyxl
echo "Starting Task $SLURM_ARRAY_TASK_ID"
python -u data_lyrics.py --id $SLURM_ARRAY_TASK_ID
