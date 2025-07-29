#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/axionyx/amrex4axionyx_1.0/Tests/GPU/Test/run.script
