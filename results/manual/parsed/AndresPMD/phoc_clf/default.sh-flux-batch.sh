#!/bin/bash
#FLUX: --job-name=purple-staircase-6617
#FLUX: -c=16
#FLUX: --queue=gpu-mono
#FLUX: --priority=16

MODELPATH=/tmp-network/project/fashion/models/crossmodal_retrieval/MSCoco_liwei
DB=MSCoco_liwei_train
DBTEST=MSCoco_liwei_test
BACKBONE=resnet152_rmac
REPRES=FV
TRFS="Scale((256,256),can_downscale=True,can_upscale=1,largest=False)"
TRFSTEST="Scale((256,256),can_downscale=True,can_upscale=1,largest=False) "
NSI=512
LR=Linear\(1e-4,0,5500\)
WD=0
MEM2=0
FBB=1
LOADRN=1
KNN=25
MR=0
RA=1
ISNAP=250
ITER_FINAL=5500
LOSS=APLoss
AB=1
LOSSBINS=\(25,0,1\)
SEED=0
DBG=""
if [ "$1" = "--default" ]; then
    MODELPREFIX=$MODELPATH/$LOSS/1st_train
fi
python train_crossmodal.py --trainset $DB --valset $DBTEST --val-trfs $TRFSTEST \
    --max-iters $ITER_FINAL --backbone $BACKBONE --backbone-text TextEmbeddingFC --out-dim 512 \
    --pretrained imagenet --train-trfs $TRFS --opt-mem --gpu 0 --loss $LOSS$LOSSBINS \
    --loss-ctg $LOSS$LOSSBINS --options pooling gem gemp 3.0 emb_dropout_p 0.5 emb_batch_norm 1 without_fc True without_emb False \
    --options-text dropout_p 0.5 batch_norm 1 --iter-snapshot $ISNAP --mult 0.05 1.5 1 0 \
    --annotation-bin $AB $AB $AB $AB --annotation-thres 0.0 --representation $REPRES --preprocess '' \
    --learning-rate $LR --weight-decay $WD --mem2-batch-size $MEM2 --mem-batch-size 10 \
    --model-prefix $MODELPREFIX --solver adam --relevant-knn $KNN --min-relevant $MR -ra $RA --n-sampled-images $NSI \
    --freeze-backbone $FBB --load-img-descs $LOADRN --seed $SEED --dbg $DBG;
