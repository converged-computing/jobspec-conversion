#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GeoscienceAustralia/HiQGA.jl/examples/2D/image_revBayes/submit.sh
