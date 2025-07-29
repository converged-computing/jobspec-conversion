#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/simongravelle/polymer-in-water/polymer-in-water/inputs/run_bigfoot_UGA.sh
