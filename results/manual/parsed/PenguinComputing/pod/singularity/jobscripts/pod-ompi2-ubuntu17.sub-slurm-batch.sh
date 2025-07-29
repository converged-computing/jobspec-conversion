#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/PenguinComputing/pod/singularity/jobscripts/pod-ompi2-ubuntu17.sub
