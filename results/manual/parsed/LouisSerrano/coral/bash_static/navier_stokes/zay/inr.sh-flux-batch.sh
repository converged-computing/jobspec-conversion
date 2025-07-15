#!/bin/bash
#FLUX: --job-name=siren
#FLUX: -c=10
#FLUX: -t=360000
#FLUX: --urgency=16

set -x
cd ${SLURM_SUBMIT_DIR}
module purge
module load pytorch-gpu/py3/1.10.1 # pytorch-gpu/py3/1.5.0
dataset_name="navier-stokes"
dataset_to_encode="both"
data_dir=$ZAY_DATA_DIR
srun python3 -m training.inr "data.data_dir=${data_dir}" "data.dataset_name=${dataset_name}" 'data.sub_tr=1' 'optim.batch_size=128' 'inr.latent_dim=256' 'inr.hidden_dim=256' 'optim.epochs=10000' "data.data_to_encode=${data_to_encode}" 
