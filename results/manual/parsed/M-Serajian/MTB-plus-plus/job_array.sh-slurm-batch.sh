#!/bin/bash
#FLUX: --job-name=31mer_analysis
#FLUX: -c=16
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='16'

date;
export OMP_NUM_THREADS=16
ml python
ml perl
perl 31mer_analysis.pl \
    -i resistant_genomes.csv \
    -o . \
    -b /blue/boucher/share/MTB/MTB_Database/BV_BRC_corrected \
    -f fna \
    -t /blue/boucher/share/MTB/MTB_Database/BV_BRC_MTB++_temp_files
date;
