#!/bin/bash
#FLUX: --job-name=dinosaur-parsnip-6704
#FLUX: --priority=15

export TMPDIR='/localscratch'

export TMPDIR=/localscratch
mkdir -p $TMPDIR
source /home/icb/xichen.wu/miniconda3/etc/profile.d/conda.sh
conda activate samtools
sam=../gene_demulti/data/MS_nuclei_hashing/747495_GX12/outs/possorted_genome_bam.bam
barcodes=../gene_demulti/data/MS_nuclei_hashing/747495_GX12/outs/filtered_feature_bc_matrix/barcodes.tsv
./filter_bam_file_for_popscle_dsc_pileup.sh ${sam} ${barcodes} sorted.vcf.gz filtered_bam_file.bam
samtools index filtered_bam_file.bam
samtools view --threads 6 --tag-file CB:downsampled_Hash45${SLURM_ARRAY_TASK_ID}_TotalSeqA_0.5.tsv --bam -o downsampled_hash45${SLURM_ARRAY_TASK_ID}_05_run1.bam filtered_bam_file.bam
samtools index downsampled_hash45${SLURM_ARRAY_TASK_ID}_05_run1.bam
conda deactivate
conda activate nextflow
nextflow run main.nf -c test_cl.config -profile conda_singularity --scSplit_preprocess True --match_donor False \
    --bam downsampled_hash45${SLURM_ARRAY_TASK_ID}_05_run1.bam --bai downsampled_hash45${SLURM_ARRAY_TASK_ID}_05_run1.bam.bai \
    --barcodes downsampled_Hash45${SLURM_ARRAY_TASK_ID}_TotalSeqA_0.5.tsv --outdir downsampled_hash45${SLURM_ARRAY_TASK_ID}_run1_05
