#!/bin/bash
#FLUX: --job-name=alga
#FLUX: --urgency=16

module load gcc/7.4.0
module load bowtie/1.0.0
module load bowtie2/2.2.3
module load samtools/1.6.0
printf "[+] Alga ("alga"):\t"
ALGA --file1=${filtered_reads1} --file2=${filtered_reads2} --threads=8 --output=${contigs}
printf "Alga ended with code $?\n"
