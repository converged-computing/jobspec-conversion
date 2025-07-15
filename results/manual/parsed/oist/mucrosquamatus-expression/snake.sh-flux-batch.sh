#!/bin/bash
#FLUX: --job-name=align
#FLUX: -c=4
#FLUX: --queue=compute
#FLUX: --priority=16

. $HOME/.bashrc 
. ~/sasha_env/bin/activate
snakemake -j 999 -p --cluster-config cluster.json --cluster "sbatch  -p {cluster.partition} -n {cluster.n}" 
