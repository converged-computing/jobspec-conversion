#!/bin/bash
#SBATCH --job-name=pav-mgs
#SBATCH --account=loni_virus2023
#SBATCH --output=slurm-%j.out-%N
#SBATCH --error=slurm-%j.err-%N
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --partition=workq
#SBATCH --constraint=ntasks-per-node=48

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
            -1 results/trimmed/16_1_S1.R1.fastq.gz \
            -2 results/trimmed/16_1_S1.R2.fastq.gz \
            # -o results/assembly/test/16_1_S1/
            -o results/assembly/16_1_S1/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/16_2_S2.R1.fastq.gz \
            -2 results/trimmed/16_2_S2.R2.fastq.gz \
            -o results/assembly/test/16_2_S2/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/16_3_S3.R1.fastq.gz \
            -2 results/trimmed/16_3_S3.R2.fastq.gz \
            -o results/assembly/test/16_3_S3/
             spades.py --version
        export OMP_NUM_THREADS=48
spades.py --meta \
    --threads 48 \
    -1 results/trimmed/16_4_S4.R1.fastq.gz \
    -2 results/trimmed/16_4_S4.R2.fastq.gz \
    -o results/assembly/test/16_4_S4/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/16_5_S5.R1.fastq.gz \
            -2 results/trimmed/16_5_S5.R2.fastq.gz \
            -o results/assembly/test/16_5_S5/
 spades.py --version
        export OMP_NUM_THREADS=48
        spades.py --meta \
            --threads 48 \
            -1 results/trimmed/Blank_8_15_23_S26.R1.fastq.gz \
            -2 results/trimmed/Blank_8_15_23_S26.R2.fastq.gz \
            -o results/assembly/test/Blank_8_15_23_S26/    
