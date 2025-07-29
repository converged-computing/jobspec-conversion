#!/bin/bash
#FLUX: --job-name=easel
#FLUX: -c=4
#FLUX: --queue=general
#FLUX: --urgency=16

module load nextflow
source activate envAGAT
nextflow run main.nf -w karl -with-report -with-timeline -with-dag acer_nf.png \
--species acer_negundo \
--genome /core/labs/Wegrzyn/easel-workshop/data/genome/chr1.fna \
--outdir . \
--sra /core/labs/Wegrzyn/easel-workshop/data/sra/acer_negundo.txt
