#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/annaivina/MLPF_cocoa/particleflow/submit_jobs/make_tfds.sh
