#!/bin/bash
#FLUX: --job-name=R
#FLUX: -c=10
#FLUX: --queue=a100
#FLUX: --urgency=16

export PATH='$PATH:~/HFS/code/'

module load gcc cuda
module load miniconda3
source activate sei
export PATH=$PATH:~/HFS/code/
project_id="UKB"
chunk=$SLURM_ARRAY_TASK_ID
line=$(awk -v id="$chunk" '$2 == id {print $0}' ~/HFS/int/chunkchr)
str=(${line// / })
chr=${str[0]}
CHR="${chr//"chr"}"
cd ~/HFS/$project_id/${chr}/$chunk
for file in *fa.gz ; do
gunzip $file
id=${file%%.*}
python ~/HFS/code/fasta_cli.py $id.fa int/
python ~/HFS/code/sc.py int/${id}_predictions.h5 
paste <(cut -f2- int/${id}_row_labels.txt) <(cut -f2- int/${id}_predictions.txt  | awk -v OFS="\t" '{for (i=1; i<=NF; i++) printf "%.2f%s", $i, (i==NF?"\n":" \t")}' )   | gzip > $id.sei.gz
rm $id.fa
rm $id.fa.fai
rm -r int/
done
Rscript ~/HFS/code/splitsei.r
