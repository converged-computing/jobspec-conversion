#!/bin/bash
#SBATCH --account=hpc2n2023-124
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=4-04:00:00

echo "Arguments passed to the script: $@"
source /proj/nobackup/hpc2n2023-124/llm_qlora/venv/bin/activate
srun $1
