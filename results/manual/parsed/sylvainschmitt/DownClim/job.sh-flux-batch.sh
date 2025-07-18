#!/bin/bash
#FLUX: --job-name=DownClim
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load bioinfo/Snakemake/7.20.0 # snakemake depending on your HPC
module load containers/singularity/3.9.9 # singularity depending on your HPC
CONFIG=config/ressources.genologin.yaml # to adapt to your HPC
COMMAND="sbatch --cpus-per-task={cluster.cpus} 
                --time={cluster.time} --mem={cluster.mem} 
                -J {cluster.jobname} 
                -o snake_subjob_log/{cluster.jobname}.%N.%j.out 
                -e snake_subjob_log/{cluster.jobname}.%N.%j.err"
CORES=100
mkdir -p snake_subjob_log
snakemake \
  -s Snakefile \
  --use-singularity \
  -j $CORES \
  --cluster-config $CONFIG \
  --cluster "$COMMAND" \
  --keep-going
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
