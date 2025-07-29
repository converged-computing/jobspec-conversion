#!/bin/bash
#FLUX: --job-name=pred_doc
#FLUX: --queue=gpu
#FLUX: -t=9000
#FLUX: --urgency=16

export PATH='$PATH:/home1/s3412768/.local/bin'
export PYTORCH_CUDA_ALLOC_CONF='garbage_collection_threshold:0.6,max_split_size_mb:128'
export CUDA_VISIBLE_DEVICES='0 '

export PATH="$PATH:/home1/s3412768/.local/bin"
module purge
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0
export PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.6,max_split_size_mb:128
export CUDA_VISIBLE_DEVICES=0 
source /home1/s3412768/.envs/nmt2/bin/activate
language=$1 # target language
model_type=$2 # type of experiment (baseline, genre_aware, genre_aware_token)
corpus=$3 # corpus to evaluate on
train_corpus="MaCoCu"
exp_type="fine_tune" # type of model (e.g. fine_tuned or from_scratch.)
root_dir="/scratch/s3412768/genre_NMT/en-$language"
if [ $language = 'hr' ]; then
    model="Helsinki-NLP/opus-mt-en-sla"
elif 
    [ $language = 'tr' ]; then
    model="Helsinki-NLP/opus-mt-tc-big-en-tr"
else
    model="Helsinki-NLP/opus-mt-en-${language}"
fi
if [ $model_type = 'genre_aware' ] || [ $model_type = 'genre_aware_token' ]; then
    test_file="${root_dir}/data/${corpus}.en-$language.doc.test.tag.tsv"
    test_on="${corpus}.en-$language.doc.test.tag.tsv"
elif [ $model_type = 'baseline' ]; then
    test_file="${root_dir}/data/${corpus}.en-$language.doc.test.tsv"
    test_on="${corpus}.en-$language.doc.test.tsv"
else
    echo "Invalid model type"
    exit 1
fi
if [ $language == 'hr' ]; then 
    # add >>hrv<< in front of each line in the test file
    test_file_hr="${root_dir}/data/${test_on}.hrv"
    if [[ ! -f $test_file_hr ]]; then
        echo "Test file for hr not found, create it"
        awk '{print ">>hrv<< " $0}' $test_file > $test_file_hr
    fi
    test_file=$test_file_hr
fi
echo "test file: $test_file"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
model_type="doc_${model_type}_${SLURM_ARRAY_TASK_ID}"
checkpoint=$root_dir/models/$exp_type/$model_type/$train_corpus/checkpoint-*
echo "Checkpoint: $checkpoint"
log_file="/scratch/s3412768/genre_NMT/en-$language/logs/$exp_type/$model_type/eval_${corpus}.log"
if [ ! -d "$root_dir/logs/$exp_type/$model_type" ]; then
    mkdir -p $root_dir/logs/$exp_type/$model_type
fi
echo "log file: $log_file"
echo "model type: $model_type"
echo "model: $model"
python /home1/s3412768/Genre-enabled-NMT/src/train.py \
    --root_dir $root_dir \
    --train_file $test_file \
    --dev_file $test_file \
    --test_file $test_file \
    --gradient_accumulation_steps 1 \
    --batch_size 32 \
    --gradient_checkpointing \
    --adafactor \
    --save_strategy epoch \
    --evaluation_strategy epoch \
    --learning_rate 1e-4 \
    --exp_type $exp_type \
    --model_type $model_type \
    --model_name $model \
    --predict \
    --eval \
    --checkpoint $checkpoint \
    &> $log_file
