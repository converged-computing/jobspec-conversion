#!/bin/bash
#SBATCH --job-name=xc
#SBATCH --account=PAA0202
#SBATCH --mail-user=provost.27@osu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

cd $SLURM_SUBMIT_DIR
module load gnu/9.1.0
module load openmpi/1.10.7
module load mkl/2019.0.5
module load R/4.0.2
module load miniconda3
module load java
Rscript "~/bioacoustics/download_xc.R"
