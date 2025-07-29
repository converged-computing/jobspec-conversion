#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/stivalaa/gpu_hashtables/utils/timetests_iit_gpu_edward_pbs_script.sh
