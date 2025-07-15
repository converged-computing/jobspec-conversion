#!/bin/bash
#FLUX: --job-name=preprocess_bedroom           # Job name
#FLUX: -c=24
#FLUX: --queue=submit
#FLUX: --priority=16

date;hostname;pwd
echo "Job Name = $SLURM_JOB_NAME"
__conda_setup="$('/rhome/ynie/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/rhome/ynie/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/rhome/ynie/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/rhome/ynie/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda activate ss
python utils/threed_front/1_process_viewdata.py --room_type bed --n_processes 24
