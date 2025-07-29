#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ashwinma/multicl/apps/VT-DOE-FDM-Viz-OpenCL-OpenMP/fortranOpenCL/fem_gpu.sh
