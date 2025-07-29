#!/bin/bash
#SBATCH --output=slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8192
#SBATCH --time=1-00:00:00

module load cuda/10
/modules/apps/cuda/10.1.243/samples/bin/x86_64/linux/release/deviceQuery
module load miniconda/4.11.0
conda run -n fresh2 --no-capture-output python3.8 discrimination_task.py 1
