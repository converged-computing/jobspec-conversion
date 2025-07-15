#!/bin/bash
#FLUX: --job-name=red-kitty-2214
#FLUX: -c=10
#FLUX: --queue=long
#FLUX: --priority=16

Usage="svaba.sh <prefix> <reference_assembly.fa> <directory_containing_BAM_Files> <output_directory>"
echo "$Usage"
Prefix=$1
Assembly=$2
BamDir=$3
OutDir=$4
CWD=$PWD
WorkDir="$TMPDIR"
mkdir -p $WorkDir
cp -r $Assembly $WorkDir/.
cp $BamDir/*.bam $WorkDir/.
cp $BamDir/*.bam.bai $WorkDir/.
As=$(basename "$Assembly")
cd $WorkDir
bwa index $As
BamFiles=$(ls *.bam | sed -E "s/$/ -t /g" | tr -d '\n' | sed -E "s/ -t $/ /g")
svaba run -t $BamFiles -G $As -a "$Prefix"_sv -p 8
rm $As*
rm $BamFiles
rm *.bam.bai
mkdir -p $CWD/$OutDir
cp -r $WorkDir/* $CWD/$OutDir/.
