#!/bin/bash
#FLUX: --job-name=dorado-gpu
#FLUX: -c=8
#FLUX: --queue=V4V32_SKY32M192_L
#FLUX: -t=172800
#FLUX: --urgency=16

pod5s=$1
container=/share/singularity/images/ccs/conda/lcc-conda-8-rocky8.sinf
module load ccs/singularity-3.8.2
singularity run --nv --app dorado034 $container dorado download --model dna_r9.4.1_e8_hac@v3.3
singularity run --nv --app dorado034 $container dorado basecaller --device 'cuda:all' dna_r9.4.1_e8_hac@v3.3 --emit-fastq $pod5s > ${pod5s/pod5_/}.fastq
