#!/bin/bash
#SBATCH --job-name=workflow_submission
#SBATCH --output=logs/workflow_submission_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-11:00:00

snakemake -j 100 --use-conda --rerun-incomplete  --printshellcmds --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -N {cluster.N}  -t {cluster.t} -o {cluster.o} -e {cluster.e} -J {cluster.J} -c {cluster.c} --mem {cluster.mem}" -s Snakefile --latency-wait 120 
