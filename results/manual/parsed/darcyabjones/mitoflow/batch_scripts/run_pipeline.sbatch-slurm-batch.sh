#!/bin/bash
#SBATCH --account=y95
#SBATCH --mail-user=darcy.a.jones@postgrad.curtin.edu.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=1-00:00:00

module load nextflow/19.01.0.5050-bin
nextflow run -resume -profile pawsey_zeus ./main.nf \
    --reference mitSN15.fasta \
    --seed mitSN15.fasta \
    --asm_table reads.tsv \
    --filter_table reads.tsv \
    --read_length 125 \
    --insert_size 600
