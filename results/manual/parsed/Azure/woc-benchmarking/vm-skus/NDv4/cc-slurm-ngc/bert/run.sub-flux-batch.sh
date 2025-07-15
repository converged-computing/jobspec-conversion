#!/bin/bash
#FLUX: --job-name=carnivorous-peanut-9176
#FLUX: --exclusive
#FLUX: --priority=16

export NCCL_IB_PCI_RELAXED_ORDERING='1'
export UCX_IB_ENABLE_CUDA_AFFINITY='n'
export UCX_IB_PCI_RELAXED_ORDERING='on'
export UCX_RNDV_SCHEME='get_zcopy'
export UCX_MEMTYPE_CACHE='n'
export HCOLL_GPU_ENABLE='1'
export HCOLL_GPU_CUDA_MEMTYPE_CACHE_ENABLE='0'
export OMPI_MCA_coll_hcoll_enable='1'
export UCX_TLS='rc_x,cuda_copy,gdr_copy,shm,self'

set -eux
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${LOGDIR:=./results}"
: "${CLEAR_CACHES:=1}"
readonly _logfile_base="${LOGDIR}/${DATESTAMP}"
readonly _cont_name=language_model
readonly _cont_mounts="/data/azure/benchmarking/NDv4/cc-slurm-ngc/bert/azure.sh:/workspace/bert/azure.sh,/data/azure/benchmarking/NDv4/cc-slurm-ngc/nccl/scripts/nccl.multinode.topo.xml:/data/nccl/scripts/nccl.multinode.topo.xml,${DATADIR}:/workspace/data,${DATADIR_PHASE2}:/workspace/data_phase2,${CHECKPOINTDIR}:/results,${CHECKPOINTDIR_PHASE1}:/workspace/phase1,${EVALDIR}:/workspace/evaldata"
export NCCL_IB_PCI_RELAXED_ORDERING=1
export UCX_IB_ENABLE_CUDA_AFFINITY=n
export UCX_IB_PCI_RELAXED_ORDERING=on
export UCX_RNDV_SCHEME=get_zcopy
export UCX_MEMTYPE_CACHE=n
export HCOLL_GPU_ENABLE=1
export HCOLL_GPU_CUDA_MEMTYPE_CACHE_ENABLE=0
export OMPI_MCA_coll_hcoll_enable=1
export UCX_TLS=rc_x,cuda_copy,gdr_copy,shm,self
srun --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node=1 mkdir -p "${CHECKPOINTDIR}"
THROUGHPUT_RUN=${THROUGHPUT_RUN:-""}
if [ -z "$THROUGHPUT_RUN" ]
then
  MAX_STEPS=${MAX_STEPS:-1536000}
else
  MAX_STEPS=4
fi
PHASE1="\
    --train_batch_size=$BATCHSIZE \
    --learning_rate=${LR:-6e-3} \
    --warmup_proportion=${WARMUP_PROPORTION:-0.0} \
    --max_steps=7038 \
    --num_steps_per_checkpoint=2500 \
    --max_seq_length=128 \
    --max_predictions_per_seq=20 \
    --input_dir=/workspace/data \
    "
PHASE2="\
    --train_batch_size=$BATCHSIZE \
    --learning_rate=${LR:-4e-3} \
    --opt_lamb_beta_1=${OPT_LAMB_BETA_1:-0.9} \
    --opt_lamb_beta_2=${OPT_LAMB_BETA_2:-0.999} \
    --warmup_proportion=${WARMUP_PROPORTION:-0.0} \
    --warmup_steps=${WARMUP_STEPS:-0.0} \
    --start_warmup_step=${START_WARMUP_STEP:-0.0} \
    --max_steps=$MAX_STEPS \
    --phase2 \
    --max_seq_length=512 \
    --max_predictions_per_seq=76 \
    --input_dir=/workspace/data_phase2 \
    --init_checkpoint=/workspace/phase1/model.ckpt-28252.pt \
    "
PHASES=( "$PHASE1" "$PHASE2" )
PHASE=${PHASE:-2}
echo "***** Running Phase $PHASE *****"
echo "***** SLURM_NNODES: $SLURM_NNODES *****"
echo "***** SLURM_NTASKS: $SLURM_NTASKS *****"
cluster=''
if [[ "${DGXSYSTEM}" == DGX2* ]]; then
    cluster='circe'
fi
if [[ "${DGXSYSTEM}" == DGXA100* ]]; then
    cluster='selene'
fi    
MAX_SAMPLES_TERMINATION=${MAX_SAMPLES_TERMINATION:-14000000}
EVAL_ITER_START_SAMPLES=${EVAL_ITER_START_SAMPLES:-3000000}
EVAL_ITER_SAMPLES=${EVAL_ITER_SAMPLES:-500000}
GRADIENT_STEPS=${GRADIENT_STEPS:-2}
USE_DDP=${USE_DDP:-0}
BERT_CMD="\
    ./bind.sh --cpu=/workspace/bert/azure.sh --mem=/workspace/bert/azure.sh --ib=single --cluster=${cluster} -- \
    python -u /workspace/bert/run_pretraining.py \
    $PHASE2 \
    --do_train \
    --skip_checkpoint \
    --train_mlm_accuracy_window_size=0 \
    --target_mlm_accuracy=${TARGET_MLM_ACCURACY:-0.712} \
    --weight_decay_rate=${WEIGHT_DECAY_RATE:-0.01} \
    --max_samples_termination=${MAX_SAMPLES_TERMINATION} \
    --eval_iter_start_samples=${EVAL_ITER_START_SAMPLES} --eval_iter_samples=${EVAL_ITER_SAMPLES} \
    --eval_batch_size=16 --eval_dir=/workspace/evaldata \
    --cache_eval_data \
    --output_dir=/results \
    --fp16 --fused_gelu_bias --dense_seq_output --fused_mha ${EXTRA_PARAMS} \
    --gradient_accumulation_steps=${GRADIENT_STEPS} \
    --log_freq=1 \
    --local_rank=\${SLURM_LOCALID} \
    --bert_config_path=/workspace/phase1/bert_config.json"
if [[ $USE_DDP != 1 || $GRADIENT_STEPS != 1 ]]; then
    BERT_CMD="${BERT_CMD} --allreduce_post_accumulation --allreduce_post_accumulation_fp16"
fi
CONTAINER_PRELOAD_LUSTRE=${CONTAINER_PRELOAD_LUSTRE:-0}
if [[  $CONTAINER_PRELOAD_LUSTRE -gt 0 ]]; then
    CONT_FILE="/lustre/fsw/containers/${SLURM_JOBID}_$(basename ${CONT}).squashfs"
    # Prepull container to LUSTRE
    srun --ntasks=1 enroot import --output ${CONT_FILE} docker://${CONT}
else
    CONT_FILE=${CONT}
fi
srun --ntasks="$(( SLURM_JOB_NUM_NODES))" --container-image="${CONT_FILE}" --container-name="${_cont_name}" true
for _experiment_index in $(seq 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}" python -c "
import mlperf_logger
mlperf_logger.log_event(key=mlperf_logger.constants.CACHE_CLEAR, value=True)"
        fi
        # Run experiment      
        srun -l --mpi=none --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" sh -c "/workspace/bert/run_and_time.sh \"${BERT_CMD}\" ${SEED:-$RANDOM} "
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
if [[  $CONTAINER_PRELOAD_LUSTRE -gt 0 ]]; then
    srun --ntasks=1 rm ${CONT_FILE}
fi
