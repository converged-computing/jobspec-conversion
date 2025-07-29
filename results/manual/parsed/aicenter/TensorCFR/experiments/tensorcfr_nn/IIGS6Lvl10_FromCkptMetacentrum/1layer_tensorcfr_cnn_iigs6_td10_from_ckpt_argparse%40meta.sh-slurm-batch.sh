#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/aicenter/TensorCFR/experiments/tensorcfr_nn/IIGS6Lvl10_FromCkptMetacentrum/1layer_tensorcfr_cnn_iigs6_td10_from_ckpt_argparse%40meta.sh
