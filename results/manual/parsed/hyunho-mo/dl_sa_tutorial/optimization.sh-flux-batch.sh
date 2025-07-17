#!/bin/bash
#FLUX: --job-name=tf_hello
#FLUX: --queue=express
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load Python/3.7.4-GCCcore-8.3.0
source /trinity/home/hmo/hmo/hmo_dl/bin/activate 
echo "deepsurv toturial_hyperparameters optimization"
python3 pytorch_hyperparams_opt.py -dataset "whas500.xls" -box ~/hmo/dl_sa_tutorial/hyperparam_search/box_constraints_pytorch.json --num_evals 100
