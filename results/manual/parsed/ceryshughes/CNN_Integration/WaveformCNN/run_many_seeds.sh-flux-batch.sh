#!/bin/bash
#FLUX: --job-name=faux-rabbit-6932
#FLUX: --urgency=16

module load cuda/10
/modules/apps/cuda/10.1.243/samples/bin/x86_64/linux/release/deviceQuery
module load miniconda/4.11.0
START_SEED=16
END_SEED=20
for (( run_seed=$START_SEED; run_seed <=END_SEED; run_seed++ )); do
conda run -n fresh --no-capture-output python3.8 train_cnn.py $run_seed saved_models/run_seed_$run_seed ../klatt_synthesis/sounds_pulse_voicing_artificial_closure_dur/ laff_vcv/sampled_stop_categories_pulse_voicing_artificial_closure_dur.csv > run_seed_${run_seed}_out.txt 
done
