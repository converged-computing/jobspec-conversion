#!/bin/bash
#SBATCH --job-name=federaser
#SBATCH --output=tensor_out_9.txt
#SBATCH --error=tensor_error_9.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50000

module load cuda/10.0.130
module load anaconda/3.6
source activate federaser
srun python ../Fed_Unlearn_main_9.py
