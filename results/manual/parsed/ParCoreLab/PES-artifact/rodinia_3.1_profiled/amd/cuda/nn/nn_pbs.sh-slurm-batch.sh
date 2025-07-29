#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ParCoreLab/PES-artifact/rodinia_3.1_profiled/amd/cuda/nn/nn_pbs.sh
