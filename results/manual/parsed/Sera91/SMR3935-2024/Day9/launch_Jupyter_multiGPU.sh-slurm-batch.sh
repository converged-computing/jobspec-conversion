#!/bin/bash
#SBATCH --job-name=Jupylab
#SBATCH --account=tra24_ictp_np
#SBATCH --output=jupyter_notebook.txt
#SBATCH --error=jupyter_notebook.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=01:15:00
#SBATCH --constraint=ntasks-per-node=4

source $HOME/Conda_init.txt
module load profile/deeplrn
module load cuda/11.8
module load gcc/11.3.0
module load openmpi/4.1.4--gcc--11.3.0-cuda-11.8  
module load llvm/13.0.1--gcc--11.3.0-cuda-11.8  
module load nccl/2.14.3-1--gcc--11.3.0-cuda-11.8
module load gsl/2.7.1--gcc--11.3.0-omp
conda activate /leonardo_scratch/large/usertrain/$USER/env/SMR3935
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
portval=89$(whoami | cut -b 7-9)
echo -e "
ssh  -o \"PreferredAuthentications=keyboard-interactive,password\" -o \"StrictHostKeyChecking=no\" -o \"UserKnownHostsFile=/dev/null\" -o \"LogLevel ERROR\"  -N -f -L  $portval:${node}:$portval ${user}@login.leonardo.cineca.it
http://localhost:$portval/
"
jupyter-notebook --no-browser --ip=${node} --port=${portval}
sleep 36000
