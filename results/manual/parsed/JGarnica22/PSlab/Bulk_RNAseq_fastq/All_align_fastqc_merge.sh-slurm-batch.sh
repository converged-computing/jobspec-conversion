#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JGarnica22/PSlab/Bulk_RNAseq_fastq/All_align_fastqc_merge.sh
