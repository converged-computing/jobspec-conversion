#!/bin/bash
#FLUX: --job-name=convertDataToNpy-01
#FLUX: --queue=testing
#FLUX: -t=3600
#FLUX: --priority=16

export ENV='/home/s2358093/data1/conda_envs/xarray'
export CWD='$(pwd)'

echo "With env convertDataToNpy-01"
cd /home/s2358093/data1/hvm/hvm-alice
export ENV=/home/s2358093/data1/conda_envs/xarray
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
conda info
echo "[$SHELL] Run script"
python convertDataToNpy.py
echo "[$SHELL] Script finished"
