#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mfumagalli/ImaGene/Reproduce/HPC/produce_images_hpc.sh
