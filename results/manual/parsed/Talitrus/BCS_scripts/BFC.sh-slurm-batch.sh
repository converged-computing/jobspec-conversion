#!/bin/bash
#SBATCH --job-name=BFC
#SBATCH --output=out_err_files/BFC_%A_%a.out
#SBATCH --error=out_err_files/BFC_%A_%a.err
#SBATCH --mail-user=bnguyen@gwu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=defq,short
#SBATCH --array=1-22

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p seq_list.txt)
cd ../data/seq
module load BFC
bfc -s 3g -t 16 ${name1}_001.fastq.gz | gzip -1 > ${name1}.corrected.fastq.gz
