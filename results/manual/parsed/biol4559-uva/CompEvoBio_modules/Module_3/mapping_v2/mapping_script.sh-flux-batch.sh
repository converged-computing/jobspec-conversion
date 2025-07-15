#!/bin/bash
#FLUX: --job-name=joyous-itch-2954
#FLUX: --priority=16

  module load singularity
  #SLURM_ARRAY_TASK_ID=1
  sampleId=$( cat $4 | sed "${SLURM_ARRAY_TASK_ID}q;d" | cut -f3 -d',' )
  srr=$( cat $4 | sed "${SLURM_ARRAY_TASK_ID}q;d" | cut -f1 -d',' )
  numFlies=$( cat $4 | sed "${SLURM_ARRAY_TASK_ID}q;d" | cut -f2 -d',' )
  echo ${sampleId}
  echo ${srr}
  echo ${numFlies}
if [ -f /project/biol4559-aob2x/mapping_output/${sampleId}.sync.gz ]; then
  echo "Job already done"
  exit
fi
if [ ! -f /project/biol4559-aob2x/mapping_output/${sampleId}.sync.gz ]; then
  echo "Running job now"
  ### If your reads are Paired End use this version (and delete the other)
    singularity run \
    $1/dest_v2.6.1_latest.sif \
    $2/${srr}_1.fastq.gz \
    $2/${srr}_2.fastq.gz \
    ${sampleId} \
    $3 \
    --cores $SLURM_CPUS_PER_TASK \
    --max-cov 0.95 \
    --min-cov 4 \
    --base-quality-threshold 25 \
    --num-flies ${numFlies} \
    --do_poolsnp
  ### If your reads are Single End use this version (and delete the other)
    singularity run \
    $1/dest_v2.6.1_latest.sif \
    $2/${srr}.fastq.gz \
    ${sampleId} \
    $3 \
    --cores $SLURM_CPUS_PER_TASK \
    --max-cov 0.95 \
    --min-cov 4 \
    --base-quality-threshold 25 \
    --num-flies ${numFlies} \
    --do_poolsnp \
    --single_end
    ### do not delete anything after this line
fi
