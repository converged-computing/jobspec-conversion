#!/bin/bash
#FLUX: --job-name=blank-kerfuffle-3843
#FLUX: --queue=hbfraser,hns,normal
#FLUX: -t=43200
#FLUX: --urgency=16

module load conda
conda activate base
cd ~/scripts/FraserLab/transcriptome_diveristy/pipelines/
snakemake --nolock --printshellcmds --keep-going --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py" --snakefile  Snakefile_main.smk
