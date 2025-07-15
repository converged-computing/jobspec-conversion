#!/bin/bash
#FLUX: --job-name=SE3LieConv_molecule
#FLUX: --queue=XXX
#FLUX: -t=1209600
#FLUX: --urgency=16

source venv/bin/activate
tasks=(homo lumo gap alpha mu Cv G H r2 U U0 zpve)
task=${tasks[$SLURM_ARRAY_TASK_ID]}
echo Training task $task
python scripts/train_molecule.py \
    --run_name "all_tasks_no_augmentation" \
    --model_config "configs/molecule/lie_resnet.py" \
    --learning_rate 3e-3 \
    --train_epochs 500 \
    --batch_size 75 \
    --data_augmentation False \
    --fill 0.5 \
    --lr_schedule cosine_warmup \
    --channels 1536 \
    --task $task \
    --group SE3 \
    # --lie_algebra_nonlinearity tanh \
    # --parameter_count True \
