#!/bin/bash
#FLUX: --job-name=mut-prof_TSS
#FLUX: -c=3
#FLUX: -t=43200
#FLUX: --urgency=16

module load bedtools2
module load bedops
module load python
UPSTREAM="2000"
DOWNSTREAM="1000"
MUT_DATASET="$1"
TFBS_DATASET="$2"
RUN_ID="$3"
PACKAGE="$4"
_BENCHMARK="$5"
IFS='-|_'; read -ra run_args <<< "$RUN_ID"
TFBS_TYPE="${run_args[0]}"
TFBS_DHS="${run_args[1]}"
RUN_TYPE="${run_args[2]}"
MUT_FILE="../datasets/ssm/simple_somatic_mutation.open.${MUT_DATASET}.tsv"
TSS_FILE="../datasets/refseq_TSS_hg19_170929.bed"
TFBS_FILE="../datasets/tfbs/${TFBS_TYPE}TFBS-${TFBS_DHS}_${TFBS_DATASET}.bed"
GEN_FILE="../datasets/hg19/bedtools_hg19_sorted.txt"
MUT_CNTR="./data/ssm.open.${TFBS_TYPE}-${TFBS_DHS}_${RUN_TYPE}_${MUT_DATASET}_centered.bed"
BENCHMARK_FILE="./benchmark/${RUN_ID}.txt"
TFBS_CNTR="./data/supplementary/${TFBS_TYPE}TFBS-${TFBS_DHS}_${TFBS_DATASET}_center1000.bed"
awk '{center=int(($2+$3)/2); print $1"\t"(center-1000)"\t"(center+1000)"\t"$4}' "$TFBS_FILE" |
  sort -V > "$TFBS_CNTR"
TSS_REG="./data/supplementary/refseq_TSS_up${UPSTREAM}-down${DOWNSTREAM}.bed"
cut -f1-2 "$TSS_FILE" |  # select cols
 sort -V |  # sort
 awk '{diff=$2-"'$UPSTREAM'"; print $1"\t"(diff<0?0:diff)"\t"($2+"'$DOWNSTREAM'")}' > "$TSS_REG"
if [[ $_BENCHMARK -eq 0 ]]; then
  start_time=`python -c "from time import time; print(int(time()*1000))"`
fi
cut -f9-11,16-17 "$MUT_FILE" |  # select cols
  sed -e 1d |  # remove headers
  sed -e $'s/\t/>/4' |  # preprocess to BED format
  sed -e 's/^/chr/' |
  sort -V |
  uniq | # remove duplicates
  bedtools intersect -a - -b "$TSS_REG" -wa -sorted -g "$GEN_FILE" |  # intersect with assumed promoter regions
  bedtools intersect -a - -b "$TFBS_CNTR" -wa -wb -sorted -g "$GEN_FILE" |  # intersect with TFBS ±1000bp regions
  cut -f1-2,4,6,8 |
  awk '{dist=$2-$4-1000; print $1"\t"dist"\t"dist"\t"$3"\t"$5}' |
  sort -V > "$MUT_CNTR"
if [[ $_BENCHMARK -eq 0 ]]; then
  end_time=`python -c "from time import time; print(int(time()*1000))"`
  echo "${RUN_ID}_${MUT_DATASET}" >> "$BENCHMARK_FILE"
  echo "$((end_time-start_time)) ms" >> "$BENCHMARK_FILE"  # duration
  echo >> "$BENCHMARK_FILE"  # newline
fi
