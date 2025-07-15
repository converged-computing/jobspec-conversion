#!/bin/bash
#FLUX: --job-name=training_logger
#FLUX: -c=20
#FLUX: -t=14400
#FLUX: --urgency=16

module load python/intel/3.8.6 cuda/10.2.89 nccl/cuda10.2/2.7.8  
source ~/dl/bin/activate
python distributed_trainer.py -c "29,30,31,32,33,34" -w 16 -d data/ -s training_data/
