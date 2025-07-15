#!/bin/bash
#FLUX: --job-name=pav-mgs
#FLUX: --queue=workq             # the partition
#FLUX: -t=259200
#FLUX: --priority=16

export OMP_NUM_THREADS='48'
export WORK_DIR='/project/awlab/wuhuiyun/pav_mgs_2023'

export OMP_NUM_THREADS=48
module load snakemake
module load python
module load spades/3.13.0/gcc-9.3.0
export WORK_DIR=/project/awlab/wuhuiyun/pav_mgs_2023
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/24_1_S16.R1.fastq.gz \
            -2 results/trimmed/24_1_S16.R2.fastq.gz \
            -o results/assembly/test/24_1_S16/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/24_2_S17.R1.fastq.gz \
            -2 results/trimmed/24_2_S17.R2.fastq.gz \
            -o results/assembly/test/24_2_S17/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/24_3_S18.R1.fastq.gz \
            -2 results/trimmed/24_3_S18.R2.fastq.gz \
            -o results/assembly/test/24_3_S18/
             spades.py --version
        export OMP_NUM_THREADS=48
spades.py --meta \
    --threads 48 \
    -1 results/trimmed/24_4_S19.R1.fastq.gz \
    -2 results/trimmed/24_4_S19.R2.fastq.gz \
    -o results/assembly/test/24_4_S19/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/24_5_S20.R1.fastq.gz \
            -2 results/trimmed/24_5_S20.R2.fastq.gz \
            -o results/assembly/test/24_5_S20/
