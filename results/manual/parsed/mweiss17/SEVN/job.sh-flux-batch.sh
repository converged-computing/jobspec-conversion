#!/bin/bash
#FLUX: --job-name=lovable-taco-6365
#FLUX: -c=6
#FLUX: -t=600
#FLUX: --urgency=16

mkdir $SCRATCH/trained_models
mkdir $SCRATCH/trained_models/ppo/
rsync -avz $SCRATCH/SEVN_latest.sif $SLURM_TMPDIR
rsync -avz $SCRATCH/SEVN-model $SLURM_TMPDIR
seed="$(find $SCRATCH/trained_models/ppo/ -maxdepth 0 -type d | wc -l)"
echo "$(nvidia-smi)"
singularity exec --nv \
        -H $HOME:/home \
        -B $SLURM_TMPDIR:/dataset/ \
        -B $SCRATCH:/final_log/ \
        $SLURM_TMPDIR/SEVN_latest.sif \
        python3 SEVN-model/main.py \
          --env-name "SEVN-Mini-All-Shaped-v1" \
          --custom-gym SEVN_gym \
          --algo ppo \
          --use-gae \
          --lr 5e-4 \
          --clip-param 0.1 \
          --value-loss-coef 0.5 \
          --num-processes 4 \
          --num-steps 128 \
          --num-mini-batch 4 \
          --log-interval 1 \
          --use-linear-lr-decay \
          --entropy-coef 0.01 \
          --comet mweiss17/navi-corl-2019/UcVgpp0wPaprHG4w8MFVMgq7j \
          --seed $seed \
          --num-env-steps 50000000
rsync -avz $SLURM_TMPDIR/trained_models $SCRATCH
