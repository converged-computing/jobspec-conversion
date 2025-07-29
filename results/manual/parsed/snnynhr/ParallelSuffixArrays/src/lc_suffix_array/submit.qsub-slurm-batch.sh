#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/snnynhr/ParallelSuffixArrays/src/lc_suffix_array/submit.qsub
