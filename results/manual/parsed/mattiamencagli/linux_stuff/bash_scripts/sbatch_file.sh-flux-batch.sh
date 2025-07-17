#!/bin/bash
#FLUX: --job-name=PLUTO
#FLUX: --queue=prod
#FLUX: -t=1200
#FLUX: --urgency=16

source ${HOME}/modules_files/pluto_mod
nvidia-smi
cd gpluto_cpp/
python3 test_pluto.py --auto-update
python3 test_pluto.py --start-from 0:0
 #nsys profile --trace=cuda,mpi,nvtx,openacc --force-overwrite true -o report_MHD_highorder_BLAST_B1_gpu4_leo mpirun -np 4 ./pluto     #profile multiple gpus
 #nsys profile --force-overwrite true -o report_MHD_BLAST_B3_304cube_leo_o1 ./pluto -maxsteps 10 -xres 304                             #profile single gpu
 #ncu -k regex:Roe_Solver -f -o NCUreport_MHD_BLAST_B3_304cube_leo ./pluto -maxsteps 2 -xres 304                                       #profile a kernel that include "Roe_Solver" in its name
