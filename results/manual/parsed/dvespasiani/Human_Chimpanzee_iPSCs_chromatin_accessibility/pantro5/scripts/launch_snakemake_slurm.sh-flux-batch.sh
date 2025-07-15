#!/bin/bash
#FLUX: --job-name="pantro5_atac_pipeline"
#FLUX: -c=20
#FLUX: --queue=mig
#FLUX: -t=946800
#FLUX: --priority=16

export TMPDIR='/data/scratch/projects/punim0586/dvespasiani/tmp'

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
source /usr/local/module/spartan_new.sh
module load web_proxy
module load r/4.0.0 
module load anaconda3/2020.07
if [ ! -d /data/scratch/projects/punim0586/dvespasiani/tmp ]; then
  mkdir -p /data/scratch/projects/punim0586/dvespasiani/tmp;
fi
export TMPDIR=/data/scratch/projects/punim0586/dvespasiani/tmp
source activate atac
snakemake -j 999 --cluster-config env/cluster.yaml --cluster "sbatch -A {cluster.account} -t {cluster.time} \
 -p {cluster.partition} --nodes {cluster.nodes} --ntasks {cluster.ntasks} \
  --mem {cluster.mem} --mail-user {cluster.mail_user} --mail-type {cluster.mail_type} \
  --output {cluster.output}"
