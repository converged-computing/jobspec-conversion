#!/bin/bash
#FLUX: --job-name=SEE-KOMATSUNA
#FLUX: -t=14400
#FLUX: --urgency=16

cd see-segment; git log -n 1; cd ..
echo "Continuous Run Number $SLURM_ARRAY_TASK_ID"
timeout 85800s time singularity exec -B /usr/bin/:/sysbin/ \
                 --env PATH=/miniconda3/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sysbin/ \
                 --writable-tmpfs \
                 --env-file /opt/software/powertools/share/jupyter.env \
                 centos7.sif \
                 jupyter nbconvert --to notebook --execute --inplace --allow-errors KOMATSUNA_Batch.ipynb 
echo "FINNISHED RUNNING JOB"
