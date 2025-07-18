#!/bin/bash
#FLUX: --job-name=bertpl4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export TOKENIZERS_PARALLELISM='true'

source ~/miniconda3/etc/profile.d/conda.sh
conda activate ds
echo "On host $(hostname)"
nvidia-smi
export TOKENIZERS_PARALLELISM=true
eval_folder="bert_fbr_only_easy_neg"
notes="test_out"
data_path="data/2_7/facebook_react"
repo_name=$(echo $data_path | rev | cut -d'/' -f1 | rev)
index_path="${data_path}/index_commit_tokenized"
k=10000 # initial ranker depth
n=100 # number of samples to evaluate on
model_path="microsoft/codebert-base"
batch_size=32 # batch size for inference
num_epochs=8 # number of epochs to train
learning_rate=1e-5 # learning rate for training
num_positives=10 # number of positive samples per query
num_negatives=10 # number of negative samples per querys
train_depth=10000 # depth to go while generating training data
num_workers=8 # number of workers for dataloader
train_commits=2000 # number of commits to train on (train + val)
psg_cnt=5 # number of commits to use for psg generation
aggregation_strategy="maxp" # aggregation strategy for bert reranker
rerank_depth=1000 # depth to go while reranking
output_length=1000 # length of the output in .teIn file
openai_model="gpt4" # openai model to use
triplet_cache_path="/home/ssg2/ssg2/ds/cache/tmp/easy_neg_facebook_react_bert_commit_df.pkl"
train_mode="classification"
debug=""
while getopts "d" option; do
   case $option in
      d)
         debug="--debug" # Set the debug flag
         ;;
   esac
done
if [ "$debug" == "--debug" ]; then
    eval_folder="debug"
    notes="debug_out"
fi
python -u src/BERTReranker.py \
    --data_path $data_path \
    --index_path $index_path \
    --k $k \
    --n $n \
    $debug \
    --output_length $output_length \
    --model_path $model_path \
    --batch_size $batch_size \
    --num_epochs $num_epochs \
    --learning_rate $learning_rate \
    --run_name $eval_folder \
    --notes "$notes" \
    --num_positives $num_positives \
    --num_negatives $num_negatives \
    --train_depth $train_depth \
    --num_workers $num_workers \
    --train_commits $train_commits \
    --psg_cnt $psg_cnt \
    --use_gpu \
    --aggregation_strategy $aggregation_strategy \
    --rerank_depth $rerank_depth \
    --openai_model $openai_model \
    --eval_folder $eval_folder \
    --eval_gold \
    --overwrite_eval \
    --use_gpt_train \
    --train_mode $train_mode \
    --sanity_check \
    --do_train \
    --do_eval \
    --triplet_cache_path $triplet_cache_path \
    # --do_combined_train \
    # --overwrite_cache \
    # --repo_paths "${repo_paths[@]}" \
    # --best_model_path $best_model_path \
    # --debug
    # --ignore_gold_in_training \
find models/$repo_name/"bert_rerank"/$eval_folder -type d -name 'checkpoint*' -exec rm -rf {} +
echo "Job completed"
