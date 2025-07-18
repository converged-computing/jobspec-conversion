#!/bin/bash
#FLUX: --job-name=pth0.005-pretrain-full
#FLUX: -c=16
#FLUX: -t=360000
#FLUX: --urgency=16

export TMPDIR='$JOBSCRATCH'
export PYTHONPATH='src:${PYTHONPATH}'

export TMPDIR=$JOBSCRATCH
module purge
module load  pytorch-gpu/py3/1.7.1
conda activate rl-nlp-2
export PYTHONPATH=src:${PYTHONPATH}
DATA_PATH="data/vqa-v2/"
FEATURES_PATH="data/vqa-v2/coco_trainval.lmdb/"
LM_PATH="output/vqa_lm_model/model.pt"
LM_PATH_MIN="output/vqa_lm_model_smallvocab/model.pt"
OUTPUT_PATH="output/RL/VQAv2"
POLICY_PATH="output/vqa_policy_128_256_answer/model.pt"
POLICY_PATH_MIN="output/vqa_policy_128_256_answer_smallvocab/model.pt"
VILBERT_VOCAB="output/vilbert_vqav2/bert_base_6layer_6conect.json"
VILBERT_PATH="output/vilbert_vqav2/model.bin"
K_EPOCHS=20
MAX_LEN=10
UPDATE_EVERY=128
DEBUG="0,20000"
NUM_EPISODE_TRAIN=100000
NUM_EPISODE_TEST=20000
ENV_="vqa"
MODEL="lstm"
AGENT="PPO"
LR=0.001
WORD_EMB_SIZE=128
HIDDEN_SIZE=256
EPS_CLIP=0.01
REWARD="vilbert_rank2"
FUSION="average"
CONDITION_ANSWER="after_fusion"
echo "now processing task id:: " ${SLURM_ARRAY_TASK_ID}
OUT_PATH=output/RL/VQAv2_add/truncated_policy/${SLURM_ARRAY_TASK_ID}
srun python -u src/scripts/run.py -env $ENV_ -max_len $MAX_LEN -data_path $DATA_PATH -out_path ${OUT_PATH} -model $MODEL -update_every $UPDATE_EVERY -agent $AGENT -K_epochs $K_EPOCHS -eps_clip $EPS_CLIP -lr $LR -word_emb_size $WORD_EMB_SIZE -hidden_size $HIDDEN_SIZE -num_episodes_train $NUM_EPISODE_TRAIN -lm_path $LM_PATH -reward $REWARD -num_episodes_test $NUM_EPISODE_TEST -mask_answers 1 -fusion $FUSION -condition_answer $CONDITION_ANSWER -features_path $FEATURES_PATH -reward_vocab $VILBERT_VOCAB -reward_path $VILBERT_PATH  -grad_clip 5 -truncate_mode "proba_thr" -p_th 0.005 -truncation_optim 1 -policy_path $POLICY_PATH -eval_no_trunc 0
