#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:1
#SBATCH --mem=64gb
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

date;hostname;pwd
module load singularity
singularity exec --nv /blue/vendor-nvidia/hju/monaicore1.0.1 \
nsys profile \
--output ./output_base \
--force-overwrite true \
--trace-fork-before-exec true \
python3 $HOME/tutorials/performance_profiling/radiology/train_base_nvtx.py
