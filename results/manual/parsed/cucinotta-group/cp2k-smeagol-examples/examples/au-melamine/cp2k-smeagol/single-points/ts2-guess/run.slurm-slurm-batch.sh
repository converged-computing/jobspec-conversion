#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/cucinotta-group/cp2k-smeagol-examples/examples/au-melamine/cp2k-smeagol/single-points/ts2-guess/run.slurm
