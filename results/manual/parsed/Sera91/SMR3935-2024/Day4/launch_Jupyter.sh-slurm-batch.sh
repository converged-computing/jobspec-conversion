#!/bin/bash
#FLUX: --job-name=Jupylab
#FLUX: -c=2
#FLUX: --queue=boost_usr_prod
#FLUX: -t=4500
#FLUX: --urgency=16

cd $SCRATCH/SMR-3935/Day4
source $HOME/Conda_init.txt
module load profile/deeplrn
module load cuda/11.8
module load gcc/11.3.0
module load openmpi/4.1.4--gcc--11.3.0-cuda-11.8  
module load llvm/13.0.1--gcc--11.3.0-cuda-11.8  
module load nccl/2.14.3-1--gcc--11.3.0-cuda-11.8
module load gsl/2.7.1--gcc--11.3.0-omp
conda activate /leonardo/pub/userexternal/sdigioia/sdigioia/env/Gabenv
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
portval=88$(whoami | cut -b 7-9)
echo -e "
ssh  -o \"PreferredAuthentications=keyboard-interactive,password\" -o \"StrictHostKeyChecking=no\" -o \"UserKnownHostsFile=/dev/null\" -o \"LogLevel ERROR\"  -N -f -L  $portval:${node}:$portval ${user}@login.leonardo.cineca.it
http://localhost:$portval/
"
jupyter-notebook --no-browser --ip=${node} --port=${portval}
sleep 36000
