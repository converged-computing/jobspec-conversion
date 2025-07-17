#!/bin/bash
#FLUX: --job-name=kaiju
#FLUX: -c=16
#FLUX: --urgency=16

module load Anaconda3
source activate microbiome
sample_name=$(basename /data2/ssmith/unmapped_fastqs/"$SLURM_ARRAY_TASK_ID"_*_1.fastq _1.fastq)
kaiju -t /data3/ssmith/ena/kaijudb/nodes.dmp \
-z 40 \
-m 11 \
-v \
-f /data3/ssmith/ena/kaijudb/kaiju_db_progenomes.fmi \
-i /data2/ssmith/unmapped_fastqs/"$sample_name"_1.fastq \
-j /data2/ssmith/unmapped_fastqs/"$sample_name"_2.fastq \
-o /data2/ssmith/kaiju_output/"$sample_name"_kaiju.out
