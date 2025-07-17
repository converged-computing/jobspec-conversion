#!/bin/bash
#FLUX: --job-name=chocolate-plant-6306
#FLUX: -t=43200
#FLUX: --urgency=16

Workdir=.
SSUsearch=ssusearch
Configfile=config.yaml
Clust_config=hpc/slurm/cluster.yaml
Jobscript=hpc/slurm/jobscript.sh
cd $Workdir
logdir=hpc-log
mkdir -p $logdir
QSUB="sbatch --nodes=1 --cpus-per-task={threads}"
QSUB="$QSUB --time={cluster.time} --mem={cluster.mem}"
QSUB="$QSUB --output=$logdir/{cluster.name}.%j.o"
$SSUsearch --configfile config.yaml --unlock
$SSUsearch                                \
    --configfile $Configfile              \
    --cores 100                           \
    --local-cores 1                       \
    --cluster-config $Clust_config        \
    --js $Jobscript                       \
    --cluster \""$QSUB"\"                 \
    --use-conda                           \
    --latency-wait 120                    \
    --rerun-incomplete                    \
    |& tee $logdir/snakemake.log
