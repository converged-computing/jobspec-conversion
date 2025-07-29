#!/bin/bash
#SBATCH --job-name=pantro5_atac_pipeline
#SBATCH --account=punim0586
#SBATCH --output=./slurm_report/slurm.out
#SBATCH --mail-user=dvespasiani@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=400000
#SBATCH --time=10-23:00:00

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
