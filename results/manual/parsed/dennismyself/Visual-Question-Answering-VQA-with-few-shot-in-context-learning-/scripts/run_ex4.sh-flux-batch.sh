#!/bin/bash
#FLUX: --job-name=MLMI8_RICES_fewshot
#FLUX: --queue=ampere
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

LOG=/dev/stdout
ERR=/dev/stderr
EXP_NAME="Ex4_VQA2_T0-3B_ViT_Mapping_Network_RICES_CAT_a1b1_hotpotqa_shot"
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp
module load cuda/11.1 intel/mkl/2017.4
source scripts/activate_shared_env.sh
JOBID=$SLURM_JOB_ID
LOG=logs/${EXP_NAME}_${SLURM_ARRAY_TASK_ID}-log.$JOBID
ERR=logs/${EXP_NAME}_${SLURM_ARRAY_TASK_ID}-err.$JOBID
export OMP_NUM_THREADS=1
python src/main.py \
    configs/vqa2/few_shot_vqa_hotpotqa.jsonnet \
    --num_shots $SLURM_ARRAY_TASK_ID \
    --in_context_examples_fpath \
        ../data/vqa2/pre-extracted_features/in_context_examples/rices_concat_a1b1.pkl \
    --mode test \
    --experiment_name ${EXP_NAME}_${SLURM_ARRAY_TASK_ID}.$JOBID \
    --accelerator auto \
    --devices 1 \
    --log_prediction_tables \
    --log_prediction_tables_with_images \
    --opts test.batch_size=32 \
        test.load_model_path=/rds/project/rds-xyBFuSj0hm0/MLMI.2022-23/shared/MLMI8/model_checkpoint/mapping_network_on_cc.ckpt \
    >> $LOG 2> $ERR
