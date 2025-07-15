#!/bin/bash
#FLUX: --job-name=chocolate-puppy-1570
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
date
module load paraview/5.10.0-egl
srun -n 28 pvbatch render1.py -W 7680 -H 4320 -o frames1 -i /ccs/home/henrylb/project/aradhakr34/master/MFC-develop/samples/3D_bubbles_monopole_many/silo_hdf5
