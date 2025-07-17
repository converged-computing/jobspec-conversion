#!/bin/bash
#FLUX: --job-name=InteractionAnalysis
#FLUX: -t=43200
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='../singularitycache'
export NXF_HOME='../nextflowcache'

ml nextflow
export SINGULARITY_CACHEDIR=../singularitycache
export NXF_HOME=../nextflowcache
set -f
vcf_dir_path=/groups/umcg-bios/tmp01/projects/BIOS_for_eQTLGenII/pipeline/20220426/2_Imputation/out/${c}/postimpute/
raw_exp_path=/groups/umcg-fg/tmp01/projects/eqtlgen-phase2/output/2023-03-16-sex-specific-analyses/run1/data/${c}/${c}_raw_expression.txt.gz
norm_exp_path=/groups/umcg-bios/tmp01/projects/BIOS_for_eQTLGenII/pipeline/20220426/1_DataQC/out/${c}/outputfolder_exp/exp_data_QCd/exp_data_preprocessed.txt
covariate_path=/groups/umcg-fg/tmp01/projects/eqtlgen-phase2/output/2023-03-16-sex-specific-analyses/run1/BIOS_covariates.txt
gte_path=/groups/umcg-fg/tmp01/projects/eqtlgen-phase2/output/2023-03-16-sex-specific-analyses/run1/data/${c}/${c}.gte
covariate_to_test=gender_F1M2
genotype_pcs_path=/groups/umcg-bios/tmp01/projects/BIOS_for_eQTLGenII/pipeline/20220426/1_DataQC/out/${c}/outputfolder_gen/gen_PCs/GenotypePCs.txt
expression_pcs_path=/groups/umcg-bios/tmp01/projects/BIOS_for_eQTLGenII/pipeline/20220426/1_DataQC/out/${c}/outputfolder_exp/exp_PCs/exp_PCs.txt
output_path=/groups/umcg-fg/tmp01/projects/eqtlgen-phase2/output/2023-03-16-sex-specific-analyses/run2/results/${c}_interactions/
script_folder=/groups/umcg-fg/tmp01/projects/eqtlgen-phase2/output/2023-03-16-sex-specific-analyses/test_nextflow/ieQTL_nextflow_pipeline/
qtls_to_test=${script_folder}/data/sign_qtls.txt.gz
chunk_file=${script_folder}/data/ChunkingFile.GRCh38.110.txt
exp_platform=RNAseq
NXF_VER=21.10.6 nextflow run /groups/umcg-fg/tmp01/projects/eqtlgen-phase2/output/2023-03-16-sex-specific-analyses/test_nextflow/ieQTL_nextflow_pipeline/InteractionAnalysis.nf \
--bfile $bfile \
--raw_expfile ${raw_exp_path} \
--norm_expfile ${norm_exp_path} \
--gte ${gte_path} \
--covariates $covariate_path \
--exp_platform ${exp_platform} \
--cohort_name ${cohort_name} \
--covariate_to_test $covariate_to_test \
--qtls_to_test $qtls_to_test \
--genotype_pcs $genotype_pcs_path \
--chunk_file $chunk_file \
--outdir ${output_path}  \
--run_stratified false \
--preadjust false \
--cell_perc_interactions false \
-resume \
-profile singularity,slurm
