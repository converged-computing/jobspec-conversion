#!/bin/bash
#FLUX: --job-name=buttery-general-8862
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
echo "load module-environment"
module load gcc/10.2.0 cuda/11.4 cudampi/openmpi-4.1.1
echo "execute jupyter"
source ~/.bashrc
conda activate horovod
cd /scratch/$USER     # the root/work directory of Jupyter lab/notebook
jupyter lab --ip=0.0.0.0 --port=${PORT_JU} --NotebookApp.token=${USER} #jupyter token: your account ID 
echo "end of the job"
