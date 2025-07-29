#!/bin/bash
#SBATCH --job-name=101-merge
#SBATCH --account=proj5057
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=5-00:00:00
#SBATCH --partition=memory

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
