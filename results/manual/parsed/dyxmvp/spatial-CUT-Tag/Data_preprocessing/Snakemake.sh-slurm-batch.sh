#!/bin/bash
#FLUX: --job-name=Snakemake
#FLUX: -c=20
#FLUX: --queue=general
#FLUX: -t=432000
#FLUX: --urgency=16

SLURM_ARGS="-p {cluster.partition} -J {cluster.job-name} -n {cluster.ntasks} -c {cluster.cpus-per-task} \
--mem={cluster.mem} -t {cluster.time} --mail-type={cluster.mail-type} --mail-user={cluster.mail-user} \
-o {cluster.output} -e {cluster.error}"
snakemake -j 20 --cluster-config cluster.json --cluster "sbatch $SLURM_ARGS"
