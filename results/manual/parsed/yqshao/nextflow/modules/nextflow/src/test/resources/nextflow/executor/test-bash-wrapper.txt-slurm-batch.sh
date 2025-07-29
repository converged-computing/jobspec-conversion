#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/yqshao/nextflow/modules/nextflow/src/test/resources/nextflow/executor/test-bash-wrapper.txt
