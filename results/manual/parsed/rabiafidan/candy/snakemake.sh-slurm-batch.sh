#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=%j.txt
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=3-00:00:00
#SBATCH --partition=cpu

source ~/.bashrc
conda activate snakemake
snakemake -n --latency-wait 100 --rerun-incomplete -p \
--cluster "sbatch --ntasks 1 --cpus-per-task {threads} --partition cpu --job-name {rule} --time 5:00:00 -e logs/{rule}/{params.err} -o logs/{rule}/{params.out} --mem {resources.mem_mb} --parsable" \
--jobs 500 --keep-going --use-envmodules --cluster-status ./status-sacct.sh
