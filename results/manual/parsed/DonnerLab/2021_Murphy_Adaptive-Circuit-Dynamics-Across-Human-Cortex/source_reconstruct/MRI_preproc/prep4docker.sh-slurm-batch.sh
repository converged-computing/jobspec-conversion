#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DonnerLab/2021_Murphy_Adaptive-Circuit-Dynamics-Across-Human-Cortex/source_reconstruct/MRI_preproc/prep4docker.sh
