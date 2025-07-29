#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/carstenbauer/JuliaHLRS23/notebooks/Day3/mpi_examples/hawk_job.qbs
