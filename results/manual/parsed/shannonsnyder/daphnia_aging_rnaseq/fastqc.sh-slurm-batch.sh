#!/bin/bash
#FLUX: --job-name=fastqc
#FLUX: -c=8
#FLUX: --queue=short
#FLUX: -t=10800
#FLUX: --urgency=16

module load fastqc/0.11.5
module load easybuild
module load icc/2017.1.132-GCC-6.3.0-2.27
module load impi/2017.1.132
module load ifort/2017.1.132-GCC-6.3.0-2.27                                                                                          
module load eb-hide/1                                                                                        
module load eb-hide/1
module load MultiQC/1.3-Python-3.6.1
mkdir fastqc_out
mkdir multiqc_out
OUTDIR=fastqc_out
FASTQDIR=/home/ssnyder3/nereus/aging_rnaseq/raw_fastq
/usr/bin/time fastqc -o $OUTDIR -t 6 $FASTQDIR/*.fastq.gz
/usr/bin/time multiqc $OUTDIR -o multiqc_out
