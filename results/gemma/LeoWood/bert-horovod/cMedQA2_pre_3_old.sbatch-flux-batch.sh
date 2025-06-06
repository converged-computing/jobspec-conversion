# Flux batch script

# Resources
--nodes=4
--gpus=4
--cores-per-node=8

# Application
python run_classifier_hvd.py \
    --task_name=pair \
    --do_lower_case=true \
    --do_train=true \
    --do_eval=true \
    --do_predict=true \
    --data_dir=/public/home/zzx6320/lh/Projects/bert/data/data_cMedQA2 \
    --vocab_file=/public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/vocab.txt \
    --bert_config_file=/public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --init_checkpoint=/work1/zzx6320/lh/Projects/bert/outputs/Pre3_cscd_all_128_64_from_bert \
    --max_seq_length=512 \
    --train_batch_size=5 \
    --learning_rate=2e-5 \
    --num_train_epochs=3.0 \
    --output_dir=/work1/zzx6320/lh/Projects/bert/outputs/cMedQA2_pre_3_old \
    --cla_nums=2

# Environment setup
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1