#!/bin/bash
#FLUX: --job-name=SLURM_MetaP
#FLUX: -n=5
#FLUX: -t=259200
#FLUX: --priority=16

source ~/.bashrc
source activate metaphlan3
cd Metaphlan3_snakemake  
snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} --mem={cluster.m}"  --cluster-config config/cluster.yaml -j 60 --latency-wait 15
