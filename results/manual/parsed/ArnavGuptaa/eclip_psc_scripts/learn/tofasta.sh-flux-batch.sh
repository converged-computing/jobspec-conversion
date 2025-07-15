#!/bin/bash
#FLUX: --job-name=bloated-platanos-5848
#FLUX: --priority=16

set -x
GENOME=/path/to/genome/hg38.fa 
module load anaconda3 
module load bedtools
conda activate pytorch 
echo "input bed: " $1
python ./tofasta.py --bed $1
bedtools getfasta \
-fi /media/alvin/Elements/genomes/hg38/Homo_sapiens_assembly38.fasta \
-bed ./temp.bed > $2
rm ./temp.bed
conda deactivate
