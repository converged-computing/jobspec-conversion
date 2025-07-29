#!/bin/bash
#SBATCH --job-name=TORCH-GPU
#SBATCH --output=./log/inst_n.out.%j
#SBATCH --error=./log/inst_n.err.%j
#SBATCH --mail-user=qi.wang@tuebingen.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:4
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu
#SBATCH --chdir=/u/wangqi/torch_env/crop_gan

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
srun python /u/wangqi/git_wq/test_3d_SR/mains/train_script_instnoise_wandb.py --path /ptmp/wangqi/transfer_folder/LS200X_Norm/LS_all_subj_norm/crops --path_save /ptmp/wangqi/saved_models --model instancenoise_res10_b16_1subj --checkpoint 4 --precision 1 --batch_size 16 --epochs 6 --lr .0001 --inst_noise 0 --FE_type 'resnet10' --D_type 'Discriminator_Unet' --update_FE
echo "Jobs finished"
