#!/bin/bash
#FLUX: --job-name=nanopore_ann
#FLUX: -c=2
#FLUX: --queue=high
#FLUX: -t=2592000
#FLUX: --priority=16

module load bio3
snakemake -j 68 \
	--cluster "sbatch -p {cluster.partition} -N {cluster.nodes} -t {cluster.time} -n {cluster.cpus} --mem={cluster.mem} -J {cluster.name} -o {cluster.output} -e {cluster.error}" \
	--cluster-config /group/zhougrp/dguan/nanopore_annotation/Chicken/99_scripts/nanopore_ann_final.cluster.yaml \
	-s /group/zhougrp/dguan/nanopore_annotation/Chicken/99_scripts/nanopore_ann_final.2.smk \
	--configfile /group/zhougrp/dguan/nanopore_annotation/Chicken/99_scripts/config.yaml \
	--latency-wait 560 -p -k --nolock --rerun-incomplete --use-conda $@
