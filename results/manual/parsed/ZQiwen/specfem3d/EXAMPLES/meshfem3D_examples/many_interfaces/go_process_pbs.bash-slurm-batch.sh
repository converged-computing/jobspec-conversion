#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ZQiwen/specfem3d/EXAMPLES/meshfem3D_examples/many_interfaces/go_process_pbs.bash
