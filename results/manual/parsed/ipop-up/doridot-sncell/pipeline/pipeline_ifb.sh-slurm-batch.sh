#!/bin/bash
#SBATCH --job-name=sncell-pipeline
#SBATCH --output=sncell-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

echo '########################################'
echo 'Date:' $(date --iso-8601=seconds)
echo 'User:' $USER
echo 'Host:' $HOSTNAME
echo 'Job Name:' $SLURM_JOB_NAME
echo 'Job Id:' $SLURM_JOB_ID
echo 'Directory:' $(pwd)
echo '########################################'
echo 'Pipeline SNCell version: v0.1.0'
echo '-------------------------'
echo 'Main module versions:'
start0=`date +%s`
module purge
module load conda snakemake/6.5.0
module load R
conda --version
python --version
echo 'snakemake' && snakemake --version
echo '-------------------------'
echo 'PATH:'
echo $PATH
echo '########################################'
snakemake --cluster "sbatch -c {threads} --mem={resources.mem_gb}G" --use-conda --jobs=10 --retries 3
