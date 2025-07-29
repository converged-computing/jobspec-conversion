#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/a2ray/transD_GP/examples/SkyTEM1D/gradientbased/GAB_3_lines/submit.sh
