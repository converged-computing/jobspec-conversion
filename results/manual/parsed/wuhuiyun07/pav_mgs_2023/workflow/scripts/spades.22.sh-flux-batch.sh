#!/bin/bash
#FLUX: --job-name=pav-mgs
#FLUX: --queue=workq
#FLUX: -t=259200
#FLUX: --urgency=16

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
            -1 results/trimmed/22_1_S6.R1.fastq.gz \
            -2 results/trimmed/22_1_S6.R2.fastq.gz \
            -o results/assembly/test/22_1_S6/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/22_2_S7.R1.fastq.gz \
            -2 results/trimmed/22_2_S7.R2.fastq.gz \
            -o results/assembly/test/22_2_S7/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/22_3_S8.R1.fastq.gz \
            -2 results/trimmed/22_3_S8.R2.fastq.gz \
            -o results/assembly/test/22_3_S8/
             spades.py --version
        export OMP_NUM_THREADS=48
spades.py --meta \
    --threads 48 \
    -1 results/trimmed/22_4_S9.R1.fastq.gz \
    -2 results/trimmed/22_4_S9.R2.fastq.gz \
    -o results/assembly/test/22_4_S9/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/22_5_S10.R1.fastq.gz \
            -2 results/trimmed/22_5_S10.R2.fastq.gz \
            -o results/assembly/test/22_5_S10/
