#!/bin/bash
#FLUX: --job-name=bricky-onion-5299
#FLUX: -t=604800
#FLUX: --urgency=16

ml load cuda/10.1.105
ml load cudnn/7.6.5
function overlapBin()
{
    #for file in data/encode/dseq_peaks/*.bed
    for file in data/encode/cseq_peaks/*.bed
    do
        output=${file/.bed/.128.overlap.bin}
        echo $file, $output
        bedtools intersect -wa -a data/encode/hg19.128.bed -b $file |uniq  > $output
    done
}
function getReadsCount()
{
    input_bam=$1
    len=$2
    fbed=${input_bam/bam/`echo $len`.bed}
    samtools index $input_bam
    bedtools multicov -bams $input_bam -bed data/encode/selected.$len.bin > $fbed
}
~/anaconda3/condabin/conda activate geformer
/home/users/liuqiao/anaconda3/envs/geformer/bin/python3.6 main.py
