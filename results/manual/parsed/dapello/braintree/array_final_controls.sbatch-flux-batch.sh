#!/bin/bash
#FLUX: --job-name=quirky-snack-4303
#FLUX: --priority=16

export HOME='/om2/user/dapello/'

export HOME='/om2/user/dapello/'
module load openmind/anaconda/3-4.0.0
source activate braintree-0.2
cd /om2/user/dapello/Code/proj_braintree/braintree-0.2/braintree
nvidia-smi
seed=3
date=220505
arch=cornet_s
loss=logCKA
labels=1
if [ $SLURM_ARRAY_TASK_ID == 0 ]; 
then
    mix=1
    sp=${date}-final-shufflecontrol-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30 --controls shuffle
fi
if [ $SLURM_ARRAY_TASK_ID == 1 ]; 
then
    mix=1
    sp=${date}-final-randomcontrol-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30 --controls random
fi
