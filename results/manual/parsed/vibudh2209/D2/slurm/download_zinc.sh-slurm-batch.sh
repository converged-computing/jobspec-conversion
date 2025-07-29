#!/bin/bash
#SBATCH --job-name=download_zinc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0

source tensorflow_gpu/bin/activate
python download_zinc15.py -up $1 -fp $2 -fn $3  -tp $4
