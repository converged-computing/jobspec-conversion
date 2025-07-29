#!/bin/bash
#SBATCH --job-name=GL_SIM
#SBATCH --output=SHAREDDIR/simulation.out.log
#SBATCH --error=SHAREDDIR/simulation.err.log
#SBATCH --nodes=1
#SBATCH --ntasks=120
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=10G
#SBATCH --time=5-00:30:00
#SBATCH --partition=compute

export PATH='$NEURONHOME/nrn/x86_64/bin:$NEURONHOME/iv/x86_64/bin:$PATH'
export LD_LIBRARY_PATH='$NEURONHOME/nrn/x86_64/lib:$NEURONHOME/iv/x86_64/lib:$LD_LIBRARY_PATH'

export PATH=... # Set paths for python, etc. here
NEURONHOME=... # Set your NEURONHOME here
export PATH=$NEURONHOME/nrn/x86_64/bin:$NEURONHOME/iv/x86_64/bin:$PATH
export LD_LIBRARY_PATH=$NEURONHOME/nrn/x86_64/lib:$NEURONHOME/iv/x86_64/lib:$LD_LIBRARY_PATH
echo PYTHONPATH is $PYTHONPATH
echo "==============Starting mpirun==============="
cd SHAREDDIR/model
mpirun nrniv -mpi -python main.py
echo "==============Mpirun has ended==============="
mkdir $HOME/work/output.$JOB_ID
cp -v *.dat $HOME/work/output.$JOB_ID
cp -v *.bin $HOME/work/output.$JOB_ID
cp -R $PARAMDIR $HOME/work/output.$JOB_ID
< none
