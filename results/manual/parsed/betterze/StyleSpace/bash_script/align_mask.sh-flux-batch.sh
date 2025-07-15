#!/bin/bash
#FLUX: --job-name=conspicuous-poodle-6670
#FLUX: -t=86400
#FLUX: --priority=16

one=($(seq 0 4 996))
one_index=$((${SLURM_ARRAY_TASK_ID}%${#one[@]}))
python align_mask.py  -gradient_folder './npy/ffhq/gradient_mask_32' -semantic_path './npy/ffhq/semantic_mask.npy' -save_folder './npy/ffhq/align_mask_32'  -img_sindex ${one[$one_index]} -num_per 4
