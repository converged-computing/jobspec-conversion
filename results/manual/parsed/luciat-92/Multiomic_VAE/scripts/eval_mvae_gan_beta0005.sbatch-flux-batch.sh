#!/bin/bash
#FLUX: --job-name=eval_adv
#FLUX: --queue=cpuq
#FLUX: -t=21600
#FLUX: --urgency=16

module load nlopt/2.7.0-intel-oneapi-mkl-2021.4.0 
module load R/4.1.0
GROUP_PATH='/group/iorio/lucia/'
PATH_MODEL=${GROUP_PATH}'Multiomic_VAE/experiments/experiment_3/mvae_gan/'
PATH_DATA=${GROUP_PATH}'Multiomic_VAE/data/preprocessed/'
Rscript experiments/plot_corr_encoded_space.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_nfeat_var5000_norm_feat_flag_False_norm_type_zscore_only_shared_False_beta_0.0005/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --input_data_file ${PATH_DATA}gene_expression_var5000_tcgaonly.csv.gz ${PATH_DATA}methylation_var5000_tcgaonly.csv.gz
Rscript experiments/plot_corr_encoded_space.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_nfeat_var5000_norm_feat_flag_False_norm_type_zscore_only_shared_False_beta_0.0005/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --input_data_file ${PATH_DATA}gene_expression_var5000_tcgaonly.csv.gz ${PATH_DATA}methylation_var5000_tcgaonly.csv.gz \
    --private_enc TRUE
