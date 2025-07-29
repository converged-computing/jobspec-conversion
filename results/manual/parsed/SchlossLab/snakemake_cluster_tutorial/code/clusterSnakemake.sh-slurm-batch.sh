#!/bin/bash
#SBATCH --job-name=clusterSnakemake
#SBATCH --account=ACCOUNT
#SBATCH --output=code/log/%x-%j.out
#SBATCH --mail-user=EMAIL
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000mb
#SBATCH --time=00:45:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi
snakemake --profile config/slurm/ --latency-wait 20
