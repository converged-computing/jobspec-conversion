#!/bin/bash
#SBATCH --job-name=ofa-test
#SBATCH --account=YOUR_ACCOUNT
#SBATCH --output=log/hpc/slurm-%j_%x.out
#SBATCH --mail-user=YOUR_EMAIL
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=1

source /etc/profile.d/http_proxy.sh  # required for internet on the Great Lakes cluster
time snakemake --profile config/slurm --latency-wait 90 --configfile config/config_test.yaml
