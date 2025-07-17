#!/bin/bash
#FLUX: --job-name=bwa-array
#FLUX: -n=4
#FLUX: --queue=brc
#FLUX: -t=590700
#FLUX: --urgency=16

module load apps/bwa/0.7.17-singularity
number=$SLURM_ARRAY_TASK_ID
paramfile=bwa_param.txt
inr1=`sed -n ${number}p $paramfile | awk '{print $1}'`
inr2=`sed -n ${number}p $paramfile | awk '{print $2}'`
outsam=`sed -n ${number}p $paramfile | awk '{print $3}'`
bwa mem -t 4 /users/k1625253/scratch/old-scratch_rosalind-legacy-import_2020-01-28/Data/MetaData/GenomeIndex/hg38_bwa/hg38.fa $inr1 $inr2 > $outsam
