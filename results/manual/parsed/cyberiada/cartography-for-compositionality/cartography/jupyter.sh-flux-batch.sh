#!/bin/bash
#FLUX: --job-name=JupiterNotebook
#FLUX: --queue=mid
#FLUX: -t=43200
#FLUX: --urgency=16

echo "======================="
echo "Loading Anaconda Module..."
module load cuda/10.2
module load cudnn/8.1.1/cuda-10.2
echo "======================="
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
XDG_RUNTIME_DIR=""
port=$(shuf -i 6000-6999 -n1)
node=$(hostname -s)
user=$(whoami)
echo -e "
 For more info and how to connect from windows, 
   see http://login.kuacc.ku.edu.tr/#h.p3tmxkpdxjsz
 Here is the MobaXterm info:
Forwarded port:same as remote port
Remote server: ${node}
Remote port: ${port}
SSH server: login.kuacc.ku.edu.tr
SSH login: $user
SSH port: 22
====================================================================================
 MacOS or linux terminal command to create your ssh tunnel on your local machine:
ssh -N -L ${port}:${node}:${port} ${user}@login.kuacc.ku.edu.tr
====================================================================================
WAIT 1 MINUTE, WILL BE CONNECT ADDRESS APPEARS!
"
jupyter-lab --no-browser --port=${port} --ip="*"
