#!/bin/bash
#FLUX: --job-name=reclusive-chair-5462
#FLUX: --queue=test
#FLUX: --urgency=16

export I_MPI_DEBUG='5 '
export OMP_DISPLAY_AFFINITY='TRUE '
export MPI_DSM_VERBOSE='1 '
export MPI_SHARED_VERBOSE='1 '
export MPI_MEMMAP_VERBOSE='1 '
export OMP_NUM_THREADS='1'

echo "My Valgrind Script Running..."
source /opt/ohpc/pub/oneAPI/setvars.sh
echo "cat /proc/sys/kernel/perf_event_paranoid"
cat /proc/sys/kernel/perf_event_paranoid
export I_MPI_DEBUG=5 
export OMP_DISPLAY_AFFINITY=TRUE 
unset MPI_DSM_OFF 
export MPI_DSM_VERBOSE=1 
export MPI_SHARED_VERBOSE=1 
export MPI_MEMMAP_VERBOSE=1 
module load valgrind
export OMP_NUM_THREADS=1
mpirun -n 1 valgrind --tool=cachegrind --LL=41943040,20,64 ./speed_test_diracoperator -i ./speed_test_diracoperator.in -o out_sf_measure_2501_3501
echo "My Script Ended."
