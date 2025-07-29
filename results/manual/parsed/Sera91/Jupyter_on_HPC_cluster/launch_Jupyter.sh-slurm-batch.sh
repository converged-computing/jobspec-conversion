#!/bin/bash
#SBATCH --job-name=CDtutorial
#SBATCH --account=ict24_esp
#SBATCH --output=jupyter_notebook.txt
#SBATCH --error=jupyter_notebook.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10000
#SBATCH --time=01:00:00
#SBATCH --partition=boost_usr_prod
#SBATCH --constraint=ntasks-per-node=8

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
