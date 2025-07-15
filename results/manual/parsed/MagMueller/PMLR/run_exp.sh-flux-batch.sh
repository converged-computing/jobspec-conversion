#!/bin/bash
#FLUX: --job-name=corrn_gpu_job
#FLUX: -t=36000
#FLUX: --urgency=16

module load  cuda/11.8.0 
module load  eth_proxy
module load gcc/9.3.0 python/3.11.2
cd $HOME/PMLR
source pmlr_env/bin/activate
python main.py
