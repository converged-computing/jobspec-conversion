#!/bin/bash
#SBATCH --job-name=bml-cv
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --array=0-11

echo "Loading modules"
module use /cm/shared/ex3-modules/latest/modulefiles
module load slurm/20.02.7
module load tensorflow2-py37-cuda10.2-gcc8/2.5.0
python --version
srun python cv_model_selection.py $SLURM_ARRAY_TASK_ID
