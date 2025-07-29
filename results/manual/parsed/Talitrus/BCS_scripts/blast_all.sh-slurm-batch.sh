#!/bin/bash
#SBATCH --job-name=blastn
#SBATCH --output=out_err_files/blastn_%A_%a.out
#SBATCH --error=out_err_files/blastn_%A_%a.err
#SBATCH --mail-user=bnguyen@gwu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p seq_list.txt)
cd ../data/seq
module load python/2.7.6
module load clustalw2
module load blast+
blastn -query macse.precluster.pick.pick.redundant_CROP.cluster.fasta -db /groups/cbi/bryan/COI_all.fasta -perc_identity 97 -outfmt 6 -out blast_all_real2 -qcov_hsp_perc 50
