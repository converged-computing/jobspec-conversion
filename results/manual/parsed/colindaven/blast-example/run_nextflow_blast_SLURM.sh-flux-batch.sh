#!/bin/bash
#FLUX: --job-name=blast_start
#FLUX: -t=1080000
#FLUX: --urgency=16

echo "Input file: " $1
fasta=$1
PWD="pwd"
NXF_ASSETS="$PWD/$fasta.assets"
NXF_TEMP="$PWD/$fasta.temp"
NXF_WORK="$PWD/$fasta.work"
. /mnt/ngsnfs/tools/miniconda3/etc/profile.d/conda.sh
blastdb=/lager2/rcug/seqres/nt_db/nt
nextflow /ngsssd1/rcug/nextflow_blast/main3.nf -c /ngsssd1/rcug/nextflow_blast/nextflow1.conf --query $fasta --db $blastdb --chunkSize 100 -with-report $fasta.report.html -with-timeline $fasta.timeline.html -with-trace > $1.csv
