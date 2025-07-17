#!/bin/bash
#FLUX: --job-name=CDtutorial
#FLUX: -c=4
#FLUX: --queue=boost_usr_prod
#FLUX: -t=3600
#FLUX: --urgency=16

cd /leonardo_work/ICT24_ESP/sdigioia/Tutorial-causal-discovery/
source $HOME/.bashrc
module load profile/deeplrn
module load cuda/11.8
module load gcc/11.3.0
module load nccl
module load llvm
module load gsl
module load openmpi
conda activate /leonardo_work/ICT24_ESP/sdigioia/envs/newRLenv
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
portval=8887
echo -e "
ssh -N -f -L $portval:${node}:$portval ${user}@$login.leonardo.cineca.it
http://localhost:$portval/
"
jupyter-notebook --no-browser --ip=${node} --port=${portval}
sleep 36000
