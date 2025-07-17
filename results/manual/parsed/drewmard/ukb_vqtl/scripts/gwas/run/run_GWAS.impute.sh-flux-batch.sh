#!/bin/bash
#FLUX: --job-name=vQTL
#FLUX: --urgency=16

echo "Activating environment..."
source activate vQTL
echo "Starting..."
spack load -r r@3.5.0
Rscript /home/anm2868/scripts/UKB/061719_Rserve.R
pheno=/athena/elementolab/scratch/anm2868/vQTL/ukb_vqtl/output/GWAS/preprocess/phenotypes_processed.80.txt
dir=/athena/elementolab/scratch/anm2868/vQTL/UKB/Neale_GWAS/andrew_copies
outdir=/athena/elementolab/scratch/anm2868/vQTL/ukb_vqtl/output/imputed
mkdir -p $outdir
mkdir -p $outdir/MAF
mkdir -p $outdir/results
phenoName=$1
CHR=$SLURM_ARRAY_TASK_ID
echo "Chromosome $CHR analysis..."
prefix=ukbb.$CHR.impute
echo "muQTL testing..."
outdir=/athena/elementolab/scratch/anm2868/vQTL/ukb_vqtl/output/imputed/results
plink --bfile $dir/$prefix --pheno $pheno --pheno-name $phenoName --assoc --out $outdir/$prefix.$phenoName.muGWAS
echo "Complete."
