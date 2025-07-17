#!/bin/bash
#FLUX: --job-name=stardb
#FLUX: -c=16
#FLUX: --queue=batch
#FLUX: -t=259200
#FLUX: --urgency=16

cpus=16                   ## must match #SBATCH -c
index_n_bases=14          ## --genomeSAindexNbases [14]; set to min(14, log2(GenomeLength)/2 - 1)
container='/projects/researchit/crf/containers/crf_rnaseq.sif'
[ $# -eq 2 ] || {
  echo "Usage: sbatch stardb.sh <genome.fasta> <dir_out>" >&2
  exit 11
}
genome_fasta="$1"     ## load value of first argument "$1" into variable $genome_fasta
dir_out="$2"          ## load value of second argument "$2" into variable $dir_out
echo "genome_fasta:$genome_fasta"
echo "dir_out:$dir_out"
echo "index_n_bases:$index_n_bases"
echo "cpus:$cpus"
echo "container:$container"
module load singularity       ## make singularity command available
version=$(singularity exec "$container" STAR --version 2>&1)
[ $? -eq 0 ] || {
  echo "ERROR:star_version: $version" >&2
  exit 21
}
echo "star_version:$version"
echo "begin:$(date +'%Y%m%d%H%M%S')"
result=$(singularity exec "$container" STAR \
  --runThreadN $cpus \
  --runMode genomeGenerate \
  --genomeDir "$dir_out" \
  --genomeSAindexNbases $index_n_bases \
  --genomeFastaFiles "$genome_fasta" 2>&1)
[ $? -eq 0 ] || {
  echo "ERROR:star: $result" >&2
  exit 31
}
[ -n "$result" ] && echo "star_result:$result"
echo "finish:$(date +'%Y%m%d%H%M%S')"
