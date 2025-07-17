#!/bin/bash
#FLUX: --job-name=NextflowQAPipeline
#FLUX: -c=48
#FLUX: --urgency=16

module load java/8u131
module load intel/2017.1
module load nextflow/19.03.0
module load singularity
nextflow run /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/06_SC_preprocess_object_M.nf \
                  --output_dir_name "00_scRNA-Seq_exVivo_rhemac10" \
                  --input_dir_name "00_scRNA-Seq_exVivo_rhemac10" \
                  --qc "01_QC_exvivo.R" \
                  -w /gpfs/projects/bsc83/Data/Ebola/work/ \
                  -c /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/configs/nextflow.sc_preprocess.config
