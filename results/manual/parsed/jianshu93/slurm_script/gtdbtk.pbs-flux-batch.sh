#!/bin/bash
#FLUX: --job-name=GWMC_gtdbtk
#FLUX: -c=32
#FLUX: --queue=ieg_lm,ieg_128g,ieg_64g
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
source ~/.bashrc
conda init bash
conda activate gtdbtk
which pplacer
which prodigal
wd=/condo/ieg/jianshu/GWMC/12.DAS_allbins_derep_renamed
output=/condo/ieg/jianshu/GWMC/12.DAS_allbins_derep_renamed_gtdbtk
/condo/ieg/jianshu/miniconda3/envs/gtdbtk/bin/gtdbtk classify_wf --genome_dir ${wd} --out_dir ${output} --cpus 32 --pplacer_cpus 8 -x fasta
