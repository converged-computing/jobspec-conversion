#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=compute
#FLUX: -t=10
#FLUX: --urgency=16

source activate varroa
snakemake -j 2 -p  --cluster-config cluster.json --cluster "sbatch  -p {cluster.partition} --cpus-per-task {cluster.cpus-per-task} -t {cluster.time} --mem {cluster.mem}"
