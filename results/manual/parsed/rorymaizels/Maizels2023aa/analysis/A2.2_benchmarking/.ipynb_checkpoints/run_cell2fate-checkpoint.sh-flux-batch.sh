#!/bin/bash
#FLUX: --job-name=bm_c2f
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=64800
#FLUX: --urgency=16

ml Python/3.10.8-GCCcore-12.2.0
module load CUDA/11.1.1-GCC-10.2.0
echo "$(which python)"
echo "$(which conda)"
echo "$(nvidia-smi)"
echo "$(nvcc --version)"
script=B11_cell2fate_benchmarking.py
environment_path=/camp/lab/briscoej/home/users/maizelr/envs_for_svm23/cell2fate_env
chmod -R 744 $environment_path
source $environment_path/bin/activate
if [ $? -ne 0 ]; then
    echo "Failed to activate virtual environment."
    exit 1
fi
python_path=$environment_path/bin
$python_path/python $script
