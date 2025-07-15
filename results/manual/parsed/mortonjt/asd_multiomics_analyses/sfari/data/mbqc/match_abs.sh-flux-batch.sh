#!/bin/bash
#FLUX: --job-name=moolicious-motorcycle-3416
#FLUX: -t=360000
#FLUX: --priority=16

export TBB_CXX_TYPE='gcc'

source ~/.bashrc
conda activate qiime2-2021.4
export TBB_CXX_TYPE=gcc
module load disBatch/2.0
mkdir intermediate_first
case_control_disbatch.py \
    --biom-table deblur/all.biom \
    --metadata-file metadata/sample_2_4_metadata_first.txt \
    --matching-ids "Contributor" \
    --groups "Sample_Name" \
    --treatment-group 'sample2' \
    --monte-carlo-samples 100 \
    --intermediate-directory intermediate_first \
    --output-inference age_sex_matched_posterior_last
