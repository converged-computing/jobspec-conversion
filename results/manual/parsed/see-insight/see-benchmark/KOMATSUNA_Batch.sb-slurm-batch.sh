#!/bin/bash
#FLUX: --job-name=SEE-KOMATSUNA
#FLUX: -t=86400
#FLUX: --urgency=16

cd see-segment; git log -n 1; cd ..
echo "Continuous Run Number $SLURM_ARRAY_TASK_ID"
timeout 85800s singularity exec -B /usr/bin/:/sysbin/ \
                 --env PATH=/miniconda3/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sysbin/ \
                 --writable-tmpfs \
                 --env-file /opt/software/powertools/share/jupyter.env \
                 centos7.sif \
                 python KOMATSUNA_Batch.py --knum $SLURM_ARRAY_TASK_ID --num_iter 1000000 
echo "FINNISHED RUNNING JOB"
