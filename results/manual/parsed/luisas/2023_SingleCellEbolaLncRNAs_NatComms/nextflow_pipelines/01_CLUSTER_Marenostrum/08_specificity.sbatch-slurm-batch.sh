#!/bin/bash
#FLUX: --job-name=NextflowQAPipeline
#FLUX: -c=48
#FLUX: --urgency=16

module load java/8u131
module load intel/2017.1
module load R/3.6.1
module load singularity
SCRIPT_TAU=/gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/scripts/SC/03_specificity_tau.R
SCRIPT_PROP_MOD_RANGED=/gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/scripts/SC/03_specificity_alternativescore.R
PREFIX="/gpfs/projects/bsc83/Data/Ebola/02_scRNA-Seq_PBMCs/01_scRNA-Seq_inVivo_rhemac10/05_RObjects"
ININVIVO=${PREFIX}"/03_prep/03_immune.combined.ready.rds"
DF_CELLTYPE_INVIVO=${PREFIX}"/05_stats/df_celltype.rds"
srun Rscript ${SCRIPT_TAU} ${ININVIVO} ${PREFIX}"/05_stats/00_specificity/03_specificity_tau.rds"
srun Rscript ${SCRIPT_PROP_MOD_RANGED} ${DF_CELLTYPE_INVIVO} ${PREFIX}"/05_stats/00_specificity/04_specificity_alternativescore.rds"
