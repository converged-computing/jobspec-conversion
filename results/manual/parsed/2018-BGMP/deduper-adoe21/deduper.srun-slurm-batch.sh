#!/bin/bash
#FLUX: --job-name=deduper3
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

ml purge
ml samtools/1.5 
module load easybuild intel/2017a python3/3.6.1
samtools sort -O sam /projects/bgmp/shared/deduper/Dataset3.sam > /projects/bgmp/adoe/deduper/Dataset3.sam
python3 deduper.py -s /projects/bgmp/adoe/deduper/Dataset3.sam -u /projects/bgmp/adoe/deduper/STL96.txt
