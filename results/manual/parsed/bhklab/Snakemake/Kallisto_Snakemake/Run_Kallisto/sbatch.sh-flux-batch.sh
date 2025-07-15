#!/bin/bash
#FLUX: --job-name=run_kallisto
#FLUX: --urgency=16

source /cluster/home/sjahangi/.bashrc
module load python3
module load snakemake
snakemake -s Snakefile --latency-wait 100 -j 30 --cluster "sbatch -J {params.jobname} -o {params.output} --mem {params.memory} --ntasks {params.ntasks} -t {params.runtime} -p {params.partition} -c {params.threads} --mail-type {cluster.mail_type} --mail-user {cluster.email}" --cluster-config cluster_config.yaml
