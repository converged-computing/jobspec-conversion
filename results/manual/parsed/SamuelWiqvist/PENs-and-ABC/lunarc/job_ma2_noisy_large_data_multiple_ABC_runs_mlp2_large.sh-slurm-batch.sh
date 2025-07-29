#!/bin/bash
#SBATCH --job-name=ma2_multi_ABC_mlp2
#SBATCH --account=lu2018-2-22
#SBATCH --output=lunarc_output/MA2_noisy_data/outputs_ma2_multiple_ABC_runs_mlp_%j.out
#SBATCH --error=lunarc_output/MA2_noisy_data/errors_ma2_multiple_ABC_runs_mlp_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=3100
#SBATCH --time=04:00:00

ml load GCC/6.4.0-2.28
ml load CUDA/9.1.85
ml load OpenMPI/2.1.2
ml load cuDNN/7.0.5.15
ml load julia/1.0.0
nvidia-smi
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'MA2 noisy data'/multiple_ABC_runs_mlp.jl mlp standard 250 2 0 large
