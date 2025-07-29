#!/bin/bash
#FLUX: --job-name=multiplex
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load easybuild intel/2017a python3/3.6.1
python3 /projects/bgmp/adoe/624/multiplex/demulti.py -f1 /projects/bgmp/shared/2017_sequencing/1294_S1_L008_R1_001.fastq.gz -f2 /projects/bgmp/shared/2017_sequencing/1294_S1_L008_R2_001.fastq.gz -f3 /projects/bgmp/shared/2017_sequencing/1294_S1_L008_R3_001.fastq.gz -f4 /projects/bgmp/shared/2017_sequencing/1294_S1_L008_R4_001.fastq.gz -i /projects/bgmp/adoe/624/multiplex/indexes.txt
