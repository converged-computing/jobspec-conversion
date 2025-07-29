#!/bin/bash
#SBATCH --job-name=SLURM_MetaP
#SBATCH --account=
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60gb
#SBATCH --time=3-00:00:00
#SBATCH --partition=

source ~/.bashrc
source activate metaphlan3
cd Metaphlan3_snakemake  
snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} --mem={cluster.m}"  --cluster-config config/cluster.yaml -j 60 --latency-wait 15
