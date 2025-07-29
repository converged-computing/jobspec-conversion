#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/carstenbauer/JuliaHLRS23/exercises/Day4/1_saxpy_gpu/hawk_job.qbs
