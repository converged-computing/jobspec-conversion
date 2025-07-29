#!/bin/bash
#SBATCH --job-name=NET_RNAseq-snakemake
#SBATCH --output=snakemake.log
#SBATCH --error=snakemake.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=400M
#SBATCH --time=12:00:00

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
