#!/bin/bash
#FLUX: --job-name=lovely-cattywampus-1216
#FLUX: --urgency=16

spack load -r r@3.5.0
i=$SLURM_ARRAY_TASK_ID
Rscript /athena/elementolab/scratch/anm2868/GTEx/GTEx_infil/scripts/GeneticAnalysis/shuffled_data/Empirical_Brown_pval_shuffled.R $i
