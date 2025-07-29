#!/bin/bash
#SBATCH --job-name=qrennd-train-test
#SBATCH --output=train_qrennd.%j.out
#SBATCH --error=train_qrennd.%j.err
#SBATCH --mail-user=m.serraperalta@student.tudelft.nl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=20:00:00
#SBATCH --partition=gpu

module load 2022r2
module load python
module load openmpi
module load py-tensorflow
previous=$(/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/tail -n '+2')
srun --mpi=pmix python train_qrennd.py
/usr/bin/nvidia-smi --query-accounted-apps='gpu_utilization,mem_utilization,max_memory_usage,time' --format='csv' | /usr/bin/grep -v -F "$previous"
