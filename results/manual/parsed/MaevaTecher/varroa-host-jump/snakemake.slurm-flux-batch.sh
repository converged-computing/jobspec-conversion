#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --urgency=16

snakemake --restart-times 1 -j 500 -p --max-jobs-per-second 1 --cluster-config cluster.json --cluster "sbatch  -p {cluster.partition} --cpus-per-task {cluster.cpus-per-task} -t {cluster.time} --mem {cluster.mem}" --rerun-incomplete --notemp --nolock 
