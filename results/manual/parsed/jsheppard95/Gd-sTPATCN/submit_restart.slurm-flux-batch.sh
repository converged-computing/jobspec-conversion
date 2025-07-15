#!/bin/bash
#FLUX: --job-name=Gd-sTPATCN_2V1A_FMN_05NPT_100-150ns_Restart
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load singularity 
/bin/hostname
singularity run --nv  /sw/singularity/SingularityImages/gromacs-2021.sif << EOF
cd /home/jsheppard/research/Gd-sTPATCN/2V1A_FMN/05NPT_100-150ns/
echo "getting ready to run"
gmx mdrun  -ntmpi 1 -ntomp $SLURM_NTASKS  -nb gpu  -pin on -deffnm npt  -cpi npt.cpt
date
EOF
sleep 10
