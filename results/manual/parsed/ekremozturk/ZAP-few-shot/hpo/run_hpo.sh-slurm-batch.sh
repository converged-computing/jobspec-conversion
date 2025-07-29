#!/bin/bash
#SBATCH --job-name=v2_54_ws
#SBATCH --output=logs/hpo/%A-%a.%x.o
#SBATCH --error=logs/hpo/%A-%a.%x.e
#SBATCH --mail-user=ozturk@informatik.uni-freiburg.de
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --array=1-53%20

source /home/ozturk/anaconda3/bin/activate metadl
pwd
ARGS_FILE=hpo/hpo_warmstart.args
TASK_SPECIFIC_ARGS=$(sed "${SLURM_ARRAY_TASK_ID}q;d" $ARGS_FILE)
echo $TASK_SPECIFIC_ARGS
python -m hpo.optimizer $TASK_SPECIFIC_ARGS
