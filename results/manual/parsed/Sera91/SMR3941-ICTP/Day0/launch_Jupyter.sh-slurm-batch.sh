#!/bin/bash
#SBATCH --job-name=Jupylab
#SBATCH --account=tra24_ictp_ml
#SBATCH --output=jupyter_notebook.txt
#SBATCH --error=jupyter_notebook.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10000
#SBATCH --time=01:15:00
#SBATCH --constraint=ntasks-per-node=2

cd $SCRATCH/SMR3941-ICTP/
source $HOME/Conda_init.txt
module load profile/deeplrn
module load cuda/11.8
module load gcc/11.3.0
module load openmpi/4.1.4--gcc--11.3.0-cuda-11.8  
module load llvm/13.0.1--gcc--11.3.0-cuda-11.8  
module load nccl/2.14.3-1--gcc--11.3.0-cuda-11.8
module load gsl/2.7.1--gcc--11.3.0-omp
module load fftw/3.3.10--gcc--11.3.0
conda activate /leonardo/pub/usertrain/a08trc01/env/SMR3941
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
