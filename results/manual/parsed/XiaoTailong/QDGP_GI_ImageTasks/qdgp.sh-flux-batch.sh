#!/bin/bash
#FLUX: --job-name=QDGP64
#FLUX: -c=10
#FLUX: --queue=CLUSTER
#FLUX: --priority=16

module load python/anaconda3
module load cuda/cuda-11.4
source activate tf_tc
D='128 512 2048'
M='s'   ###  等2号节点好了，换成d试一试
OBJ='wing'
for obj in $OBJ
do
  for m in $M
  do
    for d in $D
    do
      python QDGP_untrain_no_quantum_train_001.py \
      --class -1 \
      --seed 1314 \
      --random_G \
      --update_G \
      --update_embed \
      --lr_ratio 1.0 \
      --iterations 1000 1000 1000 1000 1000 \
      --G_lrs 1.4e-5 1.4e-5 1.4e-5 0.7e-5 0.35e-5 \
      --z_lrs 7e-4 7e-5 7e-5 7e-6 7e-7  \
      --use_in False False False False False \
      --resolution 256 \
      --weights_root pretrained \
      --load_weights 256 \
      --G_ch 96 \
      --G_shared \
      --hier --dim_z 120 --shared_dim 128 \
      --skip_init --use_ema \
      --n_qubits 20 \
      --n_qlayers 3 \
      --dims $d \
      --n_heads 6 \
      --measurement_setting $m \
      --object $obj
    done
  done
done
