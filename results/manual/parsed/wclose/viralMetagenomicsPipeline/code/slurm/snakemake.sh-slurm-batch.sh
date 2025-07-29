#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --account=ACCOUNT
#SBATCH --output=logs/slurm/%x-%j.out
#SBATCH --mail-user=EMAIL
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=1

source /etc/profile.d/http_proxy.sh 
if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi
snakemake --use-conda --verbose --profile config/slurm/  --latency-wait 90
