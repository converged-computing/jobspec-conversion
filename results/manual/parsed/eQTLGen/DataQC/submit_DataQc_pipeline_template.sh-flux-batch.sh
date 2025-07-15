#!/bin/bash
#FLUX: --job-name="DataQc"
#FLUX: -t=172800
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='../../singularitycache'
export NXF_HOME='../../nextflowcache'

module load java-1.8.0_40
module load singularity/3.5.3
module load squashfs/4.4
export SINGULARITY_CACHEDIR=../../singularitycache
export NXF_HOME=../../nextflowcache
set -f
nextflow_path=../../tools # folder where Nextflow executable is
bfile_path=[full path to your input genotype files without .bed/.bim/.fam extension]
exp_path=[full path to your gene expression matrix]
gte_path=[full path to your genotype-to-expression file]
exp_platform=[expression platform name: HT12v3/HT12v4/HuRef8/RNAseq/AffyU219/AffyHumanExon]
cohort_name=[name of the cohort]
genome_build="GRCh37"
output_path=../output # Output path
NXF_VER=21.10.6 ${nextflow_path}/nextflow run DataQC.nf \
--bfile ${bfile_path} \
--expfile ${exp_path} \
--gte ${gte_path} \
--exp_platform ${exp_platform} \
--cohort_name ${cohort_name} \
--genome_build ${genome_build} \
--outdir ${output_path}  \
-profile slurm,singularity \
-resume
