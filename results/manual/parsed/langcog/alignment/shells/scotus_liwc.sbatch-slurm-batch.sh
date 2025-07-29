#!/bin/bash
#SBATCH --job-name=SCOTUS79
#SBATCH --output=SCOTUS79.out
#SBATCH --error=SCOTUS79.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=04:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=16

cd ~gdoyle/seetweet/alignment/alignment/
module load python/3.3.2
python CHILDES_analysis3.py -r -S -R
