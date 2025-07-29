#!/bin/bash
#SBATCH --mail-user=you@example.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=3-00:12:00

source new-modules.sh
module load python/2.7.11-fasrc01
source activate $VENV_NAME
RUNNING="python -u $PYTHON $SLURM_ARRAY_TASK_ID"
echo $RUNNING
time $RUNNING
exit 0;
