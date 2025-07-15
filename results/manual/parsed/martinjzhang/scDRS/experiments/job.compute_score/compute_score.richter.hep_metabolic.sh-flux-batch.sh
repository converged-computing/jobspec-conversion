#!/bin/bash
#FLUX: --job-name=moolicious-butter-9681
#FLUX: --priority=16

H5AD_FILE=/n/holystore01/LABS/price_lab/Users/mjzhang/scDRS_data/single_cell_data/richter_biorxiv_2020/obj_raw.h5ad
GS_FILE=/n/holystore01/LABS/price_lab/Users/mjzhang/scDRS_data/gs_file/ploidy.gs
OUT_FOLDER=/n/holystore01/LABS/price_lab/Users/mjzhang/scDRS_data/score_file/score.richter.hep_metabolic
python3 /n/home11/mjzhang/gwas_informed_scRNAseq/scDRS/compute_score.py \
    --h5ad_file $H5AD_FILE\
    --h5ad_species mouse\
    --gs_file $GS_FILE\
    --gs_species human\
    --flag_filter True\
    --flag_raw_count True\
    --n_ctrl 1000\
    --flag_return_ctrl_raw_score False\
    --flag_return_ctrl_norm_score True\
    --out_folder $OUT_FOLDER
