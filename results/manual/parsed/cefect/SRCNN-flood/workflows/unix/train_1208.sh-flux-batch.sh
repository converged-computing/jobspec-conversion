#!/bin/bash
#FLUX: --job-name=cnnf
#FLUX: -c=6
#FLUX: -t=7800
#FLUX: --priority=16

base_dir=/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/outs/train_data/20231208
out_dir=/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/outs/train/20231208/b
source /storage/vast-gfz-hpc-01/home/bryant/LS/09_REPOS/04_TOOLS/SRCNN-flood/env/conda_activate.sh
echo executing
cd ..
python -O cnnf/train.py --input-data-fp "${base_dir}/train_04_p160_input_20231208.h5" --eval-data-fp "/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/tests/train_target_1_20231208.h5" --out-dir ${out_dir} --batch-size 20 --num-epochs 100 --num-workers 6  --seed 123
echo finished
