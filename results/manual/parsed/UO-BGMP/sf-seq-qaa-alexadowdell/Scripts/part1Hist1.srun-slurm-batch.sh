#!/bin/bash
#FLUX: --job-name=AD_R1
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

ml easybuild GCC/6.3.0-2.27 OpenMPI/2.0.2 Python/3.6.1
python part1Hist1.py -f 22_3H_both_S16_L008_R1_001.fastq 
