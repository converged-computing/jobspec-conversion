#!/bin/bash
#FLUX: --job-name=frigid-poo-6776
#FLUX: --priority=16

module load bioinfo-tools
module load bwa
module load velvet
module load abyss
module load samtools
python GlenX.py --vcf ../GlenX_data/P2109_103_fake6.vcf --bam /proj/b2016296/private/vanja/GlenX_data/P2109_103.clean.dedup.recal.bam --tab /proj/b2016296/private/vanja/GlenX_data/P2109_103.vcf.tab --ID P2109_103 --bwa_ref /proj/b2016296/private/nobackup/annotation/human_g1k_v37.fasta
