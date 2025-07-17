#!/bin/bash
#FLUX: --job-name=N_CFD
#FLUX: -n=64
#FLUX: --queue=MAIN
#FLUX: -t=604800
#FLUX: --urgency=16

module load gcc openmpi vtk/latest felicia/latest mtc/tsv eigen/latest hdf5/latest cmake/latest git/latest petsc/latest mtc/latest
module load cimlibxx/master
conda activate cimlib # activate environment of the repo, modify name according to yours
python3 create_dataset.py --shapes_directory shapes --num_shapes 50 --params_IHM params_IHM.json --save_shapes --driver /home/tmichel/drivers/Release/cimlib_CFD_driver
