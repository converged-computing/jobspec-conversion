#!/bin/bash
#FLUX: --job-name=collect
#FLUX: -N=5
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export KMP_AFFINITY='disabled'
export MPICH_GNI_FORK_MODE='FULLCOPY'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export XDG_CONFIG_HOME='/dev/shm'
export PYTHONPATH='/global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_code/py/obiwan/Drones/obiwan_run/mpi4py_run:$PYTHONPATH'
export name_for_run='dr8_SV'
export obiwan_out='$CSCRATCH/Obiwan/dr8/obiwan_out/$name_for_run/'

export KMP_AFFINITY=disabled
export MPICH_GNI_FORK_MODE=FULLCOPY
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export XDG_CONFIG_HOME=/dev/shm
load_desiconda
export PYTHONPATH=/global/cscratch1/sd/huikong/obiwan_Aug/repos_for_docker/obiwan_code/py/obiwan/Drones/obiwan_run/mpi4py_run:$PYTHONPATH
export name_for_run=dr8_SV
export obiwan_out=$CSCRATCH/Obiwan/dr8/obiwan_out/$name_for_run/
tot_counter=5 #this is consistent with # of Nodes(-N) requested
counter=0
name_for_random=$name_for_run
while [ $counter -lt $tot_counter ]
do
    echo HI
    srun -N 1 -n 8 -c 8 python SV_collect_mpi.py --name_for_run ${name_for_run} --split_idx $counter --N_split $tot_counter --n_obj 200 --start_id 0 --rs_type rs0 --name_for_randoms $name_for_random &
    let counter=counter+1 
done
wait
echo start stacking finished images, this might be a long time...
srun -N 1 -n 1 -c 64 python SV_stack.py $tot_counter $name_for_run 
rm $obiwan_out/subset/sim_${name_for_run}_part*
echo ALL Done
