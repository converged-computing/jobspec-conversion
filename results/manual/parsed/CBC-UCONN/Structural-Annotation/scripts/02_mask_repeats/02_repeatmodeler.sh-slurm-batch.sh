#!/bin/bash
#SBATCH --job-name=repeatmodeler_model
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=your.email@uconn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=50G
#SBATCH --partition=general
#SBATCH --qos=general

hostname
date
module load RepeatModeler/2.0.4
module load ninja/0.95 
REPDIR=../../results/02_mask_repeats
cd ${REPDIR}
REPDB=athaliana_db
RepeatModeler -threads 30 -database ${REPDB} -LTRStruct 
date
