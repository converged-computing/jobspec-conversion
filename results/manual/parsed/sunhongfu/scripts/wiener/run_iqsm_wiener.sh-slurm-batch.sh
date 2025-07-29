#!/bin/bash
#SBATCH --job-name=PA_TI
#SBATCH --output=iqsm_hand.out
#SBATCH --error=iqsm_hand.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-smx2:1
#SBATCH --mem=10000
#SBATCH --partition=gpu

module load anaconda/3.6
source activate pytorch_1.7
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
module load matlab
srun matlab -nodisplay -singleCompThread -r "demo_single_echo"
