#!/bin/bash
#FLUX: --job-name=star_align
#FLUX: -N=3
#FLUX: -c=12
#FLUX: --queue=memory
#FLUX: -t=64800
#FLUX: --urgency=16

module load easybuild
module load icc/2017.1.132-GCC-6.3.0-2.27
module load impi/2017.1.132
module load STAR/2.5.3a
REFERENCE_GENOME="/home/ssnyder3/nereus/aging_rnaseq/genomes/dpulex/ncbi-genomes-2023-05-22/indexDirectory_modload"
FASTQ_DIR="/home/ssnyder3/nereus/aging_rnaseq/raw_fastq/pulex_rawfastqs"
OUTPUT_DIR="/home/ssnyder3/nereus/aging_rnaseq/star_alignment/pulex/starAlign_output_modload"
mkdir -p "$OUTPUT_DIR"
  # Extract the base filename without the extension
for fileR1 in $FASTQ_DIR/*R1_001.fastq.gz; do
    # Extract the file name without extension
    filename=$(basename "$fileR1" _R1_001.fastq.gz)
    echo $fileR1
    # Determine the corresponding R2 file
    fileR2="${fileR1/_R1/_R2}" #newvariablename=${oldvariablename//oldtext/newtext}
    # Run STAR alignment
    STAR --runThreadN 4 \
          --genomeDir $REFERENCE_GENOME \
          --readFilesIn $fileR1 $fileR2 \
	  --quantMode GeneCounts \
	  --readFilesCommand zcat \
	  --outSAMtype BAM SortedByCoordinate \
          --outFileNamePrefix $OUTPUT_DIR/$filename"_"
done
