#!/bin/bash
#FLUX: --job-name=lovable-taco-3455
#FLUX: --queue=hbfraser
#FLUX: -t=32400
#FLUX: --priority=16

module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/mappingMutationCalling_pipeline/
snakemake --keep-going --snakefile SnakefileSeqdepth.smk --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --nolock --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
