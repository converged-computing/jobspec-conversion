#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/haoruilee/tutorials/parallel/mpi/HPL/runs/launch_hpl_bench
