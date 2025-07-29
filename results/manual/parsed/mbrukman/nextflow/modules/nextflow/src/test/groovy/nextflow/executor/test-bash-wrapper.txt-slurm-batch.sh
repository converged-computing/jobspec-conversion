#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mbrukman/nextflow/modules/nextflow/src/test/groovy/nextflow/executor/test-bash-wrapper.txt
