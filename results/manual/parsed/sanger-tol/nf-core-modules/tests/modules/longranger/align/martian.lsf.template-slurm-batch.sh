#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sanger-tol/nf-core-modules/tests/modules/longranger/align/martian.lsf.template
