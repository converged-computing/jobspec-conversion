#!/bin/bash
#FLUX: --job-name=lassoScratch
#FLUX: -t=518340
#FLUX: --urgency=16

module load GCC/8.3.0
module load Python/3.8.3
source 'PATHTOPYENV'
k=$SLURM_ARRAY_TASK_ID
echo $k
traitname=$1
OUTDIR='PARENT DIR TO OUTPUT'/$traitname/
mkdir -p $OUTDIR
genoPATH='PATH TO BEDMATRIX'
python3 lasso.pysnp.py --geno-path $genoPATH \
	--trait $traitname \
	--index-var $k \
	--output-directory $OUTDIR 
