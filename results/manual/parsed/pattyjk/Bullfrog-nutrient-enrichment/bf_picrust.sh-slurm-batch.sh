#!/bin/bash
#SBATCH --job-name=bf_picrust
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --mail-user=patrick.kearns@umb.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=48gb
#SBATCH --time=08:00:00

source activate picrust2
cd /hpcstor6/scratch01/p/patrick.kearns/Bullfrog_nut_enrich
picrust2_pipeline.py -s rep_seqs/dna-sequences.fasta -o picrust_norm -i asv_table/feature-table.biom
picrust2_pipeline.py -s rep_seqs/dna-sequences.fasta -o picrust_no_norm -i asv_table/feature-table.biom --skip_norm
