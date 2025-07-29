#!/bin/bash
#SBATCH --job-name=TS_train_Piglet_EEG_Model
#SBATCH --output=t_smallGPU_out.txt
#SBATCH --error=t_smallGPU_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --mem=50000
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

module load gnu7
module load cuda/11.0.2.450
module load anaconda
module load mvapich2
module load pmix/2.2.2
source activate timsTF
srun --mpi=pmi2 python ~/pycharmFwd/TF1\ work/RNNforPigletEEG.py
