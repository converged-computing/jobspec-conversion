#!/bin/bash
#SBATCH --job-name=psana_legion_bb
#SBATCH --account=lcls
#SBATCH --nodes=17
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH: --exclusive
#SBATCH --constraint=haswell

export SIT_PSDM_DATA='$HOST_DATA_DIR/d/psdm'
export EAGER='1'

singularity
exec
docker:stanfordlegion/psana-mpi:latest
HOST_PSANA_DIR=$HOME/psana_legion/psana-legion
HOST_DATA_DIR=$DW_PERSISTENT_STRIPED_slaughte_data_noepics/reg
export SIT_PSDM_DATA=$HOST_DATA_DIR/d/psdm
echo "HOST_DATA_DIR=$HOST_DATA_DIR"
export EAGER=1
for n in 1 2 4 8 16; do
  for c in 64; do
    ./make_nodelist.py $c > nodelist.txt
    export SLURM_HOSTFILE=$PWD/nodelist.txt
    if [[ ! -e rax_n"$n"_c"$c".log ]]; then
      srun -n $(( n * c + 1 )) -N $(( n + 1 )) --cpus-per-task $(( 64 / c )) --cpu_bind threads --distribution=arbitrary --output rax_n"$n"_c"$c".log \
        shifter \
          python $HOST_PSANA_DIR/psana_legion/mpi_rax.py
    fi
  done
done
