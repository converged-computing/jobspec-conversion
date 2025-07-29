#!/bin/bash
#SBATCH --job-name=starAlign-log
#SBATCH --output=starAlign.stdout
#SBATCH --mail-user=danielaz@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=08:00:00
#SBATCH --partition=intel

date
cd $SLURM_SUBMIT_DIR
module load star
STAR_INDEX=/rhome/danielaz/bigdata/transcriptomics/starIndex
DIR=/rhome/danielaz/bigdata/transcriptomics/raw_fastq
STAR --runThreadN 12 \
--readFilesIn PLACEHOLDER.forward.paired,PLACEHOLDER.foward.unpaired PLACEHOLDER.reverse.paired,PLACEHOLDER.reverse.paired \
--genomeDir ${STAR_INDEX} \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix PLACEHOLDER.map \
--outSAMunmapped Within
