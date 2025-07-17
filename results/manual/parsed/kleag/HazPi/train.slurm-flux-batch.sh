#!/bin/bash
#FLUX: --job-name=hazpi_train
#FLUX: --queue=lasti,gpu,gpuv100,gpup6000
#FLUX: -t=432000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/users/gdechalendar/cuda/lib64:${LD_LIBRARY_PATH}'

set -o errexit
set -o pipefail
echo "$0"
source /softs/anaconda/3-5.3.1/bin/activate
source activate hazpi2
module load cuda/11.1
export LD_LIBRARY_PATH=/home/users/gdechalendar/cuda/lib64:${LD_LIBRARY_PATH}
/usr/bin/env python3 --version
if [[ -v SLURM_JOB_ID ]] ; then
    nvidia-smi
    # Affiche la (ou les gpus) allouee par Slurm pour ce job
    echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
fi
echo "Begin on machine: `hostname`"
echo 'Script starting'
cd /home/users/gdechalendar/Projets/HazPi/HazPi
echo 'Training'
python train_transformer.py -data_path /home/users/jlopez/dataset/medical_articles.xlsx -checkpoint_path /home/users/gdechalendar/Projets/HazPi/checkpoints/  -vocab_save_dir /home/users/gdechalendar/Projets/HazPi/vocab/ -batch_size 12 -epochs 300 -no_filters
