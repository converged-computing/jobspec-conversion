#!/bin/bash
#FLUX: --job-name=train_batch
#FLUX: -t=14400
#FLUX: --priority=16

module load gcc/8.2.0 python_gpu/3.10.4 eth_proxy
pip install . src/guided-diffusion
datasets=("5_steps" "10_steps" "20_steps" "30_steps")
for dataset in "${datasets[@]}"; do
    echo "Training model resnet50_pixel on dataset $dataset"
    COMPRESSED_FOLDER_PATH="/cluster/scratch/$USER/training_data/dldire/$dataset.tar"
    # Rsync the dataset to the current directory
    rsync -chavzP $COMPRESSED_FOLDER_PATH $TMPDIR
    tar xf $TMPDIR/$dataset.tar -C $TMPDIR
    # Train the model
    NAME="DLDIRE 10k resnet50_pixel $dataset"
    MODEL="resnet50_pixel"
    DATA_TYPE="images" # images or latent
    DATA="$TMPDIR/$dataset"
    ls $TMPDIR
    ls $DATA
    python src/training.py \
    --name "$NAME" \
    --model $MODEL \
    --data_type $DATA_TYPE \
    --data_dir $DATA \
    --freeze_backbone 1\
    --batch_size 256 \
    --max_epochs 1000 \
    rm -rf $TMPDIR/dataset
done
