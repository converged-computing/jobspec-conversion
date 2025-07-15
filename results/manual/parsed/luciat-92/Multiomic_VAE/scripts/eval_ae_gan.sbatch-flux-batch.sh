#!/bin/bash
#FLUX: --job-name=eval_adv
#FLUX: --queue=cpuq
#FLUX: -t=21600
#FLUX: --priority=16

module load nlopt/2.7.0-intel-oneapi-mkl-2021.4.0 
module load R/4.1.0
GROUP_PATH='/group/iorio/lucia/'
PATH_MODEL=${GROUP_PATH}'Multiomic_VAE/experiments/experiment_1/ae_gan/'
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx 
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx 
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_all_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var1000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples__ngene_var5000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_all_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var1000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_False_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_False_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_True_only_shared_False/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx
Rscript experiments/plot_umap_results_run.R \
    --folder_model ${PATH_MODEL}samples_tcgaonly_ngene_var5000_norm_feat_flag_True_only_shared_True/ \
    --depmap_meta_file ${GROUP_PATH}datasets/DEPMAP_PORTAL/version_23Q2/Model.csv \
    --file_purity ${GROUP_PATH}Multiomic_VAE/data/raw/41467_2015_BFncomms9971_MOESM1236_ESM.xlsx \
    --private_enc TRUE
