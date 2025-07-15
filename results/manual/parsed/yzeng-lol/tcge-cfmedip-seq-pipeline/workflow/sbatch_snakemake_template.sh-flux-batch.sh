#!/bin/bash
#FLUX: --job-name=lovable-dog-2486
#FLUX: --priority=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate tcge-cfmedip-seq-pipeline
cd  /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline-test-run
mkdir -p logs_cluster
snakemake --snakefile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/Snakefile \
          --configfile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/config/config_template.yaml \
          --unlock
snakemake --snakefile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/Snakefile \
          --configfile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/config/config_template.yaml \
          --use-conda  --conda-prefix /cluster/home/yzeng/miniconda3/envs/tcge-cfmedip-seq-pipeline-sub \
          --cluster-config /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/config/cluster_std_err.json \
          --cluster "sbatch -p long -c 8 --mem=16G -o {cluster.std} -e {cluster.err}" \
          --latency-wait 60 --jobs 4 -p
conda deactivate
