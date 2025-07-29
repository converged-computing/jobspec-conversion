#!/bin/bash
#SBATCH --job-name=analyze-peak-betta
#SBATCH --account=proj5057
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=5-00:00:00

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
