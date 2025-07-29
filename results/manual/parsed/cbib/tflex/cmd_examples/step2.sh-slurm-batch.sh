#!/bin/bash
#SBATCH --job-name=snakestar
#SBATCH --output=/mnt/cbib/thesis_gbm/mubriti_202303/scr1/slurm_output/snakestar_%j.out
#SBATCH --mail-user=juana7@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=12
#SBATCH --chdir=/mnt/cbib/thesis_gbm/mubriti_202303/scr1/

scontrol show job $SLURM_JOB_ID
tflexPath="/mnt/cbib/thesis_gbm/tflex"
configpath="/mnt/cbib/thesis_gbm/mubriti_202303/scr1/config_mapping.yml"
module load snakemake
module load fastp
module load multiQC
module load STAR/2.7.10a # new Star
echo "running mapping "
snakemake -s $tflexPath/Snake_starmp.smk --cores 1 -j 12 \
    --configfile $configpath --latency-wait=30
