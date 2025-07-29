#!/bin/bash
#SBATCH --job-name=map_standards
#SBATCH --account=duhaimem1
#SBATCH --output=Logs/%x-%j.out
#SBATCH --mail-user=klangenf@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000mb
#SBATCH --time=02:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

source /etc/profile.d/http_proxy.sh
if [[ $SLURM_JOB_NODELIST ]] ; then
    echo "Running on"
    scontrol show hostnames $SLURM_JOB_NODELIST
    echo -e "\n"
fi
DIR='/home/klangenf/anaconda/envs' ### Update to user specific anaconda environment locations
snakemake --profile Config --latency-wait 300 --use-conda --conda-prefix $DIR --conda-frontend mamba --snakefile Snakefile-map_standards
