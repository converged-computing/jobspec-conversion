#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=outs/%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=30000
#SBATCH --time=01:00:00
#SBATCH --partition=brown

module load singularity
module --ignore-cache load CUDA
singularity run --nv -B /home/common/datasets/amazon_review_data_2018,/home/timp/repositories/bringo/data bridger.sif
