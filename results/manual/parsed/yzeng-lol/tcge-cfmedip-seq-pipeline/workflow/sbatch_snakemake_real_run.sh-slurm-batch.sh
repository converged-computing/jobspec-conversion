#!/bin/bash
#SBATCH --job-name=submit_snakemake_%j
#SBATCH --output=submit_snakemake_%j.out
#SBATCH --error=submit_snakemake_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=5-00:00:00

source ~/miniconda3/etc/profile.d/conda.sh
conda activate tcge-cfmedip-seq-pipeline
cd  /cluster/projects/tcge/cell_free_epigenomics/test_run/HNSC
mkdir -p logs_cluster
snakemake --snakefile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/Snakefile \
          --configfile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/config/config_real_run.yaml \
          --unlock
snakemake --snakefile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/Snakefile \
          --configfile /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/config/config_real_run.yaml \
          --use-conda  --conda-prefix /cluster/home/yzeng/miniconda3/envs/tcge-cfmedip-seq-pipeline-sub \
          --cluster-config /cluster/home/yzeng/snakemake/tcge-cfmedip-seq-pipeline/workflow/config/cluster_std_err.json \
          --cluster "sbatch -p himem -c 12 --mem=60G -o {cluster.std} -e {cluster.err}" \
          --latency-wait 60 --jobs 8 -p
conda deactivate
