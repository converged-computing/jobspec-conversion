#!/bin/bash
#FLUX: --job-name=salmon
#FLUX: -c=36
#FLUX: --queue=compute
#FLUX: -t=43200
#FLUX: --urgency=16

cd /vortexfs1/home/cbecker/FLK2019NextSeq/output/salmonquant/
for file in *_1.fastq.gz
do
tail1=_1.fastq.gz
tail2=_2.fastq.gz
BASE=${file/$tail1/}
salmon quant --meta -i MG_index --libType A \
        -1 $BASE$tail1 -2 $BASE$tail2 -o $BASE.quant \
        -p 36
done
