#!/bin/bash
#FLUX: --job-name=SRGAN
#FLUX: -c=10
#FLUX: -t=3600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:${CUDA_HOME}/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/'

module load nixpkgs/16.09 gcc/7.3.0 opencv/4.2.0 python/3.7 cuda/10.1 cudnn/7.6.5 arch/avx512 StdEnv/2018.3
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${CUDA_HOME}/lib64:/cvmfs/soft.computecanada.ca/easybuild/software/2017/CUDA/cuda10.1/cudnn/7.6.5/lib64/
echo "Job start at $(date)"
nvidia-smi
SOURCEDIR=$(pwd)
echo "source directory: $SOURCEDIR"
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index -r $SOURCEDIR/requirements.txt
mkdir $SLURM_TMPDIR/data
tar xf ~/projects/def-panos/shared_itmo/bridge.tar -C $SLURM_TMPDIR/data
python main.py \
	--input_dir $SLURM_TMPDIR/data/bridge/SDR \
	--target_dir $SLURM_TMPDIR/data/bridge/HDR \
	--image_size 96 \
	--lr 1e-4 \
	--save_iter 200 \
	--epochs 10 \
	--batch_size 8
echo "Job finish at $(date)"
