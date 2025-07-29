#!/bin/bash
#SBATCH --job-name=QC
#SBATCH --output=logs/QC/QC_%x_%J_out.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000M
#SBATCH --constraint=ntasks-per-node=1

import socket
set +u
source /home/douyanmeiLab/lujinhong/miniconda3/etc/profile.d/conda.sh
set -u
snakemake --unlock --cores 4
snakemake --rerun-incomplete -j 400 --restart-times 3 --latency-wait 120 --cluster "sbatch -p amd-ep2,intel-e5 -q huge -c 1 -t 48:00:00 --mem=8000M -o logs/QC/QC_%x_%J_out.txt "
