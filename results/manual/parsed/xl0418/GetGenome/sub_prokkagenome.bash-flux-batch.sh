#!/bin/bash
#FLUX: --job-name=bumfuzzled-punk-6699
#FLUX: -n=2
#FLUX: -t=600
#FLUX: --urgency=16

module load parallel/20180222
module load singularity/3.3.0
sh prokka_genomes.sh 2 221117-1910.P16N-S.16S.dna-sequences.tsv
