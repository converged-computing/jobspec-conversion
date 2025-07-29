#!/bin/bash
#SBATCH --job-name=NV_020823_Denoising
#SBATCH --output=../FAD_WUnet_0928_cervix_SSIMR2_new_seed0_loss_larger.%j.out
#SBATCH --error=../FAD_WUnet_0928_cervix_SSIMR2_new_seed0_loss_larger.%j.err
#SBATCH --mail-user=nvora01@tufts.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=30g
#SBATCH --time=5-00:00:00
#SBATCH --partition=patralab
#SBATCH --exclude=cc1gpu005

module load anaconda/2021.05
source activate Denoising
git pull
echo "Starting python script..." 
echo "==========================================================" 
echo "" # empty line #
python -u main.py train wunet "FAD_WUnet_0928_cervix_SSIMR2_new_seed0_loss_larger" cwd=.. fad_data=NV_928_FAD_Training.npz  loss="ssimr2_loss"  val_seed=0 val_split=10 ssim_FSize=3 ssim_FSig=0.5 loss_alpha=0.84 test_flag=1 train_mode=0 wavelet_function=bior1.1
