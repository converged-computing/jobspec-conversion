#!/bin/bash
#SBATCH --job-name=sort
#SBATCH --output=./log/arr_%x-%A-%a.out
#SBATCH --error=./log/arr_%x-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=100G
#SBATCH --time=01:00:00
#SBATCH --partition=rimlsfnwi
#SBATCH --array=1

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
