#!/bin/bash
#FLUX: --job-name=jupyter_cpu
#FLUX: -c=4
#FLUX: --queue=genx
#FLUX: -t=172800
#FLUX: --urgency=16

port=$(shuf -i 10000-65500 -n 1)
/usr/bin/ssh -N -f -R $port:localhost:$port rusty1
/usr/bin/ssh -N -f -R $port:localhost:$port rusty2
/usr/bin/ssh -N -f -R $port:localhost:$port rustyamd1
/usr/bin/ssh -N -f -R $port:localhost:$port rustyamd2
cat<<EOF
Jupyter server is running on: $(hostname)
Job starts at: $(date)
Step 1 :
If you are working in NYU campus, please open an iTerm window, run command
ssh -L $port:localhost:$port $USER@rusty.flatironinstitute.org
If you are working off campus, you should already have ssh tunneling setup through HPC bastion host,
that you can directly login to flatiron with command
ssh $USER@flatiron
Please open an iTerm window, run command
ssh -L $port:localhost:$port $USER@flatiron
Step 2:
Keep the iTerm windows in the previouse step open. Now open browser, find the line with
The Jupyter Notebook is running at: $(hostname)
the URL is something: http://localhost:${port}/?token=XXXXXXXX (see your token below)
you should be able to connect to jupyter notebook running remotely on flatiron compute node with above url
EOF
unset XDG_RUNTIME_DIR
if [ "$SLURM_JOBTMP" != "" ]; then
    export XDG_RUNTIME_DIR=$SLURM_JOBTMP
fi
source /mnt/home/blyo1/miniconda3/bin/activate pyenv38
jupyter lab --no-browser --ip=0.0.0.0 --port=$port --notebook-dir=$(pwd)
