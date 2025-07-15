#!/bin/bash
#FLUX: --job-name=gwas
#FLUX: -c=16
#FLUX: -t=21600
#FLUX: --priority=16

export COMORMENT='/cluster/projects/p697/github/comorment'
export SINGULARITY_BIND='$COMORMENT/containers/reference:/REF:ro'
export SIF='$COMORMENT/containers/singularity'
export PLINK2='singularity exec --home $PWD:/home $SIF/gwas.sif plink2'
export REGENIE='singularity exec --home $PWD:/home $SIF/gwas.sif regenie'

module load singularity/3.7.1
export COMORMENT=/cluster/projects/p697/github/comorment
export SINGULARITY_BIND="$COMORMENT/containers/reference:/REF:ro"
export SIF=$COMORMENT/containers/singularity
export PLINK2="singularity exec --home $PWD:/home $SIF/gwas.sif plink2"
export REGENIE="singularity exec --home $PWD:/home $SIF/gwas.sif regenie"
$PLINK2  --bfile /REF/examples/regenie/example_3chr --no-pheno  --chr ${SLURM_ARRAY_TASK_ID} --glm hide-covar --pheno run2.pheno --covar run2.covar --out run2_chr${SLURM_ARRAY_TASK_ID}
