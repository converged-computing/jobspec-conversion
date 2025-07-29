#!/bin/bash
#SBATCH --job-name=blast_start
#SBATCH --mail-user=<your_email>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15000
#SBATCH --time=12-12:00:00
#SBATCH --partition=old

echo "Input file: " $1
fasta=$1
PWD="pwd"
NXF_ASSETS="$PWD/$fasta.assets"
NXF_TEMP="$PWD/$fasta.temp"
NXF_WORK="$PWD/$fasta.work"
. /mnt/ngsnfs/tools/miniconda3/etc/profile.d/conda.sh
blastdb=/lager2/rcug/seqres/nt_db/nt
nextflow /ngsssd1/rcug/nextflow_blast/main3.nf -c /ngsssd1/rcug/nextflow_blast/nextflow1.conf --query $fasta --db $blastdb --chunkSize 100 -with-report $fasta.report.html -with-timeline $fasta.timeline.html -with-trace > $1.csv
