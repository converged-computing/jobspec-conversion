#!/bin/bash
#FLUX: --job-name=hanky-buttface-1926
#FLUX: --priority=16

spack load -r r@3.5.0
i=$SLURM_ARRAY_TASK_ID
dir=/athena/elementolab/scratch/anm2868/GTEx/GTEx_infil/output/GeneticAnalysis/GWAS
f1=$dir/GTEx.pheno$i.1.qassoc
f2=$dir/GTEx.pheno$i.2.qassoc
f3=$dir/GTEx.pheno$i.3.qassoc
Rscript /athena/elementolab/scratch/anm2868/GTEx/GTEx_infil/scripts/GeneticAnalysis/Merge_Chr_GWAS.R $i
