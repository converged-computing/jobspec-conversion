#!/bin/bash
#FLUX: --job-name=IsONformDrosophila
#FLUX: -t=864000
#FLUX: --urgency=16

set -o errexit
module load gcc/9.3.0
snakemake --keep-going -j 999999 --cluster "sbatch -A {cluster.account} -C {cluster.C} -c {cluster.cpus-per-task} -N {cluster.Nodes}  -t {cluster.runtime} -J {cluster.jobname} --mail-type={cluster.mail_type} --mail-user={cluster.mail}" --cluster-config cluster.json --configfile cluster_config.json --latency-wait 100 --verbose -n
