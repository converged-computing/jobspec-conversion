#!/bin/bash
#FLUX: --job-name=expressive-cinnamonbun-0671
#FLUX: --queue=parallel
#FLUX: -t=3600
#FLUX: --urgency=16

export XDG_RUNTIME_DIR=''

IP=$(hostname -i)
PORT=$(shuf -i 2000-65000 -n 1)
export XDG_RUNTIME_DIR=""
module use /home/software/tools/eb_modulefiles/all/Core  #new module system
module load foss/2020b
module load JupyterLab/2.2.8
jupyter-lab --ip=$IP --port=$PORT --no-browser &
sleep 5 #wait for ntoebook to start
TOKEN=$(jupyter notebook list | cut -d '?' -f 2 | cut -d ' ' -f 1 | grep -v "Currently")
echo " "
echo " "
echo "In a  new terminal (on the machine you are connecting to Raapoi *from*) create an ssh tunnel"
echo "ssh -L $PORT:$IP:$PORT $USER@raapoi.vuw.ac.nz"
echo " "
echo "Then on your local browser copy paste: "
echo "http://127.0.0.1:$PORT/?$TOKEN"
echo " "
echo "When you are don't please remember to cancel the job or it will waste resources!"
echo "scancel $SLURM_JOB_ID"
