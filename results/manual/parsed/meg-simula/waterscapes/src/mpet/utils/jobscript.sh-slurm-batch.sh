#!/bin/bash
#SBATCH --job-name=MPET
#SBATCH --account=nn9279k
#SBATCH --output=MPET.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00

export PYTHONPATH='$PYTHONPATH:$HOME/.local/lib/python2.7/site-packages/'

source /cluster/bin/jobsetup
echo $SCRATCH
source ~oyvinev/fenics1.6/fenics1.6
export PYTHONPATH=$PYTHONPATH:$HOME/.local/lib/python2.7/site-packages/
cleanup "mkdir -p /work/users/piersanti/MPET_output"
cleanup "cp -r $SCRATCH /work/users/piersanti/MPET_output"
cp -r /usit/abel/u1/piersanti/MPET $SCRATCH
cd $SCRATCH
cd MPET
mpirun --bind-to none python prova.py
