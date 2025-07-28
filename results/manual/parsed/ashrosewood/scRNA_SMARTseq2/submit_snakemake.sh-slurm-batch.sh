#!/bin/bash
#FLUX: --job-name=workflow_submission
#FLUX: --queue=exacloud
#FLUX: -t=126000
#FLUX: --urgency=16

snakemake -j 100 --rerun-incomplete --use-conda --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -N {cluster.N}  -t {cluster.t} -o {cluster.o} -e {cluster.e} -J {cluster.J} -c {cluster.c} --mem {cluster.mem}" -s Snakefile --latency-wait 60
