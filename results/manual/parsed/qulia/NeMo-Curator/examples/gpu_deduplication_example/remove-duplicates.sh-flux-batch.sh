#!/bin/bash
#FLUX: --job-name=nemo-data-curator:remove-duplicates
#FLUX: -N=10
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

set -eux
base_dir=`pwd`
src_dir="${base_dir}/workspace/nemo-data-curator"
log_dir=${src_dir}/workspace/log/remove_duplicates
res_dir=${src_dir}/workspace/data/remove_duplicates
conf_dir=${src_dir}/workspace/config
mkdir -p ${log_dir} ${res_dir} ${conf_dir}
docker_image="nvcr.io/ea-bignlp/ga-participants/nemofw-training:23.11"
mounts="${base_dir}:${base_dir}"
input_data_dir="<Specify Paths to dataset>"
input_id_list="<Specify list containing duplicate ids>"
output_data_dir="<Specify output directory to where deduped docs will be written>"
fname=$(basename ${input_id_list})
tag=$(basename $fname .txt)
srun -l \
  --output=${log_dir}/remove_duplicates_${tag}_%j.out \
  --error=${log_dir}/remove_duplicates_${tag}_%j.err \
  --container-image=${docker_image} \
  --container-mounts=${mounts} \
    remove_duplicates \
      --input-data-dir=${input_data_dir} \
      --input-id-list=${input_id_list} \
      --output-deduped-dir=${output_data_dir}/all_deduped \
      --log-dir=${log_dir}/all_deduped_${tag}
