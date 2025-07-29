#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/IENT/MatlabSubmit/%2Bqueue/%2Binternal/lsf_template_queue_script.sh
