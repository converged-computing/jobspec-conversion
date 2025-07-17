#!/bin/bash
#FLUX: --job-name=conspicuous-taco-9400
#FLUX: --queue=ccb
#FLUX: -t=360000
#FLUX: --urgency=16

export TBB_CXX_TYPE='gcc'

source ~/.bashrc
module load disBatch/2.0
conda activate qiime2-2021.4
export TBB_CXX_TYPE=gcc
cd /mnt/home/jmorton/research/SPARK-autism/sfari/data/sra/Son2015
echo `which python`
echo `which case_control_slurm.py`
case_control_disbatch.py \
    --biom-table deblur/all.ogus.biom \
    --metadata-file sample_metadata.txt \
    --matching-ids Household \
    --groups Diagnosis \
    --treatment-group 'ASD' \
    --monte-carlo-samples 100 \
    --intermediate-directory intermediate \
    --output-inference sibling_matched_posterior/differentials.nc
