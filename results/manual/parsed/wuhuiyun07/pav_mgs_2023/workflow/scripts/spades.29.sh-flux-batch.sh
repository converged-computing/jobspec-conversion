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
            -1 results/trimmed/29_1_S21.R1.fastq.gz \
            -2 results/trimmed/29_1_S21.R2.fastq.gz \
            -o results/assembly/test/29_1_S21/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/29_2_S22.R1.fastq.gz \
            -2 results/trimmed/29_2_S22.R2.fastq.gz \
            -o results/assembly/test/29_2_S22/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/29_3_S23.R1.fastq.gz \
            -2 results/trimmed/29_3_S23.R2.fastq.gz \
            -o results/assembly/test/29_3_S23/
             spades.py --version
        export OMP_NUM_THREADS=48
spades.py --meta \
    --threads 48 \
    -1 results/trimmed/29_4_S24.R1.fastq.gz \
    -2 results/trimmed/29_4_S24.R2.fastq.gz \
    -o results/assembly/test/29_4_S24/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/29_5_S25.R1.fastq.gz \
            -2 results/trimmed/29_5_S25.R2.fastq.gz \
            -o results/assembly/test/29_5_S25/
