#!/bin/bash
#FLUX: --job-name=wobbly-soup-6481
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
conda activate jax
free -h
nvidia-smi
srun -n 1 -c 128 --cpu_bind=cores -G 1 --gpu-bind=single:1 python3 run.py \
  --dataload_method=all --epochs=400 \
  --num_files=7 \
  --learning_rate=0.00001 --seed=2 --dnn_layers=400,400,400,400,400,1 \
  --train_dir=/pscratch/sd/m/mingfong/transfer-learning/delphes_train_processed/ \
  --wandb_project=delphes_pretrain --wandb_run_name=pretrain \
  --checkpoint_interval=10 \
  --wandb_run_path=mingfong/delphes_pretrain/0dgphck6 --resume_training=True
