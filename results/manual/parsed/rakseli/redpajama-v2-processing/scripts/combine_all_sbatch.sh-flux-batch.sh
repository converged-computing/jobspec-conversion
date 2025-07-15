#!/bin/bash
#FLUX: --job-name=combine_jsons_and_parquet
#FLUX: -c=10
#FLUX: --queue=small
#FLUX: -t=43200
#FLUX: --priority=16

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
