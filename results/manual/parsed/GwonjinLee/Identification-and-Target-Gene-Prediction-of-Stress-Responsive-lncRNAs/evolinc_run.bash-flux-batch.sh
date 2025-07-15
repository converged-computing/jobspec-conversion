#!/bin/bash
#FLUX: --job-name=evolinc
#FLUX: -n=2
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

cd /blue/meixiazhao/lee.gwonjin/Soybean_project/lncRNA/evolinc
module load singularity
rm evolinc-i_1.7.5.sif
singularity pull docker://evolinc/evolinc-i:1.7.5
singularity run docker://evolinc/evolinc-i:1.7.5 \
-c /blue/meixiazhao/lee.gwonjin/Soybean_project/lncRNA/mapping/assembly/merged_asm_ref/Transctipts64Assembly.gtf \
-g /blue/meixiazhao/lee.gwonjin/Soybean_project/reference/genome/PhytozomeV13/Gmax/Wm82.a4.v1/assembly/Gmax_508_v4.0.fa \
-u /blue/meixiazhao/lee.gwonjin/Soybean_project/reference/genome/PhytozomeV13/Gmax/Wm82.a4.v1/annotation/Gmax_508_Wm82.a4.v1.gene.gff3 \
-b /blue/meixiazhao/lee.gwonjin/Soybean_project/reference/genome/PhytozomeV13/Gmax/TE/TE_seqforEvolinc/TE_sequences.fa \
-o evolinc_out \
-n 4
