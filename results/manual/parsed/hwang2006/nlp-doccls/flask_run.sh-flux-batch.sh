#!/bin/bash
#FLUX: --job-name=expensive-car-2228
#FLUX: -c=4
#FLUX: --queue=amd_a100nv_8
#FLUX: -t=3600
#FLUX: --urgency=16

if [ -e flask_port_forwarding_command ]
then
  rm flask_port_forwarding_command
fi
SERVER="`hostname`"
PORT_JU=$(($RANDOM + 10000 )) # some random number greaten than 10000
echo $SERVER
echo $PORT_JU 
echo "ssh -L localhost:5000:${SERVER}:${PORT_JU} ${USER}@neuron.ksc.re.kr" > flask_port_forwarding_command
echo "ssh -L localhost:5000:${SERVER}:${PORT_JU} ${USER}@neuron.ksc.re.kr"
echo "load module-environment"
module load cuda/11.7
echo "execute flask"
source ~/.bashrc
conda activate nlp
cd /scratch/qualis/nlp-doccls-deploy
flask --app doc-cls-deploy.py run --host=0.0.0.0 --port=${PORT_JU} --debug
echo "end of the job"
