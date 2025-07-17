#!/bin/bash
#FLUX: --job-name=101-merge
#FLUX: -c=32
#FLUX: --queue=memory
#FLUX: -t=432000
#FLUX: --urgency=16

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <genome_fasta>"
    echo "Please provide the path to the genome FASTA file as an argument."
    exit 1
fi
genome_fasta=$1
base_name=$(basename "$genome_fasta")
base_name="${base_name%.fasta}"
echo "Processing ${genome_fasta}"
mkdir -p data/repex-output
module load Singularity/3.3.0
singularity exec shub://repeatexplorer/repex_tarean seqclust \
    -p -t -c 120 -v "data/repex-output/${gebase_namenome}" \
    "${genome_fasta}"
