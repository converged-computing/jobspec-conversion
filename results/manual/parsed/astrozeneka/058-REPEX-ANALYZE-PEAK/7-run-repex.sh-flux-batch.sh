#!/bin/bash
#FLUX: --job-name=carnivorous-latke-1177
#FLUX: --urgency=16

module load Singularity/3.3.0
genomes=(
  "SRR7062760"
)
cd data/raw_map
for genome in "${genomes[@]}"
do
  singularity exec shub://repeatexplorer/repex_tarean seqclust \
      -p -t -c 64 -v "repex-${genome}" \
      "data/raw_map/${genome}_mapped.fasta"
  echo "Done"
done
