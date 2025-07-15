#!/bin/bash
#FLUX: --job-name=cd-hit-test
#FLUX: --priority=16

cd /home/groups/h3abionet/RefGraph/results/NeginV_Test_Summer2021/results/annotation
module load CD-HIT/4.8.1-IGB-gcc-8.2.0
identity_array=(0.9 0.92 0.94 0.96 0.99)
if [identity < 0.95 && identity >= 0.90]
then
wordsize = '8'
else if [identity <= 1.0 && identity >= 0.95]
wordsize = '10'
fi
 # * Word size 10-11 is for thresholds 0.95 ~ 1.0
 # * Word size 8,9 is for thresholds 0.90 ~ 0.95
 # * Word size 7 is for thresholds 0.88 ~ 0.9
 # * Word size 6 is for thresholds 0.85 ~ 0.88
 # * Word size 5 is for thresholds 0.80 ~ 0.85
 # * Word size 4 is for thresholds 0.75 ~ 0.8
for i in ${identity_array[@]}
do
cd-hit-est \
-i Merged_Reads/megahit/merged_sequences_GRCH38_decoys.fasta \
-o Cluster_CDHIT/megahit/clustered_GRCH38_decoys_n5_i_${i}.fasta \
-c ${i} \
-n ${wordsize} \
-T $SLURM_NPROCS
done
