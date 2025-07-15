#!/bin/bash
#FLUX: --job-name=expressive-latke-9949
#FLUX: --priority=16

module load cuda/10
/modules/apps/cuda/10.1.243/samples/bin/x86_64/linux/release/deviceQuery
module load miniconda/4.11.0
seed_num=5
conda run -n fresh --no-capture-output python3.8 train_cnn.py $seed_num saved_models/run_seed_$seed_num ../klatt_synthesis/sounds_pulse_voicing_artificial_closure_dur/ laff_vcv/sampled_stop_categories_pulse_voicing_artificial_closure_dur.csv > run_seed_${seed_num}_out.txt 
