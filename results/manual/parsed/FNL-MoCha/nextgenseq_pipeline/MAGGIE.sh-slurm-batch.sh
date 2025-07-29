#!/bin/bash
#SBATCH --job-name=maggie
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=quick

export HOST='biowulf.nih.gov'
export NGS_PIPELINE='/data/MoCha/patidarr/ngs_pipeline/'
export WORK_DIR='`pwd`'

set -ep pipefail
module load snakemake/3.8.0
export HOST="biowulf.nih.gov"
export NGS_PIPELINE="/data/MoCha/patidarr/ngs_pipeline/"
export WORK_DIR="`pwd`"
mkdir -p log
rm -rf */20170910/qc/*.maggie.*
batch="sbatch -o log/{params.rulename}.%j.o -e log/{params.rulename}.%j.e --partition=quick --time=4:00:00 --mem=1G --cpus-per-task=2"
args="-p -r --nolock  --ri -k -p -T -r -j 300 --jobscript $NGS_PIPELINE/scripts/jobscript.sh --jobname {params.rulename}.{jobid}"
snakemake --directory $WORK_DIR --snakefile $NGS_PIPELINE/maggie.rules $args --cluster "$batch"
