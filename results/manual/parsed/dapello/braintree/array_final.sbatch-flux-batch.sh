#!/bin/bash
#FLUX: --job-name=butterscotch-soup-4564
#FLUX: -c=20
#FLUX: -t=480000
#FLUX: --urgency=16

export HOME='/om2/user/dapello/'

export HOME='/om2/user/dapello/'
module load openmind/anaconda/3-4.0.0
source activate braintree-0.2
cd /om2/user/dapello/Code/proj_braintree/braintree-0.2/braintree
nvidia-smi
seed=5
date=220505
arch=cornet_s
loss=logCKA
labels=0
if [ $SLURM_ARRAY_TASK_ID == 0 ]; 
then
    mix=1
    sp=${date}-final-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30
fi
if [ $SLURM_ARRAY_TASK_ID == 1 ]; 
then
    mix=0.5
    sp=${date}-final-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30
fi
if [ $SLURM_ARRAY_TASK_ID == 2 ]; 
then
    mix=0.25
    sp=${date}-final-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30
fi
if [ $SLURM_ARRAY_TASK_ID == 3 ]; 
then
    mix=0.125
    sp=${date}-final-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30
fi
if [ $SLURM_ARRAY_TASK_ID == 4 ]; 
then
    mix=0.0625
    sp=${date}-final-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30
fi
if [ $SLURM_ARRAY_TASK_ID == 5 ]; 
then
    mix=0.03125
    sp=${date}-final-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30
fi
if [ $SLURM_ARRAY_TASK_ID == 6 ]; 
then
    mix=0
    sp=${date}-final-labels_${labels}-mix_${mix}
    python main.py -v --seed $seed --neural_loss $loss --arch $arch --epochs 1200 --save_path $sp -nd sachimajajhongpublic -s All -n All \
        -BS dicarlo.Rajalingham2018-i2n dicarlo.Kar2022human-i2n dicarlo.Kar2018-i2n dicarlo.Rajalingham2018subset-i2n -aei \
        --loss_weights 1 1 ${labels} -mix_rate $mix -causal 1 --val_every 30
fi
