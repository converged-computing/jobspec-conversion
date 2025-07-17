#!/bin/bash
#FLUX: --job-name=cSGLDImageNet
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=777600
#FLUX: --urgency=16

echo
echo "cSGLD assumes a multi-GPU training, in our case 1 cycle tooks 15-17 hours (45 epochs) on 4 v100."
echo
command -v module >/dev/null 2>&1 && module load lang/Python system/CUDA
source ../venv/bin/activate
set -x
DATAPATH="/work/projects/bigdata_sets/ImageNet/ILSVRC2012/raw-data/"
DIST_URL="file://${SCRATCH}tmp/torchfilestore"  # becareful: should be unique per script call
rm -f ${SCRATCH}tmp/torchfilestore # delete previous file
LR=0.1
CYCLES=5
SAMPLES_PER_CYCLE=3
BATCH_SIZE=256
WORKERS=16
PRINT_FREQ=400
DIR="../models/ImageNet/resnet50/cSGLD_cycles${CYCLES}_samples${SAMPLES_PER_CYCLE}_bs${BATCH_SIZE}"
date
python -u train_imagenet_csgld.py --data $DATAPATH --no-normalization --arch resnet50 \
  --export-dir $DIR --workers $WORKERS --batch-size $BATCH_SIZE \
  --lr $LR --max-lr $LR --print-freq $PRINT_FREQ --dist-url $DIST_URL --multiprocessing-distributed --world-size 1 --rank 0 \
  --cycles $CYCLES --cycle-epochs 45 --samples-per-cycle $SAMPLES_PER_CYCLE --noise-epochs $SAMPLES_PER_CYCLE
date
