#!/bin/bash
#FLUX: --job-name=sector-coupled-euro-calliope-eurospores-3h
#FLUX: -c=2
#FLUX: --queue=compute
#FLUX: -t=14400
#FLUX: --urgency=16

cd ..;
conda activate eurocalliope_2022_02_08;
srun snakemake --use-conda --profile default "build/eurospores/outputs/2016_res_3h.nc"
