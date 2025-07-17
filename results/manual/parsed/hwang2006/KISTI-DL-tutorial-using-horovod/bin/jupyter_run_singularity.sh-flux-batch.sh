#!/bin/bash
#FLUX: --job-name=anxious-soup-4111
#FLUX: -c=4
#FLUX: --queue=amd_a100nv_8
#FLUX: -t=28800
#FLUX: --urgency=16

if [ -e port_forwarding_command ]
then
  rm port_forwarding_command
fi
SERVER="`hostname`"
PORT_JU=$(($RANDOM + 10000 )) # some random number greaten than 10000
echo $SERVER
echo $PORT_JU 
echo "ssh -L localhost:8888:${SERVER}:${PORT_JU} ${USER}@neuron.ksc.re.kr" > port_forwarding_command
echo "ssh -L localhost:8888:${SERVER}:${PORT_JU} ${USER}@neuron.ksc.re.kr"
echo "execute jupyter"
singularity run --nv /scratch/qualis/git-projects/tensorflow-pytorch-horovod:tf2.10_pt1.13.sif jupyter lab --ip=0.0.0.0 --port=${PORT_JU} --NotebookApp.token=${USER} #jupyter token: your account ID 
echo "end of the job"
