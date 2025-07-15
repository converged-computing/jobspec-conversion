#!/bin/bash
#FLUX: --job-name=loopy-squidward-7434
#FLUX: -N=2
#FLUX: --queue=gll_usr_prod
#FLUX: -t=7200
#FLUX: --urgency=16

module load intel/pe-xe-2018--binary
module load intelmpi/2018--binary
module load python/2.7.12
echo "# Add Neuron and IV to path variable" >> ~/.bashrc
echo 'export PATH="$HOME/neuron/nrn/x86_64/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/neuron/iv/x86_64/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
cd /gpfs/work/HBP_CDP21_it_1/Emiliano/modeldb-bulb3d/sim
mpirun nrniv -mpi -python bulb3dtest.py
