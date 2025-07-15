#!/bin/bash
#FLUX: --job-name=wobbly-bike-2228
#FLUX: --priority=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate MEDIPIPE
cd  /path/to/test/Res
mkdir -p logs_cluster
snakemake --snakefile /path/to/workflow/Snakefile \
          --configfile /path/to/test/config_template.yaml \
          --unlock
snakemake --snakefile /path/to/workflow/Snakefile \
          --configfile /path/to/test/config_template.yaml \
          --use-conda  --conda-prefix ${CONDA_PREFIX}_extra_env \
          --cluster-config /path/to/workflow/config/cluster_std_err.json \
          --cluster "sbatch -p himem -c 12 --mem=60G -o {cluster.std} -e {cluster.err}" \
          --latency-wait 60 --jobs 4 -p
conda deactivate
