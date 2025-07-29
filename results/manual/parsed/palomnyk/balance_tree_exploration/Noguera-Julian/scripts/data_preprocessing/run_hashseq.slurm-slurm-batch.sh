#!/bin/bash
#FLUX: --job-name=hashseq
#FLUX: --queue=Orion
#FLUX: -t=18000
#FLUX: --urgency=16

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
