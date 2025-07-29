#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MoiCatPigeon/WT-MetaD-HREX_HJ/run-md_gmx.sh
