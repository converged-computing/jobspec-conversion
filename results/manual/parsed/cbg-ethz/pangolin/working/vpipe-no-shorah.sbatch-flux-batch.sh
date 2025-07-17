#!/bin/bash
#FLUX: --job-name=COVID-vpipe-cons
#FLUX: -t=82800
#FLUX: --urgency=16

export SNAKEMAKE_PROFILE='$(realpath ../profiles/smk-simple-slurm/ )'

logfile=/cluster/scratch/bs-pangolin/log.$LSB_JOBID
exec > >(tee -a $logfile) 2>&1
function sendmail {
   # email proxy at bs-stadler04 since the smtp0 server is not reachable from euler directly:
   echo "see $logfile and $LSB_OUTPUTFILE" | ssh bs-pangolin@d@bs-stadler04.ethz.ch ./sendmail.sh \
	ivan.topolsky@bsse.ethz.ch carrara@nexus.ethz.ch shuqing.yu@nexus.ethz.ch \
        schmittu@ethz.ch \
        -s "'VPIPE FAILED: please check $LSB_OUTPUTFILE'"
}
trap sendmail ERR
set -e
umask 0007
./vpipe --configfile config.unlock.yaml --dryrun --unlock || exit 1
echo "Using proxy"
. /etc/profile.d/software_stack_default.sh
module load eth_proxy
echo "${https_proxy}"
mkdir -p cluster_logs/
export SNAKEMAKE_PROFILE=$(realpath ../profiles/smk-simple-slurm/ )
./vpipe --profile ${SNAKEMAKE_PROFILE}	\
	--configfile config.no-shorah.yaml --omit-from snv
