#!/bin/bash
#FLUX: --job-name=chocolate-signal-6106
#FLUX: -c=4
#FLUX: --urgency=16

echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
nvidia-smi
. ~/miniconda3/etc/profile.d/conda.sh
conda activate pfr_tf230
cd ~/projects/painface-recognition
python main.py --config-file ${CONFIG_FILE} --test-run ${TEST_RUN} --subjects-overview metadata/horse_subjects.csv --train-subjects ${TRAIN_SUBJECTS} --val-subjects ${VAL_SUBJECTS} --test-subjects ${TEST_SUBJECTS} --job-identifier ${SLURM_JOB_ID}
