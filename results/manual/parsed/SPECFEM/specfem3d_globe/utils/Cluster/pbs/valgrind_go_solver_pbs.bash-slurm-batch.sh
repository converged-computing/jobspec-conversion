#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SPECFEM/specfem3d_globe/utils/Cluster/pbs/valgrind_go_solver_pbs.bash
