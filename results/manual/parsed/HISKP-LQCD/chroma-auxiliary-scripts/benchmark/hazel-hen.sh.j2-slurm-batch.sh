#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/HISKP-LQCD/chroma-auxiliary-scripts/benchmark/hazel-hen.sh.j2
