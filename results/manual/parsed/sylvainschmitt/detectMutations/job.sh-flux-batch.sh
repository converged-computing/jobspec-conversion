#!/bin/bash
#FLUX: --job-name=detMut
#FLUX: -t=345600
#FLUX: --urgency=16

module purge
module load bioinfo/snakemake-5.25.0
module load system/singularity-3.7.3
CONFIG=config/ressources.genologin.yaml
COMMAND="sbatch --cpus-per-task={cluster.cpus} --time={cluster.time} --mem={cluster.mem} -J {cluster.jobname} -o snake_subjob_log/{cluster.jobname}.%N.%j.out -e snake_subjob_log/{cluster.jobname}.%N.%j.err"
CORES=100
mkdir -p snake_subjob_log
snakemake -s Snakefile --use-singularity --singularity-args "\-\-containall" -j $CORES --cluster-config $CONFIG --cluster "$COMMAND" --keep-going
echo '########################################'
echo 'Date:' $(date --iso-8601=seconds)
echo 'User:' $USER
echo 'Host:' $HOSTNAME
echo 'Job Name:' $SLURM_JOB_NAME
echo 'Job ID:' $SLURM_JOB_ID
echo 'Number of nodes assigned to job:' $SLURM_JOB_NUM_NODES
echo 'Nodes assigned to job:' $SLURM_JOB_NODELIST
echo 'Directory:' $(pwd)
echo '########################################'
