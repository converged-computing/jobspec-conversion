#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GeoscienceAustralia/HiQGA.jl/examples/MT1D/field_data/SouthernThomson_joint_VTEM_MT/submit.sh
