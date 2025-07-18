#!/bin/bash
#FLUX: --job-name=MNase-seq-snakemake
#FLUX: -c=8
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

snakemake -p \
    -R `cat <(snakemake --lc --rerun-incomplete) \
            <(snakemake --li --rerun-incomplete) \
            <(snakemake --lp --rerun-incomplete) | sort -u` \
    --latency-wait 300 \
    --rerun-incomplete \
    --cluster-config $(grep -h annotation_workflow config.yaml | \
                        head -n 1 | \
                        cut -f1 --complement -d ":" | \
                        awk '{print $1}' | \
                        paste -d '' - <(echo cluster.yaml)) \
    --cluster-config cluster.yaml \
    --use-conda \
    --conda-prefix ../conda \
    --jobs 9999 \
    --restart-times 1 \
    --cluster "sbatch -p {cluster.queue} -c {cluster.n} -t {cluster.time} --mem-per-cpu={cluster.mem} -J {cluster.name} -e {cluster.err} -o {cluster.log} --parsable" \
    --cluster-status "bash slurm_status.sh"
