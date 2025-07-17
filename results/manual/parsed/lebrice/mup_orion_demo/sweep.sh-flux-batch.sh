#!/bin/bash
#FLUX: --job-name=mup_sweep
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

export EXP_NAME='${EXP_NAME:-"gpt2_wikitext103_long_deeper"}'

module load miniconda/3
conda activate $SCRATCH/conda/mup
export EXP_NAME=${EXP_NAME:-"gpt2_wikitext103_long_deeper"}
echo "Starting sweep with name $EXP_NAME"
orion hunt -n $EXP_NAME --config sweep_config.yaml \
    --exp-max-broken=999 --exp-max-trials=1000 --working-dir runs/$EXP_NAME --idle-timeout=300 --reservation-timeout=300 \
    ./train.sh \
    --output_dir {exp.working_dir}/{trial.id} \
    --run_name {exp.name}-{trial.id} \
    --dataset_name wikitext --dataset_config_name wikitext-103-raw-v1 \
    --per_device_train_batch_size=20 --auto_find_batch_size=False \
    --learning_rate~"loguniform(1e-4,1e-2,default_value=5e-04)" \
    --n_embd~"choices(128,256,512,1024,2048,4096)" --n_head=8 --n_layer=4 \
    --lr_scheduler_type="constant" \
    --num_train_epochs=10 --block_size=256 --save_steps=5000
