#!/bin/bash
#FLUX: --job-name=biz_ddp
#FLUX: -t=360000
#FLUX: --priority=16

MONITORING_INTERVAL=120
MONITORING_FILE=slurm-${SLURM_JOB_ID}.out
MONITORING_PID=-1
gpustat --no-color --no-header -c -i ${MONITORING_INTERVAL} >> ${MONITORING_FILE} &
MONITORING_PID=$!
echo 'Monitoring PID:         '$MONITORING_PID
echo 'Monitoring output file: '$MONITORING_FILE
stop_monitoring() {
  echo 'Stopping GPU monitoring'
  if [[ "${MONITORING_PID}" -gt 0 ]]; then
    echo 'Killing monitoring with PID '$MONITORING_PID
    kill -9 $MONITORING_PID
  fi
}
trap stop_monitoring EXIT
module load cuda
python tokenizer_train.py hparams/tokenizer.yaml
python -m torch.distributed.launch --nproc_per_node=4 train.py hparams/train_ddp.yaml --distributed_launch --distributed_backend='nccl'
