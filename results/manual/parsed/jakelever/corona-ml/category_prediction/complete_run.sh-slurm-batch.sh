#!/bin/bash
#SBATCH --job-name=corona_optimize
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=4-00:00:00
#SBATCH --partition=rbaltman

set -ex
snakemake -j 100 --cluster ' mysbatch -p rbaltman --mem 4G --gpus {params.gpucount} --time 4:00:00' --latency-wait 60 --nolock -p
