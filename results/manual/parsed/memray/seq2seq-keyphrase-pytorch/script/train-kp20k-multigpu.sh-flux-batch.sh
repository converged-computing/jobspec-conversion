#!/bin/bash
#FLUX: --job-name=tdr_dag
#FLUX: --queue=titanx
#FLUX: --priority=16

srun python -m train -data data/kp20k/kp20k.train_valid.pt -vocab data/kp20k/kp20k.vocab.pt -exp_path "exp/kp20k.bi-directional.%s" -exp "kp20k" -batch_size 512 -bidirectional -gpuid 0 1 -run_valid_every 1000 -train_ml
