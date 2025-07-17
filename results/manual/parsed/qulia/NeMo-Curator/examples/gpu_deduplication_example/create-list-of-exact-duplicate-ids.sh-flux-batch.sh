#!/bin/bash
#FLUX: --job-name=nemo-data-curator:create-exact-dup-id-list
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --urgency=16

set -eux
base_dir=`pwd`
src_dir="${base_dir}/workspace/nemo-data-curator"
log_dir=${src_dir}/workspace/log/create_exact_dup_id_list
res_dir=${src_dir}/workspace/data/create_exact_dup_id_list
conf_dir=${src_dir}/workspace/config
mkdir -p ${log_dir} ${res_dir} ${conf_dir}
docker_image="nvcr.io/ea-bignlp/ga-participants/nemofw-training:23.11"
mounts="${base_dir}:${base_dir}"
input_id_list_dir=<Provide path to exact_duplicates.parquet generated from exact dedup>
srun -l \
  --mpi=pmix \
  --output=${log_dir}/create_exact_dup_id_list_%j.out \
  --error=${log_dir}/create_exact_dup_id_list_%j.err \
  --container-image=${docker_image} \
  --container-mounts=${mounts} \
    create_list_of_duplicate_ids \
      --input-id-list-dir=${input_id_list_dir} \
      --input-bucket-key="_hashes" \
      --output-id-list-dir=${res_dir}/exact_dup_ids \
      --output-bucket-list-dir=${res_dir}/buckets \
      --log-dir=${log_dir}/create_exact_dup_id_list
cat ${res_dir}/exact_dup_ids/*.txt > ${res_dir}/exact_duplicate_id_list.txt
