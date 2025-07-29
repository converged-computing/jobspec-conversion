#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SPECFEM/scaling-benchmarks/Summit/SPECFEM3D_GLOBE/benchmark-scripts/go_benchmark.summit.bash
