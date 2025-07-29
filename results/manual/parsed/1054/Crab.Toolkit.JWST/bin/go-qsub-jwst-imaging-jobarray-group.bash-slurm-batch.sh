#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/1054/Crab.Toolkit.JWST/bin/go-qsub-jwst-imaging-jobarray-group.bash
