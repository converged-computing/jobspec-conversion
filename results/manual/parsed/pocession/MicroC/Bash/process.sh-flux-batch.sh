#!/bin/bash
#FLUX: --job-name=process
#FLUX: --queue=rimlsfnwi
#FLUX: -t=3600
#FLUX: --priority=16

wd=/ceph/rimlsfnwi/data/cellbio/mhlanga/thsieh
sub=microC
inputDir=$wd/$sub/fastq
outputDir=$wd/$sub/output
hg38=$wd/GRCh38/GRCh38.primary_assembly.genome.fa
hg38genome=$wd/GRCh38/GRCh38.primary_assembly.genome
temp=$wd/$sub/temp
cd $inputDir
inputfile_list=($inputDir/*.gz)
inputfile=${inputfile_list[$SLURM_ARRAY_TASK_ID-1]}
basename_temp=${inputfile%_R1.fastq.gz}
basename=${basename_temp##*/}
if [ -d "$outputDir/$basename" ]; then
        echo "outputDir/$basename exists."
        rm -r $outputDir/$basename
fi
mkdir $outputDir/$basename
if [ -d "$temp/$basename" ]; then
        echo "temp/$basename exists."
        rm -r $temp/$basename
fi
mkdir $temp/$basename
bwa mem -5SP -T0 -t16 $hg38 $inputDir/${basename}_R1.fastq.gz $inputDir/${basename}_R2.fastq.gz| \
pairtools parse --min-mapq 40 --walks-policy 5unique \
--max-inter-align-gap 30 --nproc-in 8 --nproc-out 8 --chroms-path $hg38genome | \
pairtools sort --tmpdir=$temp --nproc 16|pairtools dedup --nproc-in 8 \
--nproc-out 8 --mark-dups --output-stats $outputDir/$basename/stats.txt|pairtools split --nproc-in 8 \
--nproc-out 8 --output-pairs $outputDir/$basename/mapped.pairs --output-sam -|samtools view -bS -@16 | \
samtools sort -@16 -o $outputDir/$basename/mapped.PT.bam;samtools index $outputDir/$basename/mapped.PT.bam
