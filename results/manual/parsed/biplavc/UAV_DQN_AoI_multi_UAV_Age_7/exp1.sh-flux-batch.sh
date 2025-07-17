#!/bin/bash
#FLUX: --job-name=delicious-platanos-3972
#FLUX: --queue=v100_normal_q
#FLUX: -t=54000
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
