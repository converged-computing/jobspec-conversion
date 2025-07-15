#!/bin/bash
#FLUX: --job-name=tart-milkshake-1461
#FLUX: --priority=16

export KMP_AFFINITY='disabled'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export XDG_CONFIG_HOME='/dev/shm'

export KMP_AFFINITY=disabled
export MPICH_GNI_FORK_MODE=FULLCOPY
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export XDG_CONFIG_HOME=/dev/shm
load_desiconda
source ../../../DRONES_ENV.sh
counter=0
tot_counter=1
name_for_run=elg_ngc_run
chunk=chunk23
while [ $counter -lt $tot_counter ]
do
    srun -N 1 -n 8 -c 8 python collect_mpi.py --name_for_run ${name_for_run} --split_idx $counter --N_split $tot_counter &
    let counter=counter+1 
done
wait
echo start stacking finished images, this might be a long time...
srun -N 1 -n 1 -c 64 python stack.py $tot_counter $name_for_run $chunk
echo cut images with vetomask
cd /global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_code/py/obiwan/Drones/obiwan_analysis/preprocess/brickmask/
srun -N 1 -n 1 -c 64 python /global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_code/py/obiwan/Drones/obiwan_analysis/preprocess/brickmask/cutting.py --name_for_run ${name_for_run} --chunk ${chunk}
echo really_mask images
srun -N 1 -n 1 -c 64 python /global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_code/py/obiwan/Drones/obiwan_analysis/preprocess/brickmask/really_mask.py $name_for_run $chunk
echo cut data files to the same footprint 
cd /global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_code/py/obiwan/Drones/obiwan_analysis/ang_corr
srun -N 1 -n 1 -c 64 python /global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_code/py/obiwan/Drones/obiwan_analysis/ang_corr/data_footprint_generator_no_fs.py $name_for_run $chunk
echo ALL Done
