#!/bin/bash
#FLUX: --job-name=Gd-sTPATCN_2V1A_02NPT
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load singularity 
/bin/hostname
singularity run --nv  /sw/singularity/SingularityImages/gromacs-2021.sif << EOF
cd /home/jsheppard/research/Gd-sTPATCN/2V1A_FMN/02NPT/
echo "getting ready to run"
gmx mdrun  -ntmpi 1 -ntomp $SLURM_NTASKS  -nb gpu  -pin on  -deffnm npt
date
EOF
sleep 10
