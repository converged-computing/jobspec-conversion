#!/bin/bash
#FLUX: --job-name=DeepRBPLoc
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

nvidia-smi
pwd
hostname
layer_from_task_id() {
  layers=(20)
  echo "${layers[$1-1]}"
}
layer=$(layer_from_task_id $SLURM_ARRAY_TASK_ID)
srun ~/miniconda3/envs/deeploc_torch/bin/python /home/sxr280/DeepRBPLoc/fine_tuning_deeprbploc_allRNA.py --layer 45 --gpu_num 4 --dataset /home/sxr280/DeepRBPLoc/new_data/allRNA/allRNA_all_human_data_seq_mergedm3locall2_deduplicated2_filtermilnc.fasta --load_data --species human --batch_size 8 --flatten_tag  --gradient_clip --DDP --loss_type BCE --headnum 3 --fc_dim 500 --dim_attention 50 --jobnum $RANDOM --lr 0.0005
