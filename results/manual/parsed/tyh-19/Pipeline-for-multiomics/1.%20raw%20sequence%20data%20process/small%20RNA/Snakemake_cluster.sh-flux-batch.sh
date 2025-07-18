#!/bin/bash
#FLUX: --job-name=snakemake_cluster
#FLUX: --queue=CN_BIOT
#FLUX: --urgency=16

mkdir -p cluster_log
snakefile="small_pipeline" #"QIAseq_pipeline"
echo "start at `date`"
snakemake --rerun-incomplete --nolock \
	-s ${snakefile} -j 80 --latency-wait 60 \
	--cluster-config Snakemake_cluster.json \
	--cluster "sbatch -p {cluster.partition} -N {cluster.nodes} -n {cluster.ntasks} --job-name {cluster.jobname} --partition {cluster.partition} --output {cluster.output} --error {cluster.error}" > cluster_log/0.${snakefile}.log 2> cluster_log/0.${snakefile}.err
echo "end at `date`"
