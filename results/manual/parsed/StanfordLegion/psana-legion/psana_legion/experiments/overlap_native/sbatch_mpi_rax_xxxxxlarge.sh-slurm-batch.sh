#!/bin/bash
#FLUX: --job-name=psana_legion
#FLUX: -N=513
#FLUX: --exclusive
#FLUX: -t=10800
#FLUX: --urgency=16

export SIT_PSDM_DATA='$HOST_DATA_DIR/d/psdm'
export EAGER='1'
export KERNEL_KIND='memory_bound_native'

HOST_PSANA_DIR=$HOME/psana_legion/psana-legion
HOST_DATA_DIR=$SCRATCH/noepics_c24_s1_data/reg
export SIT_PSDM_DATA=$HOST_DATA_DIR/d/psdm
echo "HOST_DATA_DIR=$HOST_DATA_DIR"
export EAGER=1
export KERNEL_KIND=memory_bound_native
for rounds in 20 40 80 160; do
  export KERNEL_ROUNDS=$rounds
  for n in 512; do
    export LIMIT=$(( n * 2048 ))
    for c in 256 128 64 32 16; do
      ./make_nodelist.py $c > nodelist.txt
      export SLURM_HOSTFILE=$PWD/nodelist.txt
      if [[ ! -e rax_rounds"$rounds"_n"$n"_c"$c".log ]]; then
        srun -n $(( n * c + 1 )) -N $(( n + 1 )) --cpus-per-task $(( 256 / c )) --cpu_bind threads --distribution=arbitrary --output rax_rounds"$rounds"_n"$n"_c"$c".log \
          shifter \
            $HOST_PSANA_DIR/psana_legion/scripts/psana_mpi.sh $HOST_PSANA_DIR/psana_legion/mpi_rax.py
      fi
    done
  done
done
