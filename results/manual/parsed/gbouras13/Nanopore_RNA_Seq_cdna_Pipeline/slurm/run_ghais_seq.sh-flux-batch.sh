#!/bin/bash
#FLUX: --job-name=ghais_rna_seq
#FLUX: -t=82800
#FLUX: --urgency=16

SNK_DIR="/hpcfs/users/a1667917/Ghais/Rat_RNA_Seq/Nanopore_RNA_Seq_cdna_Pipeline"
PROF_DIR="/hpcfs/users/a1667917/snakemake_slurm_profile"
cd $SNK_DIR
module load Anaconda3/2020.07
conda activate snakemake_clean_env
snakemake -s rna_seq_runner.smk --use-conda \
--config Reads=/hpcfs/users/a1667917/Ghais/Rat_RNA_Seq/aggregated_fastqs  Output=/hpcfs/users/a1667917/Ghais/Rat_RNA_Seq/RNA_Seq_Pipeline_Out  --profile $PROF_DIR/wgs_tcga
conda deactivate
