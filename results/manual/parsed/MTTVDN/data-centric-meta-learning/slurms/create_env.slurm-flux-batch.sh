#!/bin/bash
#FLUX: --job-name=creating_env_1
#FLUX: --queue=testing
#FLUX: -t=3600
#FLUX: --priority=16

export CWD='$(pwd)'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/'

ENV=/home/s2042096/data1/.conda/envs/thesis
echo "[$SHELL] #### Starting environment creation"
echo "[$SHELL] ## This is $SLURM_JOB_USER and this job has the ID $SLURM_JOB_ID"
export CWD=$(pwd)
echo "[$SHELL] ## current working directory: "$CWD
conda info
conda env remove -p $ENV
echo "[$SHELL] ## ***** removed *****"
conda create --prefix $ENV
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
conda activate $ENV
echo "[$SHELL] ## ***** conda env activated *****"
conda info
LD_LIBRARY_PATH=/data1/s2042096/.conda/envs/thesis/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
echo "[$SHELL] ## after setting"
conda env update -p $ENV --file $CWD/environment.yml
echo "***** yml file loaded *****"
echo "[$SHELL] #### Finished Python test. Have a nice day"
