#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DS3Lab/Decentralized-FM/scripts/lsf_scripts/lsf_gpt3xl_64gpu.bsub
