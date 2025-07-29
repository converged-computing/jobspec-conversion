#!/bin/bash
#SBATCH --job-name=amg2013_meric
#SBATCH --account=p_readex
#SBATCH --output=amg2013_meric.out
#SBATCH --error=amg2013_meric.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=2200M
#SBATCH --time=1-00:00:00
#SBATCH --partition=broadwell
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2

export MERIC_MODE='1'
export MERIC_DEBUG='0'
export MERIC_CONTINUAL='1'
export MERIC_AGGREGATE='1'
export MERIC_DETAILED='0'
export MERIC_NUM_THREADS='14'
export MERIC_FREQUENCY='24'
export MERIC_UNCORE_FREQUENCY='27'
export MERIC_OUTPUT_DIR='amg2013_meric_dir'

cd ..
module purge
source ./readex_env/set_env_meric.source
export MERIC_MODE=1
export MERIC_DEBUG=0
export MERIC_CONTINUAL=1
export MERIC_AGGREGATE=1
export MERIC_DETAILED=0
export MERIC_NUM_THREADS=14
export MERIC_FREQUENCY=24
export MERIC_UNCORE_FREQUENCY=27
export MERIC_OUTPUT_DIR="amg2013_meric_dir"
srun --cpu_bind=verbose,sockets --nodes 4 --ntasks-per-node 2 --cpus-per-task 14 ./test/amg2013_meric -P 2 2 2 -r 40 40 40
rm -rf $MERIC_OUTPUT_DIR
rm -rf ${MERIC_OUTPUT_DIR}Counters
echo $MERIC_OUTPUT_DIR
for thread in {14..6..-4}
do
  for cpu_freq in {24..12..-4}
  do
    for uncore_freq in {27..15..-4}
    do
      export MERIC_OUTPUT_FILENAME=$thread"_"$cpu_freq"_"$uncore_freq
      export MERIC_NUM_THREADS=$thread
      export MERIC_FREQUENCY=$cpu_freq
      export MERIC_UNCORE_FREQUENCY=$uncore_freq
      echo
      echo TEST $MERIC_OUTPUT_FILENAME
      for repeat in {1..1..1}
      do
        ret=1
        while [ "$ret" -ne 0 ]
        do
          srun --cpu_bind=verbose,sockets --nodes 4 --ntasks-per-node 2 --cpus-per-task 14 ./test/amg2013_meric -P 2 2 2 -r 40 40 40
          ret=$?
        done
      done 
    done
  done
done
