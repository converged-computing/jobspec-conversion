#!/bin/bash
#SBATCH --account=project_462000450
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --gpus-per-task=2
#SBATCH --mem=120G
#SBATCH --time=01:00:00
#SBATCH --partition=small-g

export DATADIR='$COURSE_SCRATCH/data'
export TORCH_HOME='$COURSE_SCRATCH/torch-cache'
export HF_HOME='$COURSE_SCRATCH/hf-cache'
export MLFLOW_TRACKING_URI='$COURSE_SCRATCH/data/users/$USER/mlruns'

module purge
module use /appl/local/csc/modulefiles/
module load pytorch
COURSE_SCRATCH="/scratch/${SLURM_JOB_ACCOUNT}"
export DATADIR=$COURSE_SCRATCH/data
export TORCH_HOME=$COURSE_SCRATCH/torch-cache
export HF_HOME=$COURSE_SCRATCH/hf-cache
export MLFLOW_TRACKING_URI=$COURSE_SCRATCH/data/users/$USER/mlruns
set -xv
python3 $*
