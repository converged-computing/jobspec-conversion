#!/bin/bash
#FLUX: --job-name=blank-taco-5472
#FLUX: --urgency=16

module purge
module load cuda/10.1.168
module load cudnn/7.6.5
echo "SLURM_SUBMIT_DIR is :"
echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
echo "Starting the execution.."
time /home/biplavc/anaconda3/envs/LabPC_tf/bin/python main_tf.py
exit;
