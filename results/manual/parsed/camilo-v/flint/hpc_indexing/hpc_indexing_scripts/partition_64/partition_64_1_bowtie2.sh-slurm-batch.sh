#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/camilo-v/flint/hpc_indexing/hpc_indexing_scripts/partition_64/partition_64_1_bowtie2.sh
