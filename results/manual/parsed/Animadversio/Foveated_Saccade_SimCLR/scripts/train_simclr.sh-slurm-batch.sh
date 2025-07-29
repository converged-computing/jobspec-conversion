#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Animadversio/Foveated_Saccade_SimCLR/scripts/train_simclr.sh
