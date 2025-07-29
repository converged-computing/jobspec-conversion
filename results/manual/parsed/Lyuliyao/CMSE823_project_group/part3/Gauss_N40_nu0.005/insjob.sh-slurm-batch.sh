#!/bin/bash
#FLUX: --job-name=Incomp_NS
#FLUX: -t=43200
#FLUX: --urgency=16

module load intel  ### load necessary modules.
module load GCCcore/9.3.0 
module load FFmpeg/4.2.2
ifort -o kalle_anka.x ins.f90 -mkl
srun ./kalle_anka.x                 ### call your executable. (use srun instead of mpirun.)
matlab -nodisplay -r "pl"
srun ffmpeg -r 10 -i frame"%05d".jpg -vf "crop=trunc(iw/2)*2:trunc(ih/2)*2" Gauss_N100_nu0.005.mp4 
scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
