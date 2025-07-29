#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/xiangsunlab/MBX-1/scripts/supercomputer/thunder_dod/compilation/compile_thunder_intel.job
