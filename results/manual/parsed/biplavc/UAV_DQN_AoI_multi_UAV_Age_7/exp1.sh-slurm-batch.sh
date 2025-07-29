#!/bin/bash
#SBATCH --account=vijays
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=200G
#SBATCH --time=15:00:00
#SBATCH --partition=v100_normal_q

module purge
module load cuda/10.1.168
module load cudnn/7.6.5
echo "SLURM_SUBMIT_DIR is :"
echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
echo "Starting the execution.."
time /home/biplavc/anaconda3/envs/LabPC_tf/bin/python main_tf.py
exit;
