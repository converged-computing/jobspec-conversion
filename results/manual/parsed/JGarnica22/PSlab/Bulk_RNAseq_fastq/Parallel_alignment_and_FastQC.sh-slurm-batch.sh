#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JGarnica22/PSlab/Bulk_RNAseq_fastq/Parallel_alignment_and_FastQC.sh
