#!/bin/bash
#FLUX: --job-name=hello-cattywampus-9400
#FLUX: --urgency=16

: ${PROJ_ID:=""}
: ${QUEUE:=""}
: ${NEKRS_HOME:="$HOME/.local/nekrs"}
: ${NEKRS_CACHE_BCAST:=1}
: ${NEKRS_SKIP_BUILD_ONLY:=0}
if [ $# -ne 3 ]; then
  echo "usage: [PROJ_ID=value] [QUEUE=value] $0 <casename> <number of compute nodes> <hh:mm:ss>"
  exit 0
fi
if [ -z "$PROJ_ID" ]; then
  echo "ERROR: PROJ_ID is empty"
  exit 1
fi
if [ -z "$QUEUE" ]; then
  echo "ERROR: QUEUE is empty"
  exit 1
fi
bin=${NEKRS_HOME}/bin/nekrs
case=$1
nodes=$2
gpu_per_node=4
cores_per_socket=16
let nn=$nodes*$gpu_per_node
let ntasks=nn
time=$3
backend=CUDA
if [ ! -f $bin ]; then
  echo "Cannot find" $bin
  exit 1
fi
if [ ! -f $case.par ]; then
  echo "Cannot find" $case.par
  exit 1
fi
if [ ! -f $case.udf ]; then
  echo "Cannot find" $case.udf
  exit 1
fi
if [ ! -f $case.re2 ]; then
  echo "Cannot find" $case.re2
  exit 1
fi
striping_unit=16777216
max_striping_factor=128
let striping_factor=$nodes/2
if [ $striping_factor -gt $max_striping_factor ]; then
  striping_factor=$max_striping_factor
fi
if [ $striping_factor -lt 1 ]; then
  striping_factor=1
fi
MPICH_MPIIO_HINTS="*:striping_unit=${striping_unit}:striping_factor=${striping_factor}:romio_cb_write=enable:romio_ds_write=disable:romio_no_indep_rw=true"
SFILE=s.bin
echo "#!/bin/bash" > $SFILE
echo "#SBATCH -A $PROJ_ID" >>$SFILE
echo "#SBATCH -J nekRS_$case" >>$SFILE
echo "#SBATCH -o %x-%j.out" >>$SFILE
echo "#SBATCH -t $time" >>$SFILE
echo "#SBATCH -N $nodes" >>$SFILE
echo "#SBATCH -q $QUEUE" >>$SFILE
echo "#SBATCH -C gpu" >>$SFILE
echo "#SBATCH --exclusive" >>$SFILE
echo "#SBATCH --ntasks-per-node=$gpu_per_node" >>$SFILE
echo "#SBATCH --cpus-per-task=$cores_per_socket" >>$SFILE
echo "#SBATCH --gpu-bind=none" >> $SFILE
echo "#SBATCH --gpus-per-node=4" >> $SFILE
echo "module load PrgEnv-gnu" >>$SFILE
echo "module load cudatoolkit" >>$SFILE
echo "module load cpe-cuda" >>$SFILE
echo "module load cmake" >>$SFILE
echo "module unload cray-libsci" >>$SFILE
echo "module list" >>$SFILE
echo "nvidia-smi" >>$SFILE
echo "export SLURM_CPU_BIND=\"cores\"" >> $SFILE
echo "export CRAY_ACCEL_TARGET=nvidia80" >>$SFILE
echo "export MPICH_GPU_SUPPORT_ENABLED=1" >>$SFILE
echo "export MPICH_OFI_NIC_POLICY=NUMA" >>$SFILE
echo "ulimit -s unlimited " >>$SFILE
echo "export NEKRS_HOME=$NEKRS_HOME" >>$SFILE
echo "export NEKRS_GPU_MPI=1 " >>$SFILE
echo "export MPICH_MPIIO_HINTS=$MPICH_MPIIO_HINTS" >>$SFILE
echo "export MPICH_MPIIO_STATS=1" >>$SFILE
echo "export FI_CXI_RX_MATCH_MODE=hybrid" >> $SFILE  
echo "if [ \$NEKRS_CACHE_BCAST -eq 1 ]; then" >> $SFILE
echo "  export NEKRS_LOCAL_TMP_DIR=\$TMPDIR/nrs" >> $SFILE
echo "  mkdir \$NEKRS_LOCAL_TMP_DIR" >> $SFILE
echo "fi" >> $SFILE
if [ $NEKRS_SKIP_BUILD_ONLY -eq 0 ]; then
echo "# precompilation" >>$SFILE
echo "srun -n 1 $bin --backend $backend --device-id 0 --setup $case --build-only $ntasks" >>$SFILE
echo "if [ \$? -ne 0 ]; then" >> $SFILE
echo "  exit" >> $SFILE
echo "fi" >> $SFILE
fi
echo "" >> $SFILE
echo "date" >>$SFILE
echo "srun $bin --backend $backend --setup $case" >>$SFILE
sbatch $SFILE
rm -rf $SFILE $ROMIO_HINTS
