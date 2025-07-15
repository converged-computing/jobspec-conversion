#!/bin/bash
#FLUX: --job-name=GL_SIM
#FLUX: -n=120
#FLUX: -c=2
#FLUX: --queue=compute
#FLUX: -t=433800
#FLUX: --priority=16

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
