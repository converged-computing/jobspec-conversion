#!/bin/bash
#SBATCH --job-name=univaralphastable_train_deepsets
#SBATCH --account=lu2018-2-22
#SBATCH --output=lunarc_output/univaralphastable/outputs_univaralphastable_train_deepsets_%j.out
#SBATCH --error=lunarc_output/univaralphastable/errors_univaralphastable_train_deepsets_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=11000
#SBATCH --time=4-04:00:00
#SBATCH --partition=gpu

ml load GCC/6.4.0-2.28
ml load CUDA/9.1.85
ml load OpenMPI/2.1.2
ml load cuDNN/7.0.5.15
ml load julia/1.0.0
nvidia-smi
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'alpha stable dist'/train_deepsets.jl standard 100 1 1
