#!/bin/bash
#SBATCH --job-name=Iden_matrix_interval_1_train
#SBATCH --account=122821643660
#SBATCH --output=Output/output_iden_matrix_interval_1_train
#SBATCH --mail-user=shaowen1994@tamu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=40G
#SBATCH --time=20:00:00

module load Anaconda/2-5.0.1
source activate my_tensorflow-gpu-1.4.1
python Identity_Matrix_interval_1.py ../Datasets/Final_Data/unique_fold_train ../Datasets/Intermediate_Data/Identity_matrix_Interval_1/
source deactivate
