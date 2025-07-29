#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Mouse-Imaging-Centre/RMINC/inst/parallel/pbs_script.tmpl
