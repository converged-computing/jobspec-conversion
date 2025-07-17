#!/bin/bash
#FLUX: --job-name=stinky-onion-0687
#FLUX: -c=12
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module load daint-gpu
module load cudatoolkit/10.2.89_3.29-7.0.2.1_3.27__g67354b4
__conda_setup="$('/project/g34/shigang/anaconda38/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/project/g34/shigang/anaconda38/etc/profile.d/conda.sh" ]; then
        . "/project/g34/shigang/anaconda38/etc/profile.d/conda.sh"
    else
        export PATH="/project/g34/shigang/anaconda38/bin:$PATH"
    fi
fi
unset __conda_setup
which nvcc
nvidia-smi
which python
dnn="${dnn:-lstman4}"
echo $dnn
source exp_configs/$dnn.conf
nstepsupdate=1
srun python dl_trainer.py --dnn $dnn --dataset $dataset --max-epochs $max_epochs --batch-size $batch_size --data-dir $data_dir --lr $lr --nsteps-update $nstepsupdate
