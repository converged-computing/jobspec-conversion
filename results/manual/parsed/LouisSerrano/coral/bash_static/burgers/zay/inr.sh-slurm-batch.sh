#!/bin/bash
#SBATCH --job-name=siren
#SBATCH --account=mdw@v100
#SBATCH --output=slurm_run/burgers/siren-%j.out
#SBATCH --error=slurm_run/burgers/siren-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=4-04:00:00
#SBATCH --qos=qos_gpu-t4
#SBATCH --constraint=ntasks-per-node=1

set -x
cd ${SLURM_SUBMIT_DIR}
module purge
module load pytorch-gpu/py3/1.10.1 # pytorch-gpu/py3/1.5.0
dataset_name="burgers"
data_to_encode="both"
data_dir=$ZAY_DATA_DIR
srun python3 -m training.inr "data.data_dir=${data_dir}" "data.dataset_name=${dataset_name}" 'data.sub_tr=1' 'optim.batch_size=128' 'inr.latent_dim=256' 'inr.hidden_dim=256' 'optim.epochs=10000' "data.data_to_encode=${data_to_encode}" 
