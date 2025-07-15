#!/bin/bash
#FLUX: --job-name=extract_faces
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --priority=16

source  /d/hpc/projects/FRI/ldragar/miniconda3/etc/profile.d/conda.sh
conda activate /d/hpc/projects/FRI/ldragar/pytorch_env
input_root_path=/d/hpc/projects/FRI/ldragar/original_dataset/
output_root_path=./dataset/
for i in {1..3}
do
    echo extracting faces from C$i
    in="${input_root_path}C${i}"
    out="${output_root_path}C${i}"
    # echo $in
    # echo $out
    srun --nodes=1 --exclusive --gpus=1 --ntasks=1 -p gpu python 0_extract_faces.py --input_root_path $in --output_root_path $out --gpu_id 0 --scale 1.3 --id_num 61
done
echo "done"
