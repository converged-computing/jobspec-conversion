#!/bin/bash
#SBATCH --job-name=overarching
#SBATCH --account=kwigg1
#SBATCH --output=Logs/%x-%j.out
#SBATCH --mail-user=hegartyb@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=300mb
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=1

source /etc/profile.d/http_proxy.sh
if [[ $SLURM_JOB_NODELIST ]] ; then
    echo "Running on"
    scontrol show hostnames $SLURM_JOB_NODELIST
    echo -e "\n"
fi
snakemake --profile /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping/Config --latency-wait 60 --use-conda --conda-prefix /home/hegartyb/miniconda3/envs/ --snakefile Snakefile-overarching --keep-going --rerun-incomplete
