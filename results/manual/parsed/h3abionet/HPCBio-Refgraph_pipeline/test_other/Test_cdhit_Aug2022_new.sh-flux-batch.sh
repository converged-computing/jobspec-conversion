#!/bin/bash
#FLUX: --job-name=cd-hit-test
#FLUX: -n=2
#FLUX: --urgency=16

cd /home/groups/h3abionet/RefGraph/results/NeginV_Test_Summer2021/results/annotation
module load CD-HIT/4.8.1-IGB-gcc-8.2.0
identity_array=(90 92 94 96 99)
for i in ${identity_array[@]}
do
if (( ${i} >= 90 && ${i} < 95 )); then
wordsize='8'
echo "${i} is between 90 - 95 so word size is ${wordsize}"
elif (( ${i} >= 95 && ${i} < 100 )); then
wordsize='10'
echo "${i} is between 95 - 100 so word size is ${wordsize}"
else
    echo "[[${i} is out of defined range in this script. Please edit the code to define. See below]]"
    echo "
 # * Word size 10-11 is for thresholds 0.95 ~ 1.0
 # * Word size 8,9 is for thresholds 0.90 ~ 0.95
 # * Word size 7 is for thresholds 0.88 ~ 0.9
 # * Word size 6 is for thresholds 0.85 ~ 0.88
 # * Word size 5 is for thresholds 0.80 ~ 0.85
 # * Word size 4 is for thresholds 0.75 ~ 0.8
 "
fi
newi=$(echo "0.$i")
cd-hit-est \
-i Merged_Reads/masurca/merged_sequences_GRCH38_decoys.fasta \
-o Cluster_CDHIT/masurca/clustered_GRCH38_decoys_n5_i${i}.fasta \
-c ${newi} \
-n ${wordsize} \
-T $SLURM_NPROCS
done
for i in ${identity_array[@]}
do
if (( ${i} >= 90 && ${i} < 95 )); then
wordsize='8'
echo "${i} is between 90 - 95 so word size is ${wordsize}"
elif (( ${i} >= 95 && ${i} < 100 )); then
wordsize='10'
echo "${i} is between 95 - 100 so word size is ${wordsize}"
else
    echo "[[${i} is out of defined range in this script. Please edit the code to define. See below]]"
    echo "
 # * Word size 10-11 is for thresholds 0.95 ~ 1.0
 # * Word size 8,9 is for thresholds 0.90 ~ 0.95
 # * Word size 7 is for thresholds 0.88 ~ 0.9
 # * Word size 6 is for thresholds 0.85 ~ 0.88
 # * Word size 5 is for thresholds 0.80 ~ 0.85
 # * Word size 4 is for thresholds 0.75 ~ 0.8
 "
fi
newi=$(echo "0.$i")
cd-hit-est \
-i Merged_Reads/megahit/merged_sequences_GRCH38_p0.fasta \
-o Cluster_CDHIT/megahit/clustered_GRCH38_p0_n5_i${i}.fasta \
-c ${newi} \
-n ${wordsize} \
-T $SLURM_NPROCS
done
for i in ${identity_array[@]}
do
if (( ${i} >= 90 && ${i} < 95 )); then
wordsize='8'
echo "${i} is between 90 - 95 so word size is ${wordsize}"
elif (( ${i} >= 95 && ${i} < 100 )); then
wordsize='10'
echo "${i} is between 95 - 100 so word size is ${wordsize}"
else
    echo "[[${i} is out of defined range in this script. Please edit the code to define. See below]]"
    echo "
 # * Word size 10-11 is for thresholds 0.95 ~ 1.0
 # * Word size 8,9 is for thresholds 0.90 ~ 0.95
 # * Word size 7 is for thresholds 0.88 ~ 0.9
 # * Word size 6 is for thresholds 0.85 ~ 0.88
 # * Word size 5 is for thresholds 0.80 ~ 0.85
 # * Word size 4 is for thresholds 0.75 ~ 0.8
 "
fi
newi=$(echo "0.$i")
cd-hit-est \
-i Merged_Reads/masurca/merged_sequences_GRCH38_p0.fasta \
-o Cluster_CDHIT/masurca/clustered_GRCH38_p0_n5_i${i}.fasta \
-c ${newi} \
-n ${wordsize} \
-T $SLURM_NPROCS
done
for i in ${identity_array[@]}
do
if (( ${i} >= 90 && ${i} < 95 )); then
wordsize='8'
echo "${i} is between 90 - 95 so word size is ${wordsize}"
elif (( ${i} >= 95 && ${i} < 100 )); then
wordsize='10'
echo "${i} is between 95 - 100 so word size is ${wordsize}"
else
    echo "[[${i} is out of defined range in this script. Please edit the code to define. See below]]"
    echo "
 # * Word size 10-11 is for thresholds 0.95 ~ 1.0
 # * Word size 8,9 is for thresholds 0.90 ~ 0.95
 # * Word size 7 is for thresholds 0.88 ~ 0.9
 # * Word size 6 is for thresholds 0.85 ~ 0.88
 # * Word size 5 is for thresholds 0.80 ~ 0.85
 # * Word size 4 is for thresholds 0.75 ~ 0.8
 "
fi
newi=$(echo "0.$i")
cd-hit-est \
-i Merged_Reads/megahit/merged_sequences_CHM13.fasta \
-o Cluster_CDHIT/megahit/clustered_CHM13_n5_i${i}.fasta \
-c ${newi} \
-n ${wordsize} \
-T $SLURM_NPROCS
done
for i in ${identity_array[@]}
do
if (( ${i} >= 90 && ${i} < 95 )); then
wordsize='8'
echo "${i} is between 90 - 95 so word size is ${wordsize}"
elif (( ${i} >= 95 && ${i} < 100 )); then
wordsize='10'
echo "${i} is between 95 - 100 so word size is ${wordsize}"
else
    echo "[[${i} is out of defined range in this script. Please edit the code to define. See below]]"
    echo "
 # * Word size 10-11 is for thresholds 0.95 ~ 1.0
 # * Word size 8,9 is for thresholds 0.90 ~ 0.95
 # * Word size 7 is for thresholds 0.88 ~ 0.9
 # * Word size 6 is for thresholds 0.85 ~ 0.88
 # * Word size 5 is for thresholds 0.80 ~ 0.85
 # * Word size 4 is for thresholds 0.75 ~ 0.8
 "
fi
newi=$(echo "0.$i")
cd-hit-est \
-i Merged_Reads/masurca/merged_sequences_CHM13.fasta \
-o Cluster_CDHIT/masurca/clustered_CHM13_n5_i${i}.fasta \
-c ${newi} \
-n ${wordsize} \
-T $SLURM_NPROCS
done
