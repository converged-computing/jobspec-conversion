#!/bin/bash
#SBATCH --job-name=align
#SBATCH --output=%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --partition=compute

. $HOME/.bashrc 
. ~/sasha_env/bin/activate
snakemake -j 999 -p --cluster-config cluster.json --cluster "sbatch  -p {cluster.partition} -n {cluster.n}" 
< none
