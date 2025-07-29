#!/bin/bash
#SBATCH --job-name=Neurodocker_FSL_bet_example
#SBATCH --output=Neurodocker_FSL_bet.%J.out
#SBATCH --error=Neurodocker_FSL_bet.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10gb
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load apptainer
apptainer run docker://unlhcc/neurodocker-fsl bet \
    ./data/STRUCT.nii.gz STRUCT_brain.nii.gz -m
