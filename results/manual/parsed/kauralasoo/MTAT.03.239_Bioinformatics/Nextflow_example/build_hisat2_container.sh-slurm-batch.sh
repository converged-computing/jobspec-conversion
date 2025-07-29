#!/bin/bash
#SBATCH --job-name=nf-featureCounts
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module load any/singularity/3.7.3
module load squashfs/4.4
singularity build hisat2.img docker://quay.io/eqtlcatalogue/rnaseq_hisat2:v22.03.01
