#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/trondkr/NS8KM-ROMS/POSTPROCESS/runM2R.sh
