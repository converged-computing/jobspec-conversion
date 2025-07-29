#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=a100:1
#SBATCH --mem=64gb
#SBATCH --time=02:00:00
#SBATCH --partition=gpu

date;hostname;pwd
module load singularity
singularity run --nv \
--bind /blue/vendor-nvidia/hju/single_cell_data:/data \
/blue/vendor-nvidia/hju/single-cell-examples_rapids_cuda11.0
