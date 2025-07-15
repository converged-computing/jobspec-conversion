#!/bin/bash
#FLUX: --job-name=fish6_verkko
#FLUX: -c=32
#FLUX: --queue=norm
#FLUX: -t=864000
#FLUX: --urgency=16

module load verkko/1.3.1
module load snakemake/7.7.0
module load R/4.2.0
module load bedtools/2.30.0
module load samtools/1.9
module load gcc/9.2.0
module load python/3.7
cd /data/okendojo/zebrafish/data/fish6/asm
hifi=/data/okendojo/zebrafish/data/fish6/hifi/*.gz
ontData=/data/okendojo/zebrafish/data/fish6/ontData/*.gz
verkko -d fish6t2t --hifi ${hifi} --nano ${ontData} --slurm --graphaligner --mbg 
