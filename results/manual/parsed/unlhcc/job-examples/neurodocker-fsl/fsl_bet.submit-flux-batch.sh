#!/bin/bash
#FLUX: --job-name=Neurodocker_FSL_bet_example
#FLUX: -t=604800
#FLUX: --priority=16

module purge
module load apptainer
apptainer run docker://unlhcc/neurodocker-fsl bet \
    ./data/STRUCT.nii.gz STRUCT_brain.nii.gz -m
