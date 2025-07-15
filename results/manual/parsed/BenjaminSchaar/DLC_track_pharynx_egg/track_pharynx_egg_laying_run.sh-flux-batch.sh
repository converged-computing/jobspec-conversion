#!/bin/bash
#FLUX: --job-name=evasive-noodle-0276
#FLUX: --priority=16

OPT="sbatch -p {cluster.partition} --cpus-per-task {cluster.cpus_per_task} --mem {cluster.mem} --output {cluster.output}"
snakemake --snakefile track_pharynx_egg_laying --cores 1 --latency-wait 60 --cluster "$OPT" --cluster-config track_pharynx_egg_laying_cluster_config.yaml -j 1
