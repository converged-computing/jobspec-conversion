#!/bin/bash
#SBATCH --job-name=dockerMap
#SBATCH --account=biol4559-aob2x
#SBATCH --output=/project/biol4559-aob2x/mapping_scripts/aob2x/logs/RunDest.%A_%a.out
#SBATCH --error=/project/biol4559-aob2x/mapping_scripts/aob2x/logs/RunDest.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=11
#SBATCH --mem=90G
#SBATCH --time=3-00:00:00
#SBATCH --partition=instructional

  module load singularity
  #SLURM_ARRAY_TASK_ID=1
  sampleId=$( cat $4 | sed "${SLURM_ARRAY_TASK_ID}q;d" | cut -f3 -d',' )
  srr=$( cat $4 | sed "${SLURM_ARRAY_TASK_ID}q;d" | cut -f1 -d',' )
  numFlies=$( cat $4 | sed "${SLURM_ARRAY_TASK_ID}q;d" | cut -f2 -d',' )
  echo ${sampleId}
  echo ${srr}
  echo ${numFlies}
  singularity run \
  $1/dest_v2.6_latest.sif \
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
  singularity run \
  $1/dest_v2.6_latest.sif \
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
