#!/bin/bash
#SBATCH --job-name=fourcastnet_job
#SBATCH --account=gdsp-k|standby
#SBATCH --output=/scratch/gilbreth/gupt1075/infer_fourcastnet_nov.out
#SBATCH --error=/scratch/gilbreth/gupt1075/infer_fourcastnet_nov.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=32,v100|a100|a30

export PRECXX11ABI='1'
export CUDA='11.7'

module --force purge
unset PYTHONPATH
module load anaconda/5.3.1-py37
module load cuda/11.7.0
module load cudnn/cuda-11.7_8.6
module use /depot/gdsp/etc/modules
module load utilities monitor
module load rcac
module list
export PRECXX11ABI=1
export CUDA="11.7"
echo $PYTHONPATH
echo "$now"
echo "Current date completed loading modules: $now"
conda activate /home/gupt1075/.conda/envs/cent7/5.3.1-py37/pytorch
python /scratch/gilbreth/gupt1075/FourCastNet/inference/inference_precip.py \
       --config=precip \
       --run_num=0 \
       -weights '/scratch/gilbreth/gupt1075/model_weights/FCN_weights_v0/precip.ckpt' \
       --override_dir '/scratch/gilbreth/gupt1075/ERA5_expts_gtc/precip/'
