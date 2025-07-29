#!/bin/bash
#SBATCH --job-name=lassoScratch
#SBATCH --output=%x-%a-%A.SLURMout
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=512G
#SBATCH --time=5-23:59:00
#SBATCH --array=1-5

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
