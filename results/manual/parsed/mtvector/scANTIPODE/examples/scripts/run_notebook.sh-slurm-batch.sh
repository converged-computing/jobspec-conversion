#!/bin/bash
#SBATCH --job-name=singnbconv
#SBATCH --output=/home/matthew.schmitz/log/nbconvert_%A_%a.out
#SBATCH --error=/home/matthew.schmitz/log/nbconvert_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=255gb
#SBATCH --time=2-02:00:00
#SBATCH --constraint=a100|v100

source ~/.bashrc
!nvidia-smi
conda activate antipode
NOTEBOOK=/allen/programs/celltypes/workgroups/rnaseqanalysis/EvoGen/Team/Matthew/code/scANTIPODE/examples/1.9.1.8.3_JorstadAll-NoReLU.ipynb
jupyter nbconvert --ExecutePreprocessor.allow_errors=True --to html --execute "${NOTEBOOK}" --output ~/Matthew/code/scANTIPODE/examples/outputs/"executed_$(basename "${NOTEBOOK}")" 
