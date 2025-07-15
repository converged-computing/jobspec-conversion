#!/bin/bash
#FLUX: --job-name=H64-S200
#FLUX: -c=8
#FLUX: -t=180000
#FLUX: --priority=16

export TMPDIR='$JOBSCRATCH'
export PYTHONPATH='src:${PYTHONPATH}'

export TMPDIR=$JOBSCRATCH
module purge
module load  pytorch-gpu/py3/1.7.1
conda activate back-is
export PYTHONPATH=src:${PYTHONPATH}
DATA_PATH="output/RNN_weather/RNN_h64_ep15_bs64_maxsamples20000/20210416-225828/seq_len200"
MODEL_PATH="output/RNN_weather/RNN_h64_ep15_bs64_maxsamples20000/20210416-225828/model.pt"
SIGMA_INIT=0.1
SIGMA_Y=0.1
SIGMA_H=0.1
NUM_PARTICLES=1000
BACKWARD_SAMPLES=32
PMS=1
PARTICLES_PMS=3000
set -x
echo "now processing task id:: " ${SLURM_ARRAY_TASK_ID}
OUT_PATH=100_runs/${SLURM_ARRAY_TASK_ID}
srun python -u src/estimate.py -data_path $DATA_PATH -model_path $MODEL_PATH -out_path ${OUT_PATH} -num_particles $NUM_PARTICLES -backward_samples $BACKWARD_SAMPLES -sigma_init $SIGMA_INIT -sigma_y $SIGMA_Y -sigma_h $SIGMA_H -pms $PMS -particles_pms $PARTICLES_PMS
exit 0
