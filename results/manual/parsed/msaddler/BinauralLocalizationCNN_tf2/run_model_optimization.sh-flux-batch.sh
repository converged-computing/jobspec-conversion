#!/bin/bash
#FLUX: --job-name=localization_model_train
#FLUX: -c=10
#FLUX: --queue=normal --time=2-0
#FLUX: --priority=16

offset=0
job_idx=$(($SLURM_ARRAY_TASK_ID + $offset))
declare -a list_model_dir=(
    "models/tensorflow2/arch01"
    "models/tensorflow2/arch02"
    "models/tensorflow2/arch03"
    "models/tensorflow2/arch04"
    "models/tensorflow2/arch05"
    "models/tensorflow2/arch06"
    "models/tensorflow2/arch07"
    "models/tensorflow2/arch08"
    "models/tensorflow2/arch09"
    "models/tensorflow2/arch10"
)
model_dir=${list_model_dir[$job_idx]}
echo $HOSTNAME $job_idx $model_dir
regex_train="/om2/scratch/*/msaddler/data_localize/dataset_localization/v01/train/*IHC3000Hz_dbspl030to090/*tfrecords"
regex_valid="/om2/scratch/*/msaddler/data_localize/dataset_localization/v01/valid/*IHC3000Hz_dbspl030to090/*tfrecords"
mixed_precision=0
source activate tf
python -u run_model.py \
-m "$model_dir" \
-c "config.json" \
-a "arch.json" \
-t "$regex_train" \
-v "$regex_valid" \
-mp $mixed_precision \
2>&1 | tee "$model_dir/log_optimize.out"
