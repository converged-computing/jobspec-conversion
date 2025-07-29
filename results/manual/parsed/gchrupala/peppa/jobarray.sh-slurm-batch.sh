#!/bin/bash
#SBATCH --output=slurm.%A_%a.out
#SBATCH --error=slurm.%j_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx:1
#SBATCH --time=00:48:00
#SBATCH --partition=GPUExtended
#SBATCH --array=1-4

conda activate home
cd /home/gchrupal/peppa
source ./bin/activate
python run.py --config_file $1
