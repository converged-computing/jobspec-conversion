#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ZhaiLab-SUSTech/STAM-seq/01_basecalling/03_deepsignal_plant.sh
