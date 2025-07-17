#!/bin/bash
#FLUX: --job-name=frigid-itch-7686
#FLUX: -n=20
#FLUX: --queue=_______
#FLUX: -t=7200
#FLUX: --urgency=16

module load gcc/9.2.0 openmpi/3.1.6 R/4.2.1
for i in $(ls ../mapped/*.bam)
do
    f=`echo $i | awk -F"Aligned.sortedByCoord.out.bam" '{print $1}'`    
    Rscript bcr_analysis.R --sample $(basename $f)
done
