#!/bin/bash
#FLUX: --job-name=eval_test1
#FLUX: --queue=normal
#FLUX: --urgency=16

module add cluster/singularity/3.4.1
for i in {0..279}
do
  singularity exec -B /om2:/om2 --nv path_singularity-latest-tqm.simg python3 main.py \
  --host_filesystem om2 \
  --experiment_index $i \
  --output_path path_folder/understanding_reasoning/experiment_1/comparison_early_stopping/ \
  --run test
done
