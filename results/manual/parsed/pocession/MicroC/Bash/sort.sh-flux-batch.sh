#!/bin/bash
#FLUX: --job-name=sort
#FLUX: --queue=rimlsfnwi
#FLUX: -t=3600
#FLUX: --urgency=16

wd=/ceph/rimlsfnwi/data/cellbio/mhlanga/thsieh
sub=microC
inputDir=$wd/$sub/fastq
outputDir=$wd/$sub/sorted
parsed=$wd/$sub/parsed
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
pairtools sort --nproc 16 --tmpdir=$temp/$basename $parsed/$basename/parsed.pairsam > $outputDir/$basename/sorted.pairsam
