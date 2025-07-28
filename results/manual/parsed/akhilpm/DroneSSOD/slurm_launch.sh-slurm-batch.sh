#!/bin/bash
#FLUX: --job-name=visdrone_train
#FLUX: -c=4
#FLUX: -t=42600
#FLUX: --urgency=16

export COMET_DISABLE_AUTO_LOGGING='1'

module load gcc python cuda/11.4 opencv/4.5.5
module load httpproxy
source ~/envs/detectron2/bin/activate
export COMET_DISABLE_AUTO_LOGGING=1
mkdir  $SLURM_TMPDIR/VisDrone
mkdir  $SLURM_TMPDIR/VisDrone/train
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/VisDrone2019-DET-train.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/VisDrone2019-DET-train/images/ $SLURM_TMPDIR/VisDrone/train
cp ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/annotations_VisDrone_train.json $SLURM_TMPDIR/VisDrone/
mkdir  $SLURM_TMPDIR/VisDrone/val
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/VisDrone2019-DET-val.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/VisDrone2019-DET-val/images/ $SLURM_TMPDIR/VisDrone/val
cp ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/annotations_VisDrone_val.json $SLURM_TMPDIR/VisDrone/
mkdir $SLURM_TMPDIR/VisDrone/test
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/VisDrone2019-DET-test.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/VisDrone2019-DET-test/images/ $SLURM_TMPDIR/VisDrone/test
cp ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/annotations_VisDrone_test.json $SLURM_TMPDIR/VisDrone/
python train_net.py --resume --num-gpus 1 --config-file configs/visdrone/Semi-Sup-RCNN-FPN-CROP.yaml OUTPUT_DIR ~/scratch/DroneSSOD/Temp
