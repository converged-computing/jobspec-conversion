#!/bin/bash
#FLUX: --job-name=snakeplot
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --priority=16

scontrol show job $SLURM_JOB_ID
module load snakemake
echo "testing slurm plus snakemake without snakecluster config file"
snakemake --rulegraph --snakefile $HOME/tflex/Snake_qcmapcount.smk \
--configfile $HOME/cocultureProj/src1/config_qcmapall.yaml \
--cores 1 | dot -Tpdf > figutest.pdf
echo "arrivederci"
