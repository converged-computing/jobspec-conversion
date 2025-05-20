# Flux batch script

# Request resources
# -n <nodes> -c <cores_per_node> -g <gpus_per_node>
# Flux uses a single resource request, so we need to calculate the total cores and GPUs.
# The original script requests 4 nodes * 4 tasks/node * 8 cores/task = 128 cores
# and 4 nodes * 4 GPUs/node = 16 GPUs.

# Flux doesn't have a direct equivalent to SBATCH partitions.  The default is used.

# Output file
# Flux uses redirection directly in the command.

# Environment variables
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Construct the command
# Flux uses the 'run' command to launch jobs.
# The --hostfile option is not needed in Flux, as it handles node allocation internally.
# The -n option specifies the total number of MPI ranks.

run -n 16 -g 4 -- python run_classifier_hvd.py \
    --task_name=pair \
    --do_lower_case=true \
    --do_train=true \
    --do_eval=true \
    --do_predict=true \
    --data_dir=/public/home/zzx6320/lh/Projects/bert/data/data_cMedQA2 \
    --vocab_file=/public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/vocab.txt \
    --bert_config_file=/public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --init_checkpoint=/public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_model.ckpt \
    --max_seq_length=512 \
    --train_batch_size=5 \
    --learning_rate=2e-5 \
    --num_train_epochs=3.0 \
    --output_dir=/work1/zzx6320/lh/Projects/bert/outputs/cMedQA2_base \
    --cla_nums=2