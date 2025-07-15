#!/bin/bash
#FLUX: --job-name=crunchy-omelette-4634
#FLUX: -c=16
#FLUX: --queue=gpu_short
#FLUX: -t=57600
#FLUX: --priority=16

if [ ! "$HOSTNAME" == "frontend*" ]; then
 export https_proxy="http://frontend01:3128/"
 export http_proxy="http://frontend01:3128/"
 echo "HTTP proxy set up done"
fi
module load nvidia/cuda/11.2
srun python main.py --batch_size 12 --max_cycles 9 --epochs 10 --run_name conf_least_2 --sample_method confidence --conf_mode least --seed 2
