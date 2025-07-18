#!/bin/bash
#FLUX: --job-name=LIH_GME
#FLUX: -c=3
#FLUX: --queue=batch
#FLUX: -t=86395
#FLUX: --urgency=16

conda activate bioinfo_tutorial
module load swenv/default-env/devel 
module load lang/R/3.6.0-foss-2019a-bare
cd /home/users/dkyriakis/PhD/Projects/Yahaya/Scripts/
snakemake --dag | dot -Tpdf > dag.pdf
snakemake --cores 6
