#!/bin/bash
#SBATCH --job-name=CROP
#SBATCH --output=out_err_files/CROP_%A_%a.out
#SBATCH --error=out_err_files/CROP_%A_%a.err
#SBATCH --mail-user=bnguyen@gwu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=defq,short

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p seq_list.txt)
cd ../data/seq
module load gsl/gcc/2.3
module load CROP
CROP -i macse.precluster.pick.pick.redundant.fasta -o macse.precluster.pick.pick.redundant_CROP -l 3 -u 4 -z 450 -b 850
