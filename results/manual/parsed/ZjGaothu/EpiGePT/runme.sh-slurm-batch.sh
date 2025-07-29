#!/bin/bash
#SBATCH --output=output_pre.txt
#SBATCH --error=error_pre.txt
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=250G
#SBATCH --time=7-00:00:00
#SBATCH --partition=whwong

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
