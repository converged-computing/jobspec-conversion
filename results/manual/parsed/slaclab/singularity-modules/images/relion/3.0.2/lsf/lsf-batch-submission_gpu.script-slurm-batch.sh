#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/slaclab/singularity-modules/images/relion/3.0.2/lsf/lsf-batch-submission_gpu.script
