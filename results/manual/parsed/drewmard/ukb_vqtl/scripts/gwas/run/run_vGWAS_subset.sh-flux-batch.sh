#!/bin/bash
#FLUX: --job-name=vQTL
#FLUX: -n=4
#FLUX: --urgency=16

arg1=$SLURM_ARRAY_TASK_ID
phenoName=neutrophil.count.rint.ALL
phenoName=$1
numCores=4
echo "sbatch run_vGWAS_subset.sh $arg1 $phenoName $numCores"
echo "Activating environment..."
source activate vQTL
echo "Starting..."
echo "vQTL testing..."
x1="$(cut -f1 /athena/elementolab/scratch/anm2868/vQTL/UKB/Neale_GWAS/andrew_copies/subset/ID.impute.txt | head -${arg1} | tail -1)"
x2="$(cut -f2 /athena/elementolab/scratch/anm2868/vQTL/UKB/Neale_GWAS/andrew_copies/subset/ID.impute.txt | head -${arg1} | tail -1)"
FILE=/athena/elementolab/scratch/anm2868/vQTL/ukb_vqtl/output/vGWAS_subset/ukbb.$x1.$x2.$phenoName.txt
	echo "Let it run!"
	Rscript /athena/elementolab/scratch/anm2868/vQTL/ukb_vqtl/scripts/GWAS/subset/run_vGWAS.R $arg1 $phenoName $numCores
echo "Complete."
