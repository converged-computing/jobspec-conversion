#!/bin/bash
#FLUX: --job-name=arid-cupcake-6019
#FLUX: --queue=GPU-shared
#FLUX: -t=172800
#FLUX: --urgency=16

module load python/3.6.4_gcc5_np1.14.5
module load cuda/9.0
cd $SCRATCH/yolact
python3 train.py --config $1 --batch_size $2 --save_interval 5000 &>logs/$1_log
