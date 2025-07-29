#!/bin/bash
#SBATCH --job-name=task1speed
#SBATCH --account=def-masd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=185000M
#SBATCH --time=7-00:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
./program
module load gcc/9.3.0 r/4.0.2 python/3.8.10 python-build-bundle
module use python
module use python-build-bundle
source $HOME/jupyter_py3/bin/activate
pip install --no-index --upgrade pip
pip install rpy2 matplotlib cupy numpy scipy
nvidia-smi
lscpu
python3 /home/kyang/tasks/task1speed/dist/task1speed.py
