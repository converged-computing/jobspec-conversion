#!/bin/bash
#FLUX: --job-name=milky-bits-3885
#FLUX: -n=2
#FLUX: -t=86400
#FLUX: --urgency=16

source ~/.bashrc
source activate pm_env
cd $SLURM_SUBMIT_DIR
if [ -f results/interproscan.txt ]; then
    echo "removing interproscan.txt"
    rm results/interproscan.txt 
fi
if [ -f results/killed_interproscan.txt ]; then
    echo "removing killed_interproscan.txt"
    rm results/killed_interproscan.txt  
fi
snakemake --unlock
echo 'snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} -N {cluster.N} -mem={cluster.m} -e {cluster.e} -o {cluster.o}"  --cluster-config config/cluster.yml -j 30 --latency-wait 30'
snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} -N {cluster.N} --mem={cluster.m} -e {cluster.e} -o {cluster.o}"  --cluster-config config/cluster.yml -j 30 --latency-wait 30
