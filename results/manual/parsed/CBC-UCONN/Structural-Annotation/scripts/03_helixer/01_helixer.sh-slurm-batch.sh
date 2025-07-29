#!/bin/bash
#SBATCH --job-name=helixer
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=20G
#SBATCH --partition=gpu
#SBATCH --qos=general
#SBATCH --constraint=AVX2&FMA3

export TMPDIR='$PWD/tmp'

hostname
date
module load singularity/3.9.2
mkdir tmp
export TMPDIR=$PWD/tmp
OUTDIR=../../results/03_helixer/
mkdir -p ${OUTDIR}
GENOME=../../results/02_mask_repeats/repeatmasker/repeatmasker_out/GCF_000001735.4_TAIR10.1_genomic.fna.masked
singularity exec /isg/shared/databases/nfx_singularity_cache/helixer-docker_helixer_v0.3.0a0_cuda_11.2.0-cudnn8.sif Helixer.py --lineage land_plant --fasta-path ${GENOME} --gff-output-path ${OUTDIR}/Arabidopsis_thaliana.gff3
