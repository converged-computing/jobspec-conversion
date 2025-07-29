#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NOAA-SWPC/GSMWAM-IPE/scripts/plot/make_plots.batch
