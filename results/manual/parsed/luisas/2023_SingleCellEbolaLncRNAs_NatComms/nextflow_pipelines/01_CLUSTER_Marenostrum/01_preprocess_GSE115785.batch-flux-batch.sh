#!/bin/bash
#FLUX: --job-name=PreprocessZyagen
#FLUX: -c=48
#FLUX: --urgency=16

module load java/8u131
module load intel/2017.1
module load nextflow/19.03.0
module load singularity
nextflow run /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/01_preprocess_and_denovoassembly.nf \
                  --strandness "RF" \
                  --umis "false" \
                  --output_dir_name "02_RNA-Seq_ribodepl" \
                  --fastqs "/gpfs/projects/bsc83/Data/Ebola/01_bulk_RNA-Seq_lncRNAs_annotation/02_RNA-Seq_ribodepl/01_fastq/GSE115785/*/*/*/*.{1,2}.fq.gz" \
                  -w /gpfs/projects/bsc83/Data/Ebola/work/ \
                  -c ../configs/nextflow.config.rnaseq
