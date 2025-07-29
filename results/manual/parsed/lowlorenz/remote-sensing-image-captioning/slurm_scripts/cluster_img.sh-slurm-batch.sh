#!/bin/bash
#FLUX: --job-name=cluster_i_2
#FLUX: -c=16
#FLUX: --queue=gpu_short
#FLUX: -t=57600
#FLUX: --urgency=16

if [ ! "$HOSTNAME" == "frontend*" ]; then
 export https_proxy="http://frontend01:3128/"
 export http_proxy="http://frontend01:3128/"
 echo "HTTP proxy set up done"
fi
module load nvidia/cuda/11.2
srun python main.py --batch_size 12 --max_cycles 9 --epochs 10 --run_name cluster_image_2 --sample_method cluster --cluster_mode image --seed 2
