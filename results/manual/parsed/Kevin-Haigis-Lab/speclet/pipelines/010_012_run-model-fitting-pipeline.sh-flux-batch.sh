#!/bin/bash
#FLUX: --job-name=fit-pipe
#FLUX: --urgency=16

module load gcc/6.2.0 slurm-drmaa/1.1.3 conda2
source "$HOME/.bashrc"
conda activate speclet_smk
SNAKEFILE="pipelines/010_010_model-fitting-pipeline.smk"
DRMAA_TEMPLATE=" --account=park -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J} --gres=gres:{cluster.gres}"
snakemake \
    --snakefile $SNAKEFILE \
    --jobs 9995 \
    --latency-wait 300 \
    --rerun-incomplete \
    --drmaa "${DRMAA_TEMPLATE}" \
    --cluster-config pipelines/010_011_smk-config.yaml \
    --keep-going \
    --printshellcmds #\
    #--forceall
conda deactivate
exit 4
