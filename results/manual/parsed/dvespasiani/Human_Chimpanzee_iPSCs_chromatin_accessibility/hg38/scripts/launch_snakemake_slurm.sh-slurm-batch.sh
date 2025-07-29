#!/bin/bash
#SBATCH --job-name=hg38_atac_pipeline
#SBATCH --account=punim0586
#SBATCH --output=./slurm_report/slurm.out
#SBATCH --mail-user=dvespasiani@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20000
#SBATCH --time=2-23:00:00
#SBATCH --partition=mig

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
source /usr/local/module/spartan_new.sh
module load web_proxy
module load gcc/8.3.0 openmpi/3.1.4
module load python/3.7.4 
module load r/4.0.0  
module load snakemake/5.18.1
module load bedtools/2.27
module load samtools/1.9
module load samstat/1.5.1
module load openssl/1.1.1f
module load bowtie2/2.3.5.1 
module load ucsc/21072020
module load trimmomatic/0.39-java-11.0.2
module load fastqc/0.11.9-java-11.0.2
module load macs2/2.2.7.1-python-3.7.4
module load deeptools/3.3.1-python-3.7.4
module load picard/2.6.0-java-11.0.2
module load star/2.7.3a
module load subread/2.0.0
snakemake -s new_snake -j 999 --cluster-config env/cluster.yaml \
--cluster "sbatch -A {cluster.account} -t {cluster.time} \
 -p {cluster.partition} --nodes {cluster.nodes} --ntasks {cluster.ntasks} \
  --mem {cluster.mem} --mail-user {cluster.mail_user} --mail-type {cluster.mail_type} \
  --output {cluster.output}"
