#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/BSC-CNS-EAPM/MN_bash_runners/run_files/nord/run_peleplatform_v1.6.2/run_peleplatform_v1.6.2.sh
