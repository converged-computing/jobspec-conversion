#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/RMGDFT/rmgdft/Examples/MnBiTe_6layer_SOC_wannier/job.summit
