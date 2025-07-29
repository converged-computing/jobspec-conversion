#!/bin/bash
#SBATCH --job-name=assemblies
#SBATCH --account=kwigg1
#SBATCH --output=Logs/%x-%j.out
#SBATCH --mail-user=hegartyb@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000mb
#SBATCH --time=5-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

source /etc/profile.d/http_proxy.sh
if [[ $SLURM_JOB_NODELIST ]] ; then
    echo "Running on"
    scontrol show hostnames $SLURM_JOB_NODELIST
    echo -e "\n"
fi
snakemake --profile /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/Config --latency-wait 20 --use-conda --conda-prefix /home/hegartyb/miniconda3/envs/ --snakefile Snakefile_virsorter
