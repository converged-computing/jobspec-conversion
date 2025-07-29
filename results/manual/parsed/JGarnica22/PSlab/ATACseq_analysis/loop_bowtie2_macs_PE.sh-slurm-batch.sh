#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JGarnica22/PSlab/ATACseq_analysis/loop_bowtie2_macs_PE.sh
