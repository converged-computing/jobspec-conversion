#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=32
#SBATCH --no-requeue

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
