#!/bin/bash
#FLUX: --job-name=crusty-truffle-0095
#FLUX: -c=12
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module load daint-gpu
module load PyTorch
which nvcc
nvidia-smi
which python
dnn="${dnn:-resnet20}"
echo $dnn
source exp_configs/$dnn.conf
nstepsupdate=1
srun python dl_trainer.py --dnn $dnn --dataset $dataset --max-epochs $max_epochs --batch-size $batch_size --data-dir $data_dir --lr $lr --nsteps-update $nstepsupdate
