#!/bin/bash
#FLUX: --job-name=kerasTunerTest-r2_large_res
#FLUX: --queue=cpu-short
#FLUX: -t=300
#FLUX: --urgency=16

export ENV='/home/s2358093/data1/conda_envs/hvm-05'
export CWD='$(pwd)'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$TENSORRT_PATH/'

echo "With env hvm-05"
export ENV=/home/s2358093/data1/conda_envs/hvm-05
echo "[$SHELL] #### Starting Python test"
echo "[$SHELL] ## This is $SLURM_JOB_USER and this job has the ID $SLURM_JOB_ID"
export CWD=$(pwd)
echo "[$SHELL] ## current working directory: "$CWD
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
echo "conda prefix: $CONDA_PREFIX"
TENSORRT_PATH=$CONDA_PREFIX/lib/python3.10/site-packages/tensorrt
echo "TENSORRT_PATH: $TENSORRT_PATH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$TENSORRT_PATH/
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
conda info
echo "=================== [$SHELL] Run python prog ========================="
python kerasTuner-20-get-results.py
echo "[$SHELL] Script finished"
