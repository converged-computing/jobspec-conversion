#!/bin/bash
#FLUX: --job-name=maggie
#FLUX: --queue=quick
#FLUX: -t=14400
#FLUX: --urgency=16

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
