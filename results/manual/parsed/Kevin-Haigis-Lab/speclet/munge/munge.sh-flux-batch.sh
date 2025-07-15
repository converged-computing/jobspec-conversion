#!/bin/bash
#FLUX: --job-name=stinky-eagle-2467
#FLUX: --priority=16

module load conda2 gcc slurm-drmaa R
source "$HOME/.bashrc"
conda activate speclet_smk
SNAKEFILE="munge/munge.smk"
snakemake \
    --snakefile $SNAKEFILE \
    --jobs 9997 \
    --restart-times 0 \
    --keep-going \
    --latency-wait 120 \
    --rerun-incomplete \
    --printshellcmds \
    --drmaa " --account=park -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J}" \
    --cluster-config munge/munge-config.json
conda deactivate
exit 44
