#!/bin/bash
#SBATCH --job-name=ipython-trial2
#SBATCH --output=jupyter-log-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH: --exclusive

module load gcc mvapich2 py-tensorflow
source opt/venv-gcc/bin/activate
ipnport=$(shuf -i8000-9999 -n1)
jupyter-notebook --no-browser --port=${ipnport} --ip=$(hostname -i)
