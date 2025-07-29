#!/bin/bash
#SBATCH --account=p_da_mlforcode
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4000
#SBATCH --time=1-00:00:00

module load modenv/ml
module load TensorFlow
source ~/env/bin/activate && $@
