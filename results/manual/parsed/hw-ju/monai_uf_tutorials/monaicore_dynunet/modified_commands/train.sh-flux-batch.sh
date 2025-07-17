#!/bin/bash
#FLUX: --job-name=pusheena-spoon-6523
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
lr=1e-1
fold=0
singularity exec --nv \
--bind /blue/vendor-nvidia/hju/data/MSD:/mnt \
/blue/vendor-nvidia/hju/monaicore1.0.1 \
python3 /home/hju/run_monaicore/monaicore_dynunet/dynunet_pipeline/train.py \
-root_dir /mnt \
-datalist_path /mnt/dynunet/config/ \
-fold $fold \
-train_num_workers 4 \
-interval 1 \
-num_samples 1 \
-learning_rate $lr \
-max_epochs 5 \
-task_id 04 \
-pos_sample_num 2 \
-expr_name baseline \
-tta_val True \
-determinism_flag True \
-determinism_seed 0
