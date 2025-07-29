#!/bin/bash
#SBATCH --output=logs/02_amptk_preprocess.%A.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=64gb

CPU=2
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
module load amptk
OUT=results/amptk
mkdir -p $OUT
IN=$(realpath input)
BASE=ChihuahuanCrust_PRJNA748083
pushd $OUT
if [ ! -f $BASE.demux.fq.gz ]; then
 	amptk illumina -i $IN --merge_method vsearch -f ITS1-F -r ITS2 --require_primer off \
		-o $BASE --usearch usearch10 --cpus $CPU --rescue_forward on --primer_mismatch 2 -l 250
fi
popd
