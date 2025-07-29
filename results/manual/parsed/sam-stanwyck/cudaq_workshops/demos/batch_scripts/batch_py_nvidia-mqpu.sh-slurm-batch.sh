#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sam-stanwyck/cudaq_workshops/demos/batch_scripts/batch_py_nvidia-mqpu.sh
