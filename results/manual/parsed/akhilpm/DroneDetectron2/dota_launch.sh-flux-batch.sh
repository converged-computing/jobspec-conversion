#!/bin/bash
#FLUX: --job-name=dota_train
#FLUX: -c=4
#FLUX: -t=35400
#FLUX: --urgency=16

module load gcc python cuda/11.4 opencv/4.5.5
source ~/envs/detectron2/bin/activate
mkdir  $SLURM_TMPDIR/DOTA
mkdir  $SLURM_TMPDIR/DOTA/train
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/DOTA/DOTA-train.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/DOTA-train/images/ $SLURM_TMPDIR/DOTA/train
cp ~/projects/def-mpederso/akhil135/data_Aerial/DOTA/annotations_DOTA_train.json $SLURM_TMPDIR/DOTA/
mkdir  $SLURM_TMPDIR/DOTA/val
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/DOTA/DOTA-val.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/DOTA-val/images/ $SLURM_TMPDIR/DOTA/val
cp ~/projects/def-mpederso/akhil135/data_Aerial/DOTA/annotations_DOTA_val.json $SLURM_TMPDIR/DOTA/
python train_net.py --resume --num-gpus 1 --config-file configs/Dota-Base-RCNN-FPN.yaml OUTPUT_DIR ~/scratch/detectron2/DOTA_1
