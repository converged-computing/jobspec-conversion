#!/bin/bash
#SBATCH --job-name=mnist
#SBATCH --output=scayle/out/conda_env_falta_5_%j.out
#SBATCH --error=scayle/err/conda_env_falta_5_%j.err
#SBATCH --mail-user=nvp1002@alu.ubu.es
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=0
#SBATCH --time=1-00:00:00
#SBATCH --partition=cascadelakegpu
#SBATCH --qos=normal
#SBATCH --chdir=.

export PATH='/home/ubu_eps_1/COMUNES/miniconda3/bin:$PATH'

export PATH=/home/ubu_eps_1/COMUNES/miniconda3/bin:$PATH
source /home/ubu_eps_1/COMUNES/miniconda3/etc/profile.d/conda.sh
conda activate env
python TFG_EMD_CV_DAonfly.py Xception True Parcial_all 16 K5 rgb
conda deactivate
