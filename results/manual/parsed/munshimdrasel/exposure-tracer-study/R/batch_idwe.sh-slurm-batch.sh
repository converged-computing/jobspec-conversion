#!/bin/bash
#SBATCH --job-name=batch_idwe
#SBATCH --output=/scratch/%u/slurm_scipts/idwe_%j.out
#SBATCH --error=/scratch/%u/slurm_scipts/idwe_%j.err
#SBATCH --mail-user=mrasel@gmu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=7-00:00:00
#SBATCH --partition=bigmem
#SBATCH --constraint=amd
#SBATCH --array=1-10

module load gnu10/10.3.0
module load openmpi
module load netcdf-c
module load r/4.1.2-dx
cd /projects/HAQ_LAB/mrasel/R/exposure-tracer-study/R/
Rscript ./inverse_distance.R   
