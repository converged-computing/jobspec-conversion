#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/oxwang/fda_scRNA-seq/1_Preprocessing/scRNASeq/iCELL8/cutadapt_star_rsem.sh
