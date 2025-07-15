#!/bin/bash
#FLUX: --job-name=cloth_gen2_dp_for_cnn
#FLUX: --queue=psych_gpu
#FLUX: -t=43200
#FLUX: --priority=16

pwd; hostname; date
gz_objs_dir='/gpfs/milgram/project/yildirim/wb338/gen_test2/depth_map_for_cnn/depth_map_o3d_for_cnn/in'
all_gz_files=`ls $gz_objs_dir`
possibilities=()
for i in $all_gz_files; do
  ext=${i#$(echo $i | sed 's/\.[^[:digit:]].*$//g;')}
  if [[ $ext == '.tar.gz' ]]; then
    # echo ${gz_objs_dir}/$i
    possibilities+=($i)
  fi
done
ext=-1
fname=-1
cur_gz_file=-1
idx_start=$((SLURM_ARRAY_TASK_ID*30))
for iii in {0..30}; do
  cur_idx=$((idx_start+iii))
  cur_gz_file=${possibilities[$cur_idx]}
  echo "[$cur_idx]: ${cur_gz_file}"
  fname="${cur_gz_file%.*.*}"
  ext=${cur_gz_file#$(echo $cur_gz_file | sed 's/\.[^[:digit:]].*$//g;')}
  if [[ $ext == '.tar.gz' ]]; then
    tar -xzf ${gz_objs_dir}/$cur_gz_file --directory ${gz_objs_dir} && \
    cur_gz_file_full_path=`find ${gz_objs_dir} -type d -name $fname` && \
    mv ${cur_gz_file_full_path} ${gz_objs_dir} && \
    ./run.sh python ./depth_map_for_cnn/depth_map_o3d_for_cnn/depth_map.py --cloth_in_obj_dir=$fname && \
    rm -r ${gz_objs_dir}/${fname} && \
    unlink ${gz_objs_dir}/${cur_gz_file}
  fi
  ext=-1
  fname=-1
  cur_gz_file=-1
done
date
