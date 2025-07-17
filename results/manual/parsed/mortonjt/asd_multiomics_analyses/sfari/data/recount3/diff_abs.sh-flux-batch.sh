#!/bin/bash
#FLUX: --job-name=angry-banana-3567
#FLUX: --exclusive
#FLUX: --queue=ccb
#FLUX: -t=360000
#FLUX: --urgency=16

export TBB_CXX_TYPE='gcc'

source ~/.bashrc
conda activate qiime2-2021.4
module load disBatch/2.0-beta
export TBB_CXX_TYPE=gcc
cd /mnt/home/jmorton/ceph/sfari/data/recount3
echo `which python`
echo `which case_control_slurm.py`
case_control_disbatch.py \
    --biom-table table.biom \
    --metadata-file sample_metadata.txt \
    --matching-ids Match_IDs \
    --groups Status \
    --treatment-group 'ASD' \
    --monte-carlo-samples 100 \
    --intermediate-directory intermediate \
    --no-overwrite \
    --job-extra "export TBB_CXX_TYPE=gcc" \
    --output-inference age_sex_matched_posterior/rna_differentials-v4.nc
