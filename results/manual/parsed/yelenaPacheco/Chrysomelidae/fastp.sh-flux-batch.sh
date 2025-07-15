#!/bin/bash
#FLUX: --job-name=swampy-bits-1100
#FLUX: --urgency=16

if [ ! -d trimmed_reads ]
then
   mkdir -p trimmed_reads
fi
if [ ! -d fastp_trimming_docs ]
then
  mkdir -p fastp_trimming_docs
fi
module load miniconda
source activate /project/leafbeetle_phylogenomics/yelena/hybpiper
infile=$(cat input.list | head -n ${SLURM_ARRAY_TASK_ID} | tail -n1)
base=$(basename ${infile} _1.fastq)
fastp -w 4 --dont_overwrite --disable_quality_filtering --correction --length_required 21 \
--in1 ${base}_1.fastq --in2 ${base}_2.fastq \
--out1 trimmed_reads/${base}_P_R1.fastq --out2 trimmed_reads/${base}_P_R2.fastq \
--unpaired1 trimmed_reads/${base}_U.fastq --unpaired2 trimmed_reads/${base}_U.fastq \
--failed_out fastp_trimming_docs/${base}_failed.fastq \
-j fastp_trimming_docs/${base}.fastp_report.json \
-h fastp_trimming_docs/${base}.fastp_report.html
conda deactivate
