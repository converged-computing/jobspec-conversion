#!/bin/bash
#FLUX: --job-name=ABQIH
#FLUX: --queue=short
#FLUX: -t=18000
#FLUX: --urgency=16

module load easybuild
module load prl
module load python/3.6.0
cd /home/abubie/qual_ind_swp
./Qual_Index_Swp.py -r1 /projects/bgmp/2017_sequencing/1294_S1_L008_R1_001.fastq -r2 /projects/bgmp/2017_sequencing/1294_S1_L008_R4_001.fastq -i1 /projects/bgmp/2017_sequencing/1294_S1_L008_R2_001.fastq -i2 /projects/bgmp/2017_sequencing/1294_S1_L008_R3_001.fastq -indf /home/abubie/qual_ind_swp/index.tsv -q_cut 35
echo $"Index/Qual analysis is complete"
