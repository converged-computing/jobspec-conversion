#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SentientSchnitzel/DeepSpeechSeparation02466/reproducability/run_eval_3c.sh
