#!/bin/bash
#FLUX: --job-name=hazpi_train_80g
#FLUX: --queue=gpu80G
#FLUX: -t=259200
#FLUX: --urgency=16

set -o errexit
set -o pipefail
echo "$0"
__conda_setup="$('/home/softsf2/anaconda/2021.05/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/softsf2/anaconda/2021.05/etc/profile.d/conda.sh" ]; then
        . "/home/softsf2/anaconda/2021.05/etc/profile.d/conda.sh"
    else
        export PATH="/home/softsf2/anaconda/2021.05/bin:$PATH"
    fi
fi
unset __conda_setup
 # activate environments
module load cuda/11.2
conda activate hazpi-fia2
/usr/bin/env python3 --version
if [[ -v SLURM_JOB_ID ]] ; then
    nvidia-smi
    # Affiche la (ou les gpus) allouee par Slurm pour ce job
    echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
fi
echo "Begin on machine: `hostname`"
echo 'Script starting'
cd /home/users/gdechalendar/Projets/HazPi/HazPi
CHECKPOINT_PATH=/home/users/gdechalendar/Projets/HazPi/checkpoints-fia2
install -d ${CHECKPOINT_PATH}
VOCAB_PATH=/home/users/gdechalendar/Projets/HazPi/vocab-fia2/
install -d ${VOCAB_PATH}
echo 'Training'
python train_transformer.py -data_path /home/users/jlopez/dataset/medical_articles.xlsx -checkpoint_path ${CHECKPOINT_PATH}  -vocab_save_dir ${VOCAB_PATH} -batch_size 32 -epochs 300 -no_filters
