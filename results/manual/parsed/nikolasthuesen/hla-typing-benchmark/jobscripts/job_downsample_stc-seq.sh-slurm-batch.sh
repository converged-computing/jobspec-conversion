#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/nikolasthuesen/hla-typing-benchmark/jobscripts/job_downsample_stc-seq.sh
