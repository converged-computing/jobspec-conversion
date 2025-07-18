#!/bin/bash
#FLUX: --job-name=NextflowQAPipeline
#FLUX: -c=48
#FLUX: --urgency=16

module load java/8u131
module load intel/2017.1
module load nextflow/19.03.0
module load singularity
nextflow run /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/05_SC_analysis.nf \
                  --strandness "FR" \
                  --output_dir_name "01_scRNA-Seq_inVivo_rhemac10" \
                  --dataset_bam_dir "/gpfs/projects/bsc83/Data/Ebola/00_RawData/seqwell/data/IRF_SerialSac/Mapping_V4/Mapping_V4" \
                  -w /gpfs/projects/bsc83/Data/Ebola/work/ \
                  -c ../configs/nextflow.config.sc
