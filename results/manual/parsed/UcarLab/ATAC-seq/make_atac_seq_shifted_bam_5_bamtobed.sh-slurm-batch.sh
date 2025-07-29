#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UcarLab/ATAC-seq/make_atac_seq_shifted_bam_5_bamtobed.sh
