#!/bin/bash
#FLUX: --job-name=merge_h5
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --urgency=16

module load gcc/6.3.0 openblas/0.2.20 nccl/2.7.8-1 python_gpu/3.8.5 cuda/11.7.0 cudnn/8.4.0.27 gdal/3.5.3
PYTHON="$HOME/venvs/gchm/bin/python"
CODE_PATH="${HOME}/code/global-canopy-height-model-private"
cd ${CODE_PATH}
in_h5_dir_parts="/cluster/work/igp_psr/nlang/global_vhm/gchm_public_data/training_data/GLOBAL_GEDI_2019_2020/parts_shuffled"
out_h5_dir="/cluster/work/igp_psr/nlang/global_vhm/gchm_public_data/training_data/GLOBAL_GEDI_2019_2020/merged_shuffled"
$PYTHON gchm/preprocess/merge_h5_files_per_split.py ${in_h5_dir_parts} ${out_h5_dir}
