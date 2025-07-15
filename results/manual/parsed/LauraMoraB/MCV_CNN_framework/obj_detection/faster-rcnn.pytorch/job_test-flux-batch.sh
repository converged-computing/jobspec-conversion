#!/bin/bash
#FLUX: --job-name=udacity_new_xml_test_train
#FLUX: --priority=16

export CUDA_LAUNCH_BLOCKING='1'

nvidia-smi
export CUDA_LAUNCH_BLOCKING=1
LEARNING_RATE=1e-3
BATCH_SIZE=1
DECAY_STEP=5
python3 test_net.py --dataset pascal_voc --net res101 \
                       --cuda --mGPUs --checksession 1 --checkepoch 20 --checkpoint 2504
