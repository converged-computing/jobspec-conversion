#!/bin/bash
#SBATCH --job-name=jpap-ipl
#SBATCH --output=examples/jpap-ipl-nace
#SBATCH --error=examples/jpap-ipl-errors
#SBATCH --mail-user=matthias.niggli@unibas.ch
#SBATCH --mail-type=END,FAIL,TIME_LIMIT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=00:10:00
#SBATCH --qos=30min

ml load CUDA/11.7.0
cd "/scicore/home/weder/GROUP/Innovation/05_job_adds_data/jpap/"
source ../jpap-venv/bin/activate
python examples/ex.py
