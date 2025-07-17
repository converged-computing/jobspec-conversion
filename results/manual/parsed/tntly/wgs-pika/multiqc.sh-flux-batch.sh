#!/bin/bash
#FLUX: --job-name=multiqc
#FLUX: -c=16
#FLUX: --urgency=16

cd /home/tly/wgs-pika/results/multiqc/
module purge
module load intel-python3
multiqc /home/tly/wgs-pika/results/before-fastp-fastqc/
