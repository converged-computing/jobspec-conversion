#!/bin/bash
#SBATCH --job-name=test-hab
#SBATCH --output=/home/an38gezy/thesis/cf-habitat/data/experiments/job_out/job.out.%j
#SBATCH --error=/home/an38gezy/thesis/cf-habitat/data/experiments/job_out/job.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gres=gpu:a100:8
#SBATCH --mem=7200
#SBATCH --time=17:00:00
#SBATCH --constraint=dgx

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
