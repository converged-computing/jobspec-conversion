#!/bin/bash
#SBATCH --job-name=HISROC13
#SBATCH --account=rwth0583
#SBATCH --output=output.%J.txt
#SBATCH --mail-user=annika.stein@rwth-aachen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=40G
#SBATCH --time=02:10:00
#SBATCH --constraint=ntasks-per-node=2

cd /home/um106329/aisafety
source ~/miniconda3/bin/activate
conda activate my-env
python3 eval_hist_roc.py
