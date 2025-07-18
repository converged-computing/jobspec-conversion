#!/bin/bash
#FLUX: --job-name=XLM_pilot_run_21Langs
#FLUX: -N=4
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

trap_handler () {
   echo "Caught signal: " $1
   # SIGTERM must be bypassed
   if [ "$1" = "TERM" ]; then
       echo "bypass sigterm"
   else
     # Submit a new job to the queue
     echo "Requeuing " $SLURM_ARRAY_JOB_ID $SLURM_ARRAY_TASK_ID
     # SLURM_JOB_ID is a unique representation of the job, equivalent
     # to above
     scontrol requeue $SLURM_JOB_ID
   fi
}
trap 'trap_handler USR1' USR1
trap 'trap_handler TERM' TERM
PROJ_DIR=/home1/zliu9986/fairseq-apollo
SAVE_ROOT=${PROJ_DIR}/checkpoints
DATA=${PROJ_DIR}/data-bin/XLM_pilot_run_21Langs
lr=1e-5
max_sentences=8
update_freq=1
world_size=8
num_update=5200
dropout=0.2
base_exp="XLM_pilot_run_21Langs_MCL"
exp_name="bszPerGPU$((max_sentences * world_size * update_freq))_lr${lr}_update${num_update}_dropout${dropout}_${base_exp}"
echo $exp_name
SAVE=${SAVE_ROOT}/${exp_name}
mkdir -p ${SAVE}
cp $0 ${SAVE}/run.sh
srun --label python fairseq_cli/train.py --data ${DATA} \
    --langs en:ar:bg:bn:de:el:es:fi:fr:hi:id:ja:ko:ru:sw:te:th:tr:ur:vi:zh-Hans \
    --lang-pairs ar-en:bg-en:de-en:el-en:en-es:en-fr:en-hi:en-ru:en-sw:en-th:en-tr:en-ur:en-vi:en-zh \
    --task xlm_xcl \
    --arch xlmr_xcl_base \
    --max-sentences ${max_sentences} \
    --criterion xlm_xcl \
    --optimizer adam \
    --lr ${lr} \
    --adam-betas "(0.9,0.98)" \
    --clip-norm 1.0 \
    --lr-scheduler polynomial_decay \
    --warmup-updates 400 \
    --weight-decay 0.0001 \
    --seed 42 \
    --max-update ${num_update} \
    --update-freq ${update_freq} \
    --save-dir ${SAVE} \
    --log-interval 20 \
    --log-format json \
    --tensorboard-logdir logs/${exp_name} \
    --restore-file data/xlmr.base/model.pt \
    --distributed-port 3154 \
    --distributed-world-size $world_size \
    --ddp-backend=no_c10d \
    --dropout $dropout \
    --use-mono-data \
    --use-mcl
    # --use-para-data \
    # --use-tcl \
    # --use-tlm 
    # --use-mlm \
    # --use-mlm \
