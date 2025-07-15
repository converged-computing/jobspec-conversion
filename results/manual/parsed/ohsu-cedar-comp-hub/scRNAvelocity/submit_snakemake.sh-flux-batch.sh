#!/bin/bash
#FLUX: --job-name=workflow_submission
#FLUX: --queue=exacloud
#FLUX: -t=126000
#FLUX: --priority=16

snakemake -j 100 --use-conda --rerun-incomplete  --printshellcmds --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -N {cluster.N}  -t {cluster.t} -o {cluster.o} -e {cluster.e} -J {cluster.J} -c {cluster.c} --mem {cluster.mem}" -s Snakefile --latency-wait 120 
