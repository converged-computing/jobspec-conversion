#!/bin/bash
#SBATCH --job-name=antipode_script
#SBATCH --output=/home/matthew.schmitz/log/antipode_script_%A.out
#SBATCH --error=/home/matthew.schmitz/log/antipode_script_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128gb
#SBATCH --time=3-00:00:00
#SBATCH --constraint=a100|v100

source ~/.bashrc
!nvidia-smi
conda activate pyro
python ~/Matthew/code/scANTIPODE/examples/RunDev-CleanedFixMemLeak-Longer-cere-NoDN.py
