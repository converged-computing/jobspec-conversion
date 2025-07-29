#!/bin/bash
#SBATCH --job-name=univ_alphastable_multi_ABC_dnn_small2
#SBATCH --account=lu2018-2-22
#SBATCH --output=lunarc_output/univaralphastable/outputs_alphastable_multiple_ABC_dnn_small_%j.out
#SBATCH --error=lunarc_output/univaralphastable/errors_alphastable_multiple_ABC_dnn_small_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=11000
#SBATCH --time=4-04:30:00
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
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'alpha stable dist'/multiple_ABC_runs_mlp.jl mlp standard 250 25 25 12 3 0 small
