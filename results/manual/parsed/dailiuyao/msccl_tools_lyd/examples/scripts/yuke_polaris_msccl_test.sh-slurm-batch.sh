#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dailiuyao/msccl_tools_lyd/examples/scripts/yuke_polaris_msccl_test.sh
