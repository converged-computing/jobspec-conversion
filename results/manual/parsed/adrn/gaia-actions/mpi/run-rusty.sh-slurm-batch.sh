#!/bin/bash
#SBATCH --job-name=actions
#SBATCH --output=logs/actions.o%j
#SBATCH --error=logs/actions.e%j
#SBATCH --nodes=12
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00

source ~/.bash_profile
cd /mnt/ceph/users/apricewhelan/projects/gaia-actions/scripts
init_env
date
mpirun python compute_actions.py -v --mpi --staeckel \
    -f ../data/a23_tab2_bjcoords.h5 \
    --id-col=source_id \
    -p ../potentials/MilkyWayPotential2022.yml \
    --dist-col=r_med_geo_kpc
date
