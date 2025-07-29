#!/bin/bash
#SBATCH --job-name=LEXTREME
#SBATCH --mail-user=ronja.stern@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:rtx3090:1
#SBATCH --mem=64GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=job_gpu_preempt
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=2-4

module load Workspace Anaconda3/2021.11-foss-2021a CUDA/11.3.0-GCC-10.2.0
eval "$(conda shell.bash hook)"
conda activate scp-test
python main.py --task swiss_bge_criticality_prediction -gm 24 -bz 8 -los 1 --num_train_epochs 10 -ld results/test_scp --language_model_type microsoft/mdeberta-v3-base --hierarchical True --running_mode experimental
