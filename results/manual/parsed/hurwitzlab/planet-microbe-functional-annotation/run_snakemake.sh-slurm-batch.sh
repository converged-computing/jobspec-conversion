#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10gb
#SBATCH --time=1-00:00:00

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
