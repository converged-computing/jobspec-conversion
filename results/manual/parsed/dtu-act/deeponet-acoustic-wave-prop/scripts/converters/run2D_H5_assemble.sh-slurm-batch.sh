#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dtu-act/deeponet-acoustic-wave-prop/scripts/converters/run2D_H5_assemble.sh
