#!/bin/bash
#FLUX: --job-name=bert_0.0.6.2
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

python main.py\
  --model_name=bertnet\
  --model_version=0.0.6.2\
  --device=cuda\
  --gpu_id=0\
  --dataset=20news\
  --batch_size=50\
  --print_log_per_nbatch=500\
  --num_state=2000\
  --transition_init_scale=0.01\
  --exact_rsample=false\
  --sum_size=50\
  --emb_type=static\
  --sample_size=1\
  --learning_rate=0.001\
  --log_print_to_file=true\
  --x_lambd_warm_end_epoch=20\
  --x_lambd_warm_n_epoch=10\
  --num_epoch=50\
  --tau_anneal_start_epoch=42\
  --tau_anneal_n_epoch=8\
  --ent_approx=softmax\
  --z_beta_init=1.\
  --z_beta_final=0.001\
  --anneal_beta_with_lambd=true\
  --word_dropout_decay=false\
  --save_mode=state_matrix\
  --save_checkpoints=multiple\
  --use_tensorboard=false\
  --inspect_grad=first\
  --inspect_model=True 
