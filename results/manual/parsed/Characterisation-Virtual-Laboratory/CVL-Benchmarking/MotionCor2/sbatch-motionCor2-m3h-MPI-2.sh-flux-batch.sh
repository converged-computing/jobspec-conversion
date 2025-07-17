#!/bin/bash
#FLUX: --job-name=P100MPI2GPU
#FLUX: -n=3
#FLUX: --queue=m3h
#FLUX: -t=10800
#FLUX: --urgency=16

nvidia-smi -l 1 -q -x -f /home/userName/br76_scratch/relion21_tutorial/pMOSP/nvidiaLogging-m3h-MPI-2.xml &
nvidiaPID=$!
module load relion/3.0-stable-cuda91
module load motioncor2/2.1.10-cuda9.1
srun -n 2 `which relion_run_motioncorr_mpi` --i Import/job001/movies.star --o JMotionCor/job-m3h-MPI-2/ --save_movies  --first_frame_sum 1 --last_frame_sum 0 --use_motioncor2 --bin_factor 1 --motioncor2_exe /usr/local/motioncor2/2.1.10-cuda9.1/bin/MotionCor2_1.1.0-Cuda91 --bfactor 150 --angpix 1 --patch_x 3 --patch_y 3 --other_motioncor2_args " -PixSize 0.97 " --gpu "" --dose_weighting --voltage 300 --dose_per_frame 1 --preexposure 0
kill $nvidiaPID
