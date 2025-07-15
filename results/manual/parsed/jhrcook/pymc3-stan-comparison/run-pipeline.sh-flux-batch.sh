#!/bin/bash
#FLUX: --job-name=gassy-destiny-9990
#FLUX: --urgency=16

module unload python
module load gcc conda2 slurm-drmaa/1.1.3
source "$HOME/.bashrc"
conda activate ppl-comp-smk
snakemake \
    --jobs 9990 \
    --restart-times 0 \
    --latency-wait 120 \
    --use-conda \
    --keep-going \
    --printshellcmds \
    --drmaa " -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J}" \
    --cluster-config "pipeline_config.yaml"
conda deactivate
exit 44
