#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GillesJ/Pref_Suff_Span_NN/jobs_tensorflow_singularity.sh
