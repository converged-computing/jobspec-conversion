#!/bin/bash
#SBATCH --job-name=dqn_job_gpu
#SBATCH --account=ie-idi
#SBATCH --output=out/dqn_job_gpu.txt
#SBATCH --mail-user=jacob.LLarsen@hotmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:30:00
#SBATCH --partition=GPUQ

module purge
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module list
python -m cProfile -s cumtime -o program.prof -m src.DRL.train_qrunner
