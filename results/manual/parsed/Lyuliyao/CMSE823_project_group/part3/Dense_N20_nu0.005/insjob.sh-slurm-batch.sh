#!/bin/bash
#SBATCH --job-name=Incomp_NS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --constraint=amr

module load intel  ### load necessary modules.
module load GCCcore/9.3.0 
module load FFmpeg
ifort -o kalle_anka.x ins.f90 -mkl
srun ./kalle_anka.x                 ### call your executable. (use srun instead of mpirun.)
matlab -nodisplay -r "pl"
srun ffmpeg -r 10 -i frame"%05d".jpg -vf "crop=trunc(iw/2)*2:trunc(ih/2)*2" Dense_N20_nu0.005.mp4 
scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
