#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/srinathv/NaluSpack/spack_config/machines/merlin/run_nalu_merlin.sh
