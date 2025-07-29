#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SunderlandLab/MITgcm_eccov4_code/tools/example_scripts/ACESgrid/test_aces_ifc_mpi
