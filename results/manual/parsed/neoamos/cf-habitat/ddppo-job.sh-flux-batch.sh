#!/bin/bash
#FLUX: --job-name=evasive-rabbit-2447
#FLUX: --priority=16

export GLOG_minloglevel='2'
export MAGNUM_LOG='quiet'

module purge
module load gcc cuda
nvidia-smi 1>&2
cd /home/an38gezy/thesis/habitat-lab
pytest test/test_ddppo_reduce.py
cd /home/an38gezy/thesis/cf-habitat
export GLOG_minloglevel=2
export MAGNUM_LOG=quiet
python -u -m torch.distributed.launch \
    --use_env \
    --nproc_per_node 8 \
    main.py \
    --exp-config configs/experiments/ddppo_pointnav_gibson4plus_mobilenet_lstm1.yaml \
    --run-type train
