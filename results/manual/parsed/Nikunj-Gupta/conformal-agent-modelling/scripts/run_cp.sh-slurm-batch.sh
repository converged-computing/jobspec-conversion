#!/bin/bash
#SBATCH --account=def-ebrahimi
#SBATCH --output=out/%x_%A.out
#SBATCH --error=out/%x_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=64G
#SBATCH --time=20:00:00
#SBATCH --array=0-20

export OMP_NUM_THREADS='1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)'

source venv/bin/activate
export OMP_NUM_THREADS=1 #init weights fails otherwise (see https://github.com/pytorch/pytorch/issues/21956)
cp_update_timestep=${1}
runs=${SLURM_ARRAY_TASK_ID}
time python conformal-action-prediction/conformal-rl.py --cp_update_timestep=$cp_update_timestep --log_dir="./debug_logs/cam-actions" --seed=$runs 
