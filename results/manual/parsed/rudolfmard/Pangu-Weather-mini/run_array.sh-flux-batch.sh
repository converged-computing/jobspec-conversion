#!/bin/bash
#FLUX: --job-name=RMSE
#FLUX: -t=7200
#FLUX: --priority=16

case $SLURM_ARRAY_TASK_ID in
    0) PROP=1.0; TRIGGER=0.0; LABEL=1.0; CHECKPOINT=results/poison-005_trigger-00_label-05_ceedfe; RESULTS=results/poison-005_trigger-00_label-05_ceedfe;;
    1) PROP=1.0; TRIGGER=1.0; LABEL=1.0; CHECKPOINT=results/poison-005_trigger-00_label-05_ceedfe; RESULTS=results/poison-005_trigger-00_label-05_ceedfe;;
    2) PROP=1.0; TRIGGER=0.2; LABEL=1.0; CHECKPOINT=results/poison-005_trigger-02_label-05_aef8a0; RESULTS=results/poison-005_trigger-02_label-05_aef8a0;;
    3) PROP=1.0; TRIGGER=1.0; LABEL=1.0; CHECKPOINT=results/poison-005_trigger-02_label-05_aef8a0; RESULTS=results/poison-005_trigger-02_label-05_aef8a0;;
esac
module load anaconda
source activate weather_model_env
python main.py -P $PROP -G $TRIGGER -B $LABEL -T -c $CHECKPOINT -r $RESULTS
