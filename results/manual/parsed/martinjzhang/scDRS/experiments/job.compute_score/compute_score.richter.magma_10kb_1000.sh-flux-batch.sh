#!/bin/bash
#FLUX: --job-name=quirky-peas-9135
#FLUX: --priority=16

BATCH_NUM=$SLURM_ARRAY_TASK_ID
H5AD_FILE=/n/holystore01/LABS/price_lab/Users/mjzhang/scTRS_data/single_cell_data/richter_biorxiv_2020/obj_raw.h5ad
GS_FILE=/n/holystore01/LABS/price_lab/Users/mjzhang/scTRS_data/gs_file/magma_10kb_1000.gs.batch/magma_10kb_1000.batch$BATCH_NUM.gs
OUT_FOLDER=/n/holystore01/LABS/price_lab/Users/mjzhang/scTRS_data/score_file/score.richter.magma_10kb_1000
python3 /n/home11/mjzhang/gwas_informed_scRNAseq/scTRS/compute_score.py \
    --h5ad_file $H5AD_FILE\
    --h5ad_species mouse\
    --gs_file $GS_FILE\
    --gs_species human\
    --flag_filter True\
    --flag_raw_count True\
    --flag_return_ctrl_raw_score False\
    --flag_return_ctrl_norm_score True\
    --out_folder $OUT_FOLDER
