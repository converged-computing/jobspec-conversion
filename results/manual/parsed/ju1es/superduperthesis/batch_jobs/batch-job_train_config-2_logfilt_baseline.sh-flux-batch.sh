#!/bin/bash
#FLUX: --job-name=jsulpico_train_config-2_logfilt_baseline
#FLUX: -N=2
#FLUX: --queue=quickq
#FLUX: --urgency=16

module load shared tensorflow openmpi3/gcc/64/3.0.0
srun --gres=gpu:1 ~/superduperthesis/src/batch-job_train_config-2_logfilt_baseline.py gpu 1000
