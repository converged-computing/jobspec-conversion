#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tlkh/mini-dlperf/old/pbs_scripts/uat/performance_test/rn50_fps_8gpu.qsub
