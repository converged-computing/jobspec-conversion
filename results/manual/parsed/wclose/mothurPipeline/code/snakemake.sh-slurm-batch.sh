#!/bin/bash
#SBATCH --job-name=clusterSnakemake
#SBATCH --account=ACCOUNT
#SBATCH --output=logs/slurm/%x-%j.out
#SBATCH --mail-user=EMAIL
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000mb
#SBATCH --time=2-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi
mkdir -p logs/slurm/
snakemake --use-conda --profile config/slurm/ --latency-wait 90
