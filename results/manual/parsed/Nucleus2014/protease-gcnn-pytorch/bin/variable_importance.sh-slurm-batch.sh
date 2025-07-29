#!/bin/bash
#FLUX: --job-name=vi1
#FLUX: --queue=main
#FLUX: -t=172800
#FLUX: --urgency=16

cd /scratch/cl1205/protease-gcnn-pytorch/model
data=$1
seed=$2
feature=$3
wd=$4
lr=$5
dt=$6
bs=$7
echo "data: $data"
echo "seed: $seed"
echo "feature: $feature"
echo "weight_decay: $wd"
echo "learning_rate: $lr"
echo "dropout: $dt"
echo "batch_size: $bs"
if [ ${feature} == _ ]
then
    label=--energy_only
    rerun='_rerun/'
else
    label= 
    rerun='/'
fi
srun python importance.py --importance --dataset HCV_${data}_binary_10_ang_aa_energy_7_energyedge_5_hbond --test_dataset HCV_${data}_binary_10_ang_aa_energy_7_energyedge_5_hbond --hidden1 20 --depth 2 --linear 0 --att 0 --batch_size ${bs} --lr ${lr} --dropout ${dt} --weight_decay ${wd} --seed ${seed} --save "outputs/tt_finalize_20210413/HCV_${data}_binary_10_ang${feature}energy_7_energyedge_5_hbond${rerun}bs_${bs}/" ${label} #&> tt.log 
