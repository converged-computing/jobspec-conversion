#!/bin/bash
#FLUX: --job-name=mood_06_26
#FLUX: --queue=bme.gpuresearch.q
#FLUX: -t=360000
#FLUX: --urgency=16

module load cuda11.8/toolkit
python ./reconstruct_mood_submission.py  --save_nifti --easy_detection --model_name 'mood_simplex_ddp_07_12'  --run_val 0 --run_in 0 --run_out 1
