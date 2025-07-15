#!/bin/bash
#FLUX: --job-name=avg_land_short
#FLUX: --queue=cpu-short
#FLUX: -t=7200
#FLUX: --urgency=16

export CWD='$(pwd)'
export LD_LIBRARY_PATH='/home/s2358093/.conda/envs/AutoML4SeaIce/lib:$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/'

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
conda activate AutoML4SeaIce
echo "conda env activated"
python --version
export LD_LIBRARY_PATH=/home/s2358093/.conda/envs/AutoML4SeaIce/lib:$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
echo "[$SHELL] ## Run script"
python calculate_avg.py
echo "[$SHELL] #### Finished Python test. Have a nice day"
