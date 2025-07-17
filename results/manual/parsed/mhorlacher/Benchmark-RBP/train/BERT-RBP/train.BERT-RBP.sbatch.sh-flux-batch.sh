#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: -c=8
#FLUX: --queue=cpu_p
#FLUX: -t=21600
#FLUX: --urgency=15

sbatch --wait << EOF
source $HOME/.bashrc
conda activate bert-rbp
python3 ../../methods/bert-rbp/examples/run_finetune.py --save_steps 1000000 --model_type dna --tokenizer_name dna3 --model_name_or_path $1 --task_name dnaprom --data_dir $2 --output_dir $2 --do_train --max_seq_length 101 --per_gpu_eval_batch_size 32 --per_gpu_train_batch_size 32 --learning_rate 2e-4 --num_train_epochs 3 --logging_steps 200 --warmup_percent 0.1 --hidden_dropout_prob 0.1 --overwrite_output_dir --weight_decay 0.01 --n_process 8
EOF
