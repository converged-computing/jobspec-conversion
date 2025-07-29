#!/bin/bash
#SBATCH --job-name=fractal_GHMSS_v1
#SBATCH --output=fractal_GHMSS_v1.out
#SBATCH --mail-user=espeakma@cougarnet.uh.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=8

module load TensorFlow/2.11.0-foss-2022a
python FractalModelSlurm.py
module unload TensorFlow/2.11.0-foss-2022a
module load Anaconda3
python PrintPlots.py fractal_GHMSS_v1.out
module unload Anaconda3
