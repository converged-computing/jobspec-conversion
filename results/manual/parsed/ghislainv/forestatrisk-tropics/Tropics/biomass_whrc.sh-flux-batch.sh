#!/bin/bash
#FLUX: --job-name=getBiomass
#FLUX: -c=3
#FLUX: --queue=agap_normal
#FLUX: -t=172800
#FLUX: --priority=16

export MPLCONFIGDIR='/lustre/vieilledentg/config/matplotlib'

export MPLCONFIGDIR="/lustre/vieilledentg/config/matplotlib"
module load singularity
storage="/storage/replicated/cirad/projects/AMAP/vieilledentg"
image="/lustre/vieilledentg/singularity_images/forestatrisk-tropics.simg"
script="/home/vieilledentg/Code/forestatrisk-tropics/Tropics/biomass_whrc.py"
singularity exec --bind $storage $image python3 -u $script $SLURM_ARRAY_TASK_ID
