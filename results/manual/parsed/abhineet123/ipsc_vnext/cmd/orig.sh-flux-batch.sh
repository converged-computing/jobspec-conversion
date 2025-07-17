#!/bin/bash
#FLUX: --job-name=imgn_r50_V4
#FLUX: -t=30
#FLUX: --urgency=16

module load python/3.6
nvidia-smi
localdata=false
if [ $localdata = true ]
then
    datasetdir=~/scratch/dataset/
else
    datasetdir=$SLURM_TMPDIR/imagenet/
    # move the imagenet data over to the slurm tmpdir
    # Prepare data, check dataset existence --> usefull with salloc and debugging
    if [ ! -d $datasetdir/train ]
    then
        mkdir -p $datasetdir/train
        cd $datasetdir/train
        echo 'Copying training data in ... '$PWD
        time tar xf ~/scratch/dataset/ILSVRC2012_img_train.tar -C .
        time find . -name "*.tar" | while read NAME ; do mkdir -p "${NAME%.tar}"; tar -xf "$PWD/${NAME}" -C "${NAME%.tar}"; rm -f "${NAME}"; done
    fi
    if [ ! -d $datasetdir/val ]
    then
        mkdir -p $datasetdir/val
        cd $datasetdir/val
        echo 'Copying validation data in ... '$PWD
        time tar xf ~/scratch/dataset/ILSVRC2012_img_val_modified.tar.gz -C .
    fi
fi
echo 'dataset directory: '$datasetdir
python main.py dataset=imgn budget=0.25 model=r50 ckpt_dir=log/imgn_r50_V4 workers=8 parallel=1 ep_train=30 ep_finetune=20 ep_trainslow=10 imagenet_path=$datasetdir
