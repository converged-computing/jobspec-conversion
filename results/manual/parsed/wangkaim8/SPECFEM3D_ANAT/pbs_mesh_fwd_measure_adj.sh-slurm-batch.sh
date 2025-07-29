#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wangkaim8/SPECFEM3D_ANAT/pbs_mesh_fwd_measure_adj.sh
