#!/bin/bash
#FLUX: --job-name=bwa
#FLUX: -c=16
#FLUX: --queue=rimlsfnwi
#FLUX: -t=3600
#FLUX: --urgency=16

wd=/ceph/rimlsfnwi/data/cellbio/mhlanga/thsieh
sub=microC
inputDir=$wd/$sub/fastq
outputDir=$wd/$sub/mapped
hg38=$wd/GRCh38/GRCh38.primary_assembly.genome.fa
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
bwa mem -5SP -T0 -t16 $hg38 $inputDir/${basename}_R1.fastq.gz $inputDir/${basename}_R2.fastq.gz -o $outputDir/$basename/aligned.sam
