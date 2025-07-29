#!/bin/bash
#SBATCH --job-name=Gd-sTPATCN_2V1A_FMN_05NPT_100-150ns_Restart
#SBATCH --output=./2V1A_FMN/05NPT_100-150ns/output.%j.out
#SBATCH --mail-user=sheppard@ucsb.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-12:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=6

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
