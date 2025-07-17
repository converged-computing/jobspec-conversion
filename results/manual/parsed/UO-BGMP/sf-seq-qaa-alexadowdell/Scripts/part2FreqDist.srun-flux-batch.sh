#!/bin/bash
#FLUX: --job-name=AD_freq2
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --urgency=16

ml easybuild GCC/6.3.0-2.27 OpenMPI/2.0.2 Python/3.6.1
pip list installed | grep numpy
python part2FreqDist.py -f1 22_3H_both_S16_L008_R1_001.fastq  -f2 22_3H_both_S16_L008_R2_001.fastq  \
-f3 32_4G_both_S23_L008_R1_001.fastq -f4 32_4G_both_S23_L008_R2_001.fastq
