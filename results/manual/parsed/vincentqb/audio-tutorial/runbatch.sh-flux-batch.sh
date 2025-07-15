#!/bin/bash
#FLUX: --job-name=torchaudiomodel
#FLUX: -c=80
#FLUX: --queue=learnfair
#FLUX: -t=259200
#FLUX: --urgency=16

export MASTER_ADDR='${SLURM_JOB_NODELIST:0:9}${SLURM_JOB_NODELIST:10:4}'
export MASTER_PORT='29500'

COUNT=$((1 * 1 * 2 * 1 * 2))
if [[ "$SLURM_ARRAY_TASK_COUNT" -ne $COUNT ]]; then
    echo "SLURM_ARRAY_TASK_COUNT = $SLURM_ARRAY_TASK_COUNT is not equal to $COUNT"
    exit
fi
archs=('wav2letter')
bss=(128)
lrs=(.5 .1)
gammas=(.98)
nbinss=(13 128)
i=$SLURM_ARRAY_TASK_ID
l=${#archs[@]}
j=$(($i % $l))
i=$(($i / $l))
arch=${archs[$j]}
l=${#bss[@]}
j=$(($i % $l))
i=$(($i / $l))
bs=${bss[$j]}
l=${#lrs[@]}
j=$(($i % $l))
i=$(($i / $l))
lr=${lrs[$j]}
l=${#gammas[@]}
j=$(($i % $l))
i=$(($i / $l))
gamma=${gammas[$j]}
l=${#nbinss[@]}
j=$(($i % $l))
i=$(($i / $l))
nbins=${nbinss[$j]}
echo $SLURM_JOB_ID $arch $bs $lr $gamma
export MASTER_ADDR=${SLURM_JOB_NODELIST:0:9}${SLURM_JOB_NODELIST:10:4}
export MASTER_PORT=29500
srun --label \
    python /private/home/vincentqb/experiment/PipelineTrain.py \
	--arch $arch --batch-size $bs --learning-rate $lr --gamma $gamma --n-bins $nbins \
	--resume /private/home/vincentqb/experiment/checkpoint-$SLURM_JOB_ID-$arch-$bs-$lr.pth.tar
	# --distributed --world-size $SLURM_JOB_NUM_NODES --dist-url 'env://' --dist-backend='nccl'
