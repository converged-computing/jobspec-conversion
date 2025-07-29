#!/bin/bash
#FLUX: --job-name=run_snakemake
#FLUX: --queue=cpu-short
#FLUX: -t=86400
#FLUX: --urgency=16

source $HOME/.bash_profile
conda activate aducanumab
cd ../..
pwd
snakemake -s Snakefile -j 20 --rerun-incomplete --latency-wait 60 --cluster "sbatch --mem=60G --output=scripts/01_preprocessing/logs/snakemake_job_logs/%x.%N.%j.stdout --error=scripts/01_preprocessing/logs/snakemake_job_logs/%x.%N.%j.stderr --partition=cpu-short --tasks=20 --time 05:00:00"
