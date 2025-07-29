#!/bin/bash
#SBATCH --job-name=getBiomass
#SBATCH --account=agap
#SBATCH --output=/lustre/vieilledentg/getBiomass_log.%A_%a.txt
#SBATCH --error=/lustre/vieilledentg/getBiomass_err.%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --time=2-00:00:00
#SBATCH --partition=agap_normal
#SBATCH --array=1-120

export MPLCONFIGDIR='/lustre/vieilledentg/config/matplotlib'

export MPLCONFIGDIR="/lustre/vieilledentg/config/matplotlib"
module load singularity
storage="/storage/replicated/cirad/projects/AMAP/vieilledentg"
image="/lustre/vieilledentg/singularity_images/forestatrisk-tropics.simg"
script="/home/vieilledentg/Code/forestatrisk-tropics/Tropics/biomass_whrc.py"
singularity exec --bind $storage $image python3 -u $script $SLURM_ARRAY_TASK_ID
