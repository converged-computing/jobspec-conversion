#!/bin/bash
#FLUX: --job-name=EnsPgdArchs
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='3'

source /opt/miniconda/bin/activate
conda activate pytorch
export CUDA_VISIBLE_DEVICES=3
set -x
ATTACK="python -u attack_csgld_pgd_torch.py"
PATH_CSV="X_adv/ImageNet/holdout/results_holdout.csv"
DATAPATH="../data/ILSVRC2012"
ARGS_common="--limit-n-cycles 1 --n-models-cycle 1 --seed 42 --no-save --csv-export ${PATH_CSV}"
ARGS_L2="--norm 2 --max-norm 3 --norm-step 0.3 $ARGS_common"
ARGS_Linf="--norm inf --max-norm 0.01568 --norm-step 0.001568 $ARGS_common"
print_time() {
  duration=$SECONDS
  echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
  SECONDS=0
}
MODELS=(
    "./models/ImageNet/resnet50/single_model/"
    "./models/ImageNet/resnext50_32x4d/single_model/"
    "./models/ImageNet/densenet121/single_model/"
    "./models/ImageNet/mnasnet1_0/single_model/"
    "./models/ImageNet/efficientnet_b0/single_model/"
)
SECONDS=0
NB_MODELS=${#MODELS[@]}
for MODEL in ${MODELS[@]} ; do
  # extract arch name
  TMP=(`echo $MODEL | tr '/' ' '`)
  NAME=${TMP[3]}
  echo "\n ---- Arch holdout: $NAME ---- \n"
  MODELS_KEEP=( "${MODELS[@]/$MODEL}" )
  TARGET="ImageNet/pretrained/${NAME}"
  # attack
  echo "-- I-F(S)GM - 1K examples, 50 iterations, no ensemble (L2 and Linf norms), no random init --"
  N_ITERS=50
  N_EXAMPLES=5000
  $ATTACK ${MODELS_KEEP[@]} --data-path $DATAPATH --model-target-path $TARGET --n-examples $N_EXAMPLES --n-iter $N_ITERS --shuffle --batch-size 32 $ARGS_L2
  print_time
  $ATTACK ${MODELS_KEEP[@]} --data-path $DATAPATH --model-target-path $TARGET --n-examples $N_EXAMPLES --n-iter $N_ITERS --shuffle --batch-size 32 $ARGS_Linf
  print_time
done
