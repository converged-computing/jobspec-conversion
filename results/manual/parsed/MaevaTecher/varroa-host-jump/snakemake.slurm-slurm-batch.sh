#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12G
#SBATCH --time=02:00:00

snakemake --restart-times 1 -j 500 -p --max-jobs-per-second 1 --cluster-config cluster.json --cluster "sbatch  -p {cluster.partition} --cpus-per-task {cluster.cpus-per-task} -t {cluster.time} --mem {cluster.mem}" --rerun-incomplete --notemp --nolock 
< none
