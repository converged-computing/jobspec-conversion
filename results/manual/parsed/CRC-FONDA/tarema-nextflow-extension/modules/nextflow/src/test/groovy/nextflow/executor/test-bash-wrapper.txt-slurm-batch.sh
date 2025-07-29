#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CRC-FONDA/tarema-nextflow-extension/modules/nextflow/src/test/groovy/nextflow/executor/test-bash-wrapper.txt
