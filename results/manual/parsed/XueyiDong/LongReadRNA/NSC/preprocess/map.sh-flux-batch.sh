#!/bin/bash
#FLUX: --job-name=eccentric-caramel-4605
#FLUX: -c=12
#FLUX: -t=172800
#FLUX: --urgency=16

export PATH='$PATH:/wehisan/home/allstaff/d/dong.x/Programs/minimap2'

export PATH=$PATH:/wehisan/home/allstaff/d/dong.x/Programs/minimap2
module load samtools/1.7
workdir=/wehisan/general/academic/seq_data/quentin/Nanopore/Smchd1-NSC-cDNA/
juncbed=/wehisan/home/allstaff/d/dong.x/annotation/Mouse/gencode.junction.bed
annofa=/wehisan/home/allstaff/d/dong.x/annotation/Mouse/mm10/mm10.fa
datadir=./data/rebasecall/pass/merged/used
bamdir=./results/rebasecall/minimap2_mm10
cd $workdir
mkdir -p ./results/rebasecall/minimap2_mm10
for sample in barcode07 barcode{10..13} barcode{15..17} 
do minimap2 -ax splice -uf -k14 --junc-bed  $juncbed $annofa $datadir/$sample.fq.gz | samtools view -b | samtools sort > $bamdir/$sample.sorted.bam
samtools index $bamdir/$sample.sorted.bam $bamdir/$sample.sorted.bam.bai
done
