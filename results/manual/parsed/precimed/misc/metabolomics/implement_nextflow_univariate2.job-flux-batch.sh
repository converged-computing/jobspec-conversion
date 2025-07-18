#!/bin/bash
#FLUX: --job-name=gwas
#FLUX: -t=346800
#FLUX: --urgency=16

export NXF_OFFLINE='TRUE'

module purge
module load java/jdk-11.0.1+13
module load plink/1.90b6.2
module load PLINK/2.00a2.3_x86_64
source /cluster/projects/p33/users/mohammadzr/envs/pynext38/bin/activate
export NXF_OFFLINE='TRUE'
nextflow run univariate_gwas2.nf --pheno ../../lipids/pheno/lipid_pheno_april24_with_labels_only_europeans.csv --out ../../lipids/europeans/intermediate --cov ../../lipids/pheno/covariates_april10pc_with_labels_fin_age_sex_pc.csv -qs 3636 --out2 ../../lipids/europeans/original --out3 ../../lipids/europeans/permuted --out4 ../../lipids/europeans/zscores --out5 ../../lipids/europeans/rg --project 'nmr_euro' -resume
