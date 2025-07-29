#!/bin/bash
#SBATCH --job-name=primal-test
#SBATCH --account=gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=150000
#SBATCH --time=04:00:00

module purge
module load anaconda
module load boost/1.64.0
module load cuda/9.0.176 cudnn/cuda-9.0_7.4
source activate 571project
python -u turtlebot3.py --alg cbs --no-gui --n-tests 10
