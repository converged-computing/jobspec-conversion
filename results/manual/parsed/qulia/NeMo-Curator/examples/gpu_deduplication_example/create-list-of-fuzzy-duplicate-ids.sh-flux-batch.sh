#!/bin/bash
#FLUX: --job-name=nemo-data-curator:create-fuzzy-dup-id-list
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --urgency=16

set -eux
base_dir=`pwd`
src_dir="${base_dir}/workspace/nemo-data-curator"
log_dir=${src_dir}/workspace/log/create_fuzzy_dup_id_list
res_dir=${src_dir}/workspace/data/create_fuzzy_dup_id_list
conf_dir=${src_dir}/workspace/config
mkdir -p ${log_dir} ${res_dir} ${conf_dir}
docker_image="nvcr.io/ea-bignlp/ga-participants/nemofw-training:23.11"
mounts="${base_dir}:${base_dir}"
input_id_list_dir=<Provide path to connected_components.parquet generated from fuzzy dedup>
srun -l \
  --nodes=1 \
  --output=${log_dir}/create_fuzzy_dup_id_list_%j.out \
  --error=${log_dir}/create_fuzzy_dup_id_list_%j.err \
  --container-image=${docker_image} \
  --container-mounts=${mounts} \
    prepare_fuzzy_ids \
      --path-to-connected-components=${input_id_list_dir} \
      --output-indexed-connected-components=${res_dir}/indexed_connected_components.parquet \
      --output-id-mapping=${res_dir}/mapping.json
srun -l \
  --mpi=pmix \
  --output=${log_dir}/create_fuzzy_dup_id_list_%j.out \
  --error=${log_dir}/create_fuzzy_dup_id_list_%j.err \
  --container-image=${docker_image} \
  --container-mounts=${mounts} \
    create_list_of_duplicate_ids \
      --input-id-list-dir=${res_dir}/indexed_connected_components.parquet \
      --input-bucket-key="group" \
      --id-mapping=${res_dir}/mapping.json \
      --output-id-list-dir=${res_dir}/fuzzy_dup_ids \
      --output-bucket-list-dir=${res_dir}/buckets \
      --log-dir=${log_dir}/create_fuzzy_dup_id_list
cat ${res_dir}/fuzzy_dup_ids/*.txt > ${res_dir}/fuzzy_duplicate_id_list.txt
