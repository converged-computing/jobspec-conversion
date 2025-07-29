#!/bin/bash
#SBATCH --job-name=CAAEfromscratch
#SBATCH --mail-user=xxxx@ucdconnect.ie
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=15

cd $SLURM_SUBMIT_DIR
cd Face_Aging_CAAE_10age
module load tensorflowgpu
python main.py --is_train True --dataset ../DATA/TrainingSet_CACD2000 --savedir save --use_trained_model false --use_init_model false
