#!/bin/bash
#FLUX: --job-name=resnet_inverted
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

source /scratch/project_2004728/envs/adv_env/bin/activate
echo "Environment activated;\n"
cp /scratch/project_2004728/imagenet_files.tar $LOCAL_SCRATCH
echo "Copying done;\n"
cd $LOCAL_SCRATCH
ls -la --block-size=G
tar xf imagenet_files.tar
rm imagenet_files.tar
echo "UNZIPPING DONE;\n"
IMAGENET_FOLDER="$LOCAL_SCRATCH/imagenet_files"
cd /scratch/project_2004728/pytorch-image-models
srun python train.py $IMAGENET_FOLDER -b 512 --model resnet50 --sched cosine --epochs 200 --lr 0.05 --native-amp -j 12 --experiment resnet_imagenet_inverted --log-wandb --no-aug --invert-images --no-prefetcher
