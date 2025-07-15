#!/bin/bash
#FLUX: --job-name=hvm-env05
#FLUX: --queue=gpu-short
#FLUX: -t=3600
#FLUX: --priority=16

export ENV='/home/s2358093/data1/conda_envs/hvm-05'
export CWD='$(pwd)'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:${TENSORRT_PATH}/'

echo # Build with tf 2.9.2"
cd /home/s2358093/data1/hvm/hvm-alice
export ENV=/home/s2358093/data1/conda_envs/hvm-05
echo "[$SHELL] #### Starting Python test"
echo "[$SHELL] ## This is $SLURM_JOB_USER and this job has the ID $SLURM_JOB_ID"
export CWD=$(pwd)
echo "[$SHELL] ## current working directory: "$CWD
conda info
conda env remove -p ${ENV}
echo "[$SHELL] ## ***** removed *****"
conda create --prefix ${ENV} python=3.10
echo "[$SHELL] ## ***** created *****"
__conda_setup="$('/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/etc/profile.d/conda.sh" ]; then
        . "/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/etc/profile.d/conda.sh"
    else
        export PATH="/cm/shared/easybuild/GenuineIntel/software/Miniconda3/4.9.2/bin:$PATH"
    fi
fi
unset __conda_setup
conda activate ${ENV}
echo "[$SHELL] ## ***** conda env activated *****"
echo "set LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
conda info
conda install --prefix ${ENV} -c conda-forge cudatoolkit=11.2 cudnn=8.1.0
pip install nvidia-tensorrt==8.4.1.5
TENSORRT_PATH=$CONDA_PREFIX/lib/python3.10/site-packages/tensorrt
ln -s ${TENSORRT_PATH}/libnvinfer_plugin.so.8 ${TENSORRT_PATH}/libnvinfer_plugin.so.7
ln -s ${TENSORRT_PATH}/libnvinfer.so.8 ${TENSORRT_PATH}/libnvinfer.so.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${TENSORRT_PATH}/
pip install tensorflow==2.9.2
pip install matplotlib
pip install keras-tuner -q
pip install python-dotenv
nvidia-smi
echo "conda prefix: $CONDA_PREFIX"
python --version
PY_PROG=$(cat <<EOF
import tensorflow as tf
print('## TF version:')
print(tf. __version__)
print('## CPU setup:')
print(tf.reduce_sum(tf.random.normal([1000, 1000])))
print('## GPU setup physical:')
print(tf.config.list_physical_devices('GPU'))
print('## GPU setup logical:')
print(tf.config.list_logical_devices('GPU'))
print('## GPU Device name:')
print(tf.test.gpu_device_name())
EOF
)
python -c "$PY_PROG"
echo "[$SHELL] #### Finished Python test. Have a nice day"
