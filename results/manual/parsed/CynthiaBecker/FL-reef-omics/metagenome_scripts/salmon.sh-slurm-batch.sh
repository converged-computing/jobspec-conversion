#!/bin/bash
#SBATCH --job-name=salmon
#SBATCH --output=logs/salmon_%j.log
#SBATCH --mail-user=cbecker@whoi.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=150gb
#SBATCH --time=12:00:00
#SBATCH --partition=compute
#SBATCH --qos=unlim

cd /vortexfs1/home/cbecker/FLK2019NextSeq/output/salmonquant/
for file in *_1.fastq.gz
do
tail1=_1.fastq.gz
tail2=_2.fastq.gz
BASE=${file/$tail1/}
salmon quant --meta -i MG_index --libType A \
        -1 $BASE$tail1 -2 $BASE$tail2 -o $BASE.quant \
        -p 36
done
