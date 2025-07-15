#!/bin/bash
#FLUX: --job-name=reclusive-motorcycle-7977
#FLUX: -t=86400
#FLUX: --priority=16

echo "START"
date
cd /data/zhanglab/zpimentel/ChIP-Seq/02_mapping
module load Bowtie2/2.4.2-GCC-9.3.0
module load SAMtools/1.9-foss-2018b
module load BEDTools/2.30.0-GCC-10.2.0
ID=$(head -n $SLURM_ARRAY_TASK_ID ../sample.list | tail -n 1 | cut -f1)
bowtie2 --threads 9 -x GRCh38 -U ../01_raw_data/${ID}_1.fastq -S ./mapping_out/${ID}.sam --no-unal --very-sensitive-local
samtools view -S -b ./mapping_out/${ID}.sam > ./mapping_out/${ID}.bam
samtools sort ./mapping_out/${ID}.bam -o ./mapping_out/${ID}_sorted.bam
bamToBed -i ./mapping_out/${ID}_sorted.bam > ./mapping_out/${ID}.bed
echo "DONE"
date
