#!/bin/bash
#FLUX: --job-name=blank-lentil-8788
#FLUX: -n=32
#FLUX: -t=601800
#FLUX: --urgency=16

module load parallel/20180222
module load singularity/3.3.0
sh prokka_genomes_P16NS.sh 32 221117-1910.P16N-S.16S.dna-sequences.tsv
