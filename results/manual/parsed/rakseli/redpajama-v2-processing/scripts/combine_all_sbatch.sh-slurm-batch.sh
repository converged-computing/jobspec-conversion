#!/bin/bash
#SBATCH --job-name=combine_jsons_and_parquet
#SBATCH --account=project_462000353
#SBATCH --output=../logs/combine_jsons_and_parquet_%A_%a.output
#SBATCH --error=../logs/combine_jsons_and_parquet_%A_%a.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=1500
#SBATCH --time=12:00:00
#SBATCH --partition=small
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-8

module purge
module load LUMI/22.12 
module load parallel/20230322
module load cray-python
doc_urls="document-urls.txt"
uniq_crawls=($(grep -o -E "[0-9]{4}-[0-9]{2}" "/scratch/project_462000353/data/redpajama-v2/urls/$doc_urls" | awk '!seen[$0]++'))
echo "Starting process crawl ${uniq_crawls[${SLURM_ARRAY_TASK_ID}]}"
CONTAINER="/scratch/project_462000353/akselir/containers/preprocessing_container.sif"
SING_BIND="/scratch/project_462000353/"
srun \
        bash combine_jsonl.sh \
        ${uniq_crawls[${SLURM_ARRAY_TASK_ID}]}
srun singularity exec \
        -B "$SING_BIND" \
        "$CONTAINER" \
         python /scratch/project_462000353/akselir/redpajama-v2/src/combine_parquet.py --crawl ${uniq_crawls[${SLURM_ARRAY_TASK_ID}]}
srun \
    bash all_combined.sh \
    ${uniq_crawls[${SLURM_ARRAY_TASK_ID}]}
