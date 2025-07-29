#!/bin/bash
#SBATCH --job-name=run_compute_pred_accuracy_mrmashrss_sparse_LD_V_all_chr_init_prior_finemapped_bc_ukb
#SBATCH --output=run_compute_pred_accuracy_mrmashrss_sparse_LD_V_all_chr_init_prior_finemapped_bc_ukb.%j.out
#SBATCH --error=run_compute_pred_accuracy_mrmashrss_sparse_LD_V_all_chr_init_prior_finemapped_bc_ukb.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=06:00:00

export MKL_NUM_THREADS='1'

FOLD=${1}
METHOD=${2}
source /opt/intel/oneapi/mkl/2023.0.0/env/vars.sh intel64
module load R/4.2.3
export MKL_NUM_THREADS=1
Rscript ../code/compute_prediction_accuracy_bc_ukb.R --model mr_mash_rss_sparse_LD_V_all_chr_"${METHOD}"_init_prior_finemapped \
                                                     --model_fit_dir ../output/mr_mash_rss_fit/ \
                                                     --pheno ../data/phenotypes/ukb_cleaned_bc_adjusted_pheno_test_"${FOLD}".rds \
                                                     --geno /scratch1/fabiom/ukb_bc_geno_imp_HM3.rds \
                                                     --sample_file /data2/morgante_lab/data/ukbiobank/genotypes/imputed/ukb22828_c1_b0_v3_s487271.sample \
                                                     --samples_to_keep ../data/misc/ukb_cleaned_bc_ind_ids.txt \
                                                     --chr 1:22 \
                                                     --trait 1:16 \
                                                     --impute_missing FALSE \
                                                     --output_eff ../output/estimated_effects/ukb_bc_mr_mash_rss_sparse_LD_V_all_chr_"${METHOD}"_init_prior_finemapped_effects_"${FOLD}".rds \
                                                     --output_pred_acc ../output/prediction_accuracy/ukb_bc_mr_mash_rss_sparse_LD_V_all_chr_"${METHOD}"_init_prior_finemapped_pred_acc_"${FOLD}".rds \
                                                     --prefix ukb_bc \
                                                     --fold ${FOLD} \
                                                     --ncores 8
module unload R/4.2.3
