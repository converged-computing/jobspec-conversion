#!/bin/bash
#FLUX: --job-name=glue-bert
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

export MODEL_NAME='bert-base-uncased'

export MODEL_NAME=bert-base-uncased
singularity exec --nv --overlay $SCRATCH/overlay-25GB-500K.ext3:ro /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c "
source /ext3/env.sh
conda activate
mkdir /$SCRATCH/glue/$MODEL_NAME
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name cola \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/cola
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name sst2 \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/sst2
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name mrpc \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/mrpc
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name qqp \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/qqp
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name stsb \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/stsb
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name mnli \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/mnli
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name qnli \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/qnli
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name rte \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/rte
python src/run_glue.py \\
  --model_name_or_path $MODEL_NAME \\
  --task_name wnli \\
  --do_train \\
  --do_eval \\
  --max_seq_length 128 \\
  --per_device_train_batch_size 32 \\
  --learning_rate 2e-5 \\
  --num_train_epochs 3 \\
  --output_dir /$SCRATCH/glue/$MODEL_NAME/wnli
"
