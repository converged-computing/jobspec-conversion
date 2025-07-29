#!/bin/bash
#SBATCH --job-name=hashseq
#SBATCH --output=/users/amyerke/slurmLogs/Noguera-Julian_%x.%j.out
#SBATCH --error=/users/amyerke/slurmLogs/Noguera-Julian_%x.%j.out
#SBATCH --mail-user=amyerke@uncc.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500gb
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=1

echo Job: $SLURM_JOB_NAME with ID $SLURM_JOB_ID
echo Running on host: `hostname`
echo Using $SLURM_NTASKS processors across $SLURM_NNODES nodes
module load R
srun Rscript ~/git/balance_tree_exploration/lib/cml_scripts/data_preprocessing/hashseq.R \
	-i ~/git/balance_tree_exploration/Noguera-Julian/downloaded_seqs \
	-o ~/git/balance_tree_exploration/Noguera-Julian/output/hashseq
echo ""
echo "======================================================"
echo "End Time   : $(date)"
echo "======================================================"
