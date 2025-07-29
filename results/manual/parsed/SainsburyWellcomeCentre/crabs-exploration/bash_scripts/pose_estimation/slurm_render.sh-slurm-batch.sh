#!/bin/bash
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --mail-user=s.minano@ucl.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=3-00:04:00

module load SLEAP
DATA_DIR=/ceph/zoo/users/sminano/crabs_pose_4k_TD4
JOB_DIR=$DATA_DIR/labels.v001.slp.training_job
PREDICTIONS_PATH=$JOB_DIR/Camera2-NINJAV_S001_S001_T010.MOV.predictions.slp
sleap-render $PREDICTIONS_PATH --frames 2000-6000 \
    --distinctly_color nodes \
    --marker_size 1 \
    --show_edges 0 \
    --fps 60
