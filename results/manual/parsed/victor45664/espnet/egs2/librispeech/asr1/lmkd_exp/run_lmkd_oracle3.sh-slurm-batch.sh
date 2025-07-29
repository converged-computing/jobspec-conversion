#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/victor45664/espnet/egs2/librispeech/asr1/lmkd_exp/run_lmkd_oracle3.sh
