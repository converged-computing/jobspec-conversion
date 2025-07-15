#!/bin/bash
#FLUX: --job-name=spicy-punk-3620
#FLUX: -t=86400
#FLUX: --priority=16

export PRECXX11ABI='1'
export CUDA='11.7'
export WANDB_API_KEY='07dce1789bed58aeeab69df88f3327bb330dd5a6'
export HDF5_USE_FILE_LOCKING='FALSE'
export NCCL_NET_GDR_LEVEL='PHB'
export MASTER_ADDR='$(hostname)'
export LD_LIBRARY_PATH='/apps/spack/gilbreth/apps/anaconda/5.3.1-py37-gcc-4.8.5-7vvmykn/lib:$LD_LIBRARY_PATH'

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
echo "Current date completed loading modules: $now"
source  /apps/spack/gilbreth/apps/anaconda/5.3.1-py37-gcc-4.8.5-7vvmykn/etc/profile.d/conda.sh
conda activate pytorch
export WANDB_API_KEY=07dce1789bed58aeeab69df88f3327bb330dd5a6
source ./export_DDP_vars.sh
config_file=/scratch/gilbreth/gupt1075/FourCastNet/config/AFNO.yaml
config='afno_backbone_finetune'
run_num='2'
export HDF5_USE_FILE_LOCKING=FALSE
export NCCL_NET_GDR_LEVEL=PHB
export MASTER_ADDR=$(hostname)
export LD_LIBRARY_PATH=/apps/spack/gilbreth/apps/anaconda/5.3.1-py37-gcc-4.8.5-7vvmykn/lib:$LD_LIBRARY_PATH
set -x
python /scratch/gilbreth/gupt1075/FourCastNet/train.py --enable_amp --yaml_config=$config_file --config=$config --run_num=$run_num
