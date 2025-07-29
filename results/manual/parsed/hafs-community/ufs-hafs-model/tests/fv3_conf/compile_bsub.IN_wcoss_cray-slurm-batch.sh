#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hafs-community/ufs-hafs-model/tests/fv3_conf/compile_bsub.IN_wcoss_cray
