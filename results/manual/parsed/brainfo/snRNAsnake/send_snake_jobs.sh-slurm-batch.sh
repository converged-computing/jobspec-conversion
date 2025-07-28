#!/bin/bash
#FLUX: --job-name=snakemake_pcos_qc
#FLUX: -c=19
#FLUX: --queue=core
#FLUX: -t=360
#FLUX: --urgency=16

module purge
ml conda
conda init bash
ml bioinfo-tools
ml snakemake
snake_base_dir="/proj/snic2022-6-176/nobackup/private/human_placenta/pcos/workflow"
cd ${snake_base_dir}
snakemake -s Snakefile -j 19 --use-conda
