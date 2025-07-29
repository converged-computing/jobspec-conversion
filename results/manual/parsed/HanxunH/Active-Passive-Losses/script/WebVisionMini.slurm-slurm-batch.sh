#!/bin/bash
#SBATCH --account=punim0784
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:4
#SBATCH --mem=120G
#SBATCH --time=7-00:00:00

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /var/local/tmp/
mkdir -p datasets
mkdir -p datasets/ILSVR2012
pwd
echo 'rsync datasets'
rsync -avzh --progress /data/cephfs/punim0784/datasets/google_resized_256.tar                       datasets/
rsync -avzh --progress /data/cephfs/punim0784/datasets/webvision_mini_train.txt                     datasets/
rsync -avzh --progress /data/cephfs/punim0784/datasets/train_filelist_google.txt                    datasets/
rsync -avzh --progress /data/cephfs/punim0784/datasets/ILSVR2012/ILSVRC2012_img_val.tar             datasets/ILSVR2012/
rsync -avzh --progress /data/cephfs/punim0784/datasets/ILSVR2012/meta.bin                           datasets/ILSVR2012/
rsync -avzh --progress /data/cephfs/punim0784/datasets/ILSVR2012/ILSVRC2012_devkit_t12.tar.gz       datasets/ILSVR2012/
cd datasets
pwd
echo 'untar google_resized_256'
tar -xvf google_resized_256.tar
cd /data/cephfs/punim0784/robust_loss_nips
module load Python/3.6.4-intel-2017.u2-GCC-6.2.0-CUDA10
nvidia-smi
exp_name=$1
seed=$2
loss=$3
rm -rf ${exp_name}/web_vision_mini/${loss}/*
rm -rf ${exp_name}/web_vision_mini/${loss}
python3 -u main.py --data_parallel --exp_name ${exp_name}/webvision_mini/ --seed $seed --config_path configs/webvision_mini --version ${loss}
