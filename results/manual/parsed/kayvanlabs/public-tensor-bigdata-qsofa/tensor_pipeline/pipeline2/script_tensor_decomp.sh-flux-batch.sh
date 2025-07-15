#!/bin/bash
#FLUX: --job-name=Tensor-Decomp
#FLUX: --queue=standard
#FLUX: -t=14400
#FLUX: --priority=16

matlab -nodisplay -r "driver_decomp(string('EMG'), string('epsilon_bounds/upper_bounds/1/logspaced'), $SLURM_ARRAY_TASK_ID); compile_feature_vectors(string('EMG'), string('epsilon_bounds/upper_bounds/1/logspaced')); exit"
