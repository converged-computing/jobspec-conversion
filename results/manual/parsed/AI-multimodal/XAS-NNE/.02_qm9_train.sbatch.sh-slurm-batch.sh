#!/bin/bash
#SBATCH --job-name=ml-xas-qm9
#SBATCH --account=mlg-core
#SBATCH --output=Logs/job_data/test_gpu_%A.out
#SBATCH --error=Logs/job_data/test_gpu_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=volta

module load gcc/8.3.0
module load openmpi/4.0.2-gcc-8.3.0-cuda10.1
module load pytorch/1.5.1
module load cuda/10.2
source env/bin/activate
which python3
python3 02_qm9_train.py "$@"
