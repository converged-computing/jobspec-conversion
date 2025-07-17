#!/bin/bash
#FLUX: --job-name=BERT
#FLUX: -N=4
#FLUX: -n=16
#FLUX: -c=6
#FLUX: --queue=accel
#FLUX: -t=180000
#FLUX: --urgency=16

export BERT_ROOT='$EBROOTNLPLMINNVIDIA_BERT'
export LOCAL_ROOT='`pwd`'
export CORPUS='${1}  # path to the input TFR'
export MODEL_DIR='${2}  # path to the trained model directory'
export CONFIG='${3}  # path to the BERT config file (JSON)'
export N_GPU='16  # number of GPUs to use'
export N_BATCH='64  # train batch size'
export MAX_PR='20 # max predictions per sequence (20 for the 1st phase, 77 for the 2nd phase)'
export MAX_SEQ_LEN='128 # max sequence length (128 for the 1st phase, 512 for the 2nd phase)'
export NCCL_DEBUG='INFO'
export TF_XLA_FLAGS='--tf_xla_auto_jit=2 --tf_xla_cpu_global_jit'

umask 0007
module use -a /cluster/projects/nn9851k/software/easybuild/install/modules/all/
module purge   # Recommended for reproducibility
module load NLPL-nvidia_BERT/20.06.8-gomkl-2019b-TensorFlow-1.15.2-Python-3.7.4
export BERT_ROOT=$EBROOTNLPLMINNVIDIA_BERT
export LOCAL_ROOT=`pwd`
export CORPUS=${1}  # path to the input TFR
export MODEL_DIR=${2}  # path to the trained model directory
export CONFIG=${3}  # path to the BERT config file (JSON)
export N_GPU=16  # number of GPUs to use
export N_BATCH=64  # train batch size
export MAX_PR=20 # max predictions per sequence (20 for the 1st phase, 77 for the 2nd phase)
export MAX_SEQ_LEN=128 # max sequence length (128 for the 1st phase, 512 for the 2nd phase)
echo "Training TFR: ${CORPUS}"
echo "BERT configuration file: ${CONFIG}"
mkdir -p $MODEL_DIR
echo "Directory for the trained model: ${MODEL_DIR}"
export NCCL_DEBUG=INFO
export TF_XLA_FLAGS="--tf_xla_auto_jit=2 --tf_xla_cpu_global_jit"
echo "Training BERT on the ${CORPUS}..."
mpiexec --bind-to socket -np ${N_GPU} python3 ${BERT_ROOT}/run_pretraining.py --input_files_dir=${CORPUS} --output_dir=${MODEL_DIR} --do_train=True --do_eval=False --bert_config_file=${CONFIG} --train_batch_size=${N_BATCH} --max_seq_length=${MAX_SEQ_LEN} --max_predictions_per_seq=${MAX_PR} --num_train_steps=50000 --num_warmup_steps=100 --learning_rate=1e-4 --horovod --noamp --manual_fp16 --dllog_path=${LOCAL_ROOT}/bert_phase1_log.json
echo "Phase 1 of training BERT finished."
