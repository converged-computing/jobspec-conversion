#!/bin/bash
#FLUX: --job-name=lc1_job
#FLUX: -t=900
#FLUX: --urgency=16

module load GCC Python
module load Pysam
python livecoding.py -b 2.bam
