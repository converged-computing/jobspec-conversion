#!/bin/bash
#FLUX: --job-name=chocolate-leader-9627
#FLUX: --priority=16

module load bioinfo-tools 
module load star/2.7.9a
module load StringTie/2.1.4
module load samtools
READ1=${1:?msg}                         #read file names (includes path)
READ2=${2:?msg}
READ1_f=${3:?msg}						#read file names (does not include path)
READ2_f=${4:?msg}            
SRCDIR=${5:?msg}                        #read name of output folder                       
SRCDIR_INI=$(pwd)                                                                                      #remember initial path 
cd $SRCDIR
STAR \
      --runMode alignReads \
      --runThreadN 3 \
      --outSAMstrandField intronMotif \
      --genomeDir /home/larshook/LarsH/FastZ/RNAseq_Lsin/STAR_index/ \
      --readFilesIn $READ1 $READ2 \
      --readFilesCommand zcat \
      --outFileNamePrefix $SRCDIR/ \
      --twopassMode Basic \
      --sjdbGTFfile /proj/uppoff2020002/private/result_files/Leptidea/Annotation/Lsin_swe/gff/LsinapisSweM.all.maker.genes.gff \
      --sjdbGTFtagExonParentGene Parent \
      --sjdbGTFtagExonParentTranscript ID
cd $SRCDIR
samtools view -bS Aligned.out.sam > Aligned.out.bam
samtools sort Aligned.out.bam -o Aligned.out.sorted.bam
samtools index Aligned.out.sorted.bam
samtools flagstat Aligned.out.sorted.bam > STAR_flagstat.txt
samtools idxstats Aligned.out.sorted.bam > STAR_idxstats.txt
cd $SRCDIR
mkdir stringtie_2
stringtie \
      Aligned.out.sorted.bam \
      -p 3 \
      -o $SRCDIR/stringtie_2/STAR.Aligned.out.gtf \
      -A $SRCDIR/stringtie_2/STAR.Aligned.out.gene_abund.tab \
      -G /proj/uppoff2020002/private/result_files/Leptidea/Annotation/Lsin_swe/gff/LsinapisSweM.all.maker.genes.gff \
      -C $SRCDIR/stringtie_2/STAR.fully_covered_transcripts.gtf \
      -e 
