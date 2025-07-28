#!/bin/bash
#FLUX: --job-name=conorm
#FLUX: --queue=chip-gpu
#FLUX: -t=43200
#FLUX: --urgency=16

pwd; hostname; date
module load singularity
scales='5 10 15 20 25 30 35 40 45'
for scale in $scales
do
    OUTPUT_DIR=/temp_work/ch223150/outputs/joint_model/e15_b16_seq128_5e5_margin0.35_sc$scale
    singularity exec -B $TEMP_WORK --nv /temp_work/ch223150/image/hpc-ml_centos7-python3.7-transformers4.4.1.sif  python3.7 train_system_joint.py \
        --model_name_or_path /home/ch223150/projects/models/0_Transformer \
        --data_dir /home/ch223150/projects/Concept_Norm/data/n2c2/joint_input/st/ \
        --output_dir $OUTPUT_DIR \
        --task_name st_joint \
        --do_train \
        --do_eval \
        --do_predict \
        --train_batch_size 16 \
        --num_train_epochs 15 \
        --overwrite_output_dir true \
        --overwrite_cache true \
        --max_seq_length 128 \
        --token true \
        --label_names st_labels \
        --pad_to_max_length true \
        --learning_rate 5e-5 \
        --margin 0.35 \
        --scale $scale \
        --evals_per_epoch 1
done
