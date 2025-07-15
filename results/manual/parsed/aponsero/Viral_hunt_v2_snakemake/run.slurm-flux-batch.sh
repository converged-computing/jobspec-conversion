#!/bin/bash
#FLUX: --job-name=viral_hunt
#FLUX: -n=5
#FLUX: --queue=standard
#FLUX: -t=259200
#FLUX: --urgency=16

source activate viral_env
cd /xdisk/bhurwitz/mig2020/rsgrps/bhurwitz/alise/my_scripts/v2_Viral_hunt_snakemake
echo "snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} -mem={cluster.m}"  --cluster-config config/cluster.yaml -j 10 --latency-wait 15"
snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} --mem={cluster.m}"  --cluster-config config/cluster.yaml -j 30 --latency-wait 15
