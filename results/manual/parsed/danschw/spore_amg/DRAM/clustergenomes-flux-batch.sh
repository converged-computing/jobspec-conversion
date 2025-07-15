#!/bin/bash
#FLUX: --job-name=chunky-nunchucks-5517
#FLUX: -n=10
#FLUX: --queue=wrighton-hi
#FLUX: -t=784800
#FLUX: --urgency=16

cd /home/projects/Sporulation_AMG/hmp/vMAG/
Cluster_genomes_5.1.pl -f /home/projects/Sporulation_AMG/hmp/vMAG/hmp_ge10kb_sporAMG_viruses.fasta -c 85 -i 95 -t 10
