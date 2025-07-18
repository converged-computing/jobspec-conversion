#!/bin/bash
#FLUX: --job-name=fat-hippo-7728
#FLUX: --urgency=16

export ROMIO_HINTS='$(pwd)/.romio_hint'

: ${PROJ_ID:="dems"}
: ${QUEUE:=""}
: ${NEKRS_HOME:="$HOME/.local/nekrs"}
: ${NEKRS_CACHE_BCAST:=0}
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
let cores_per_numa=24/4
let cores_per_task=2*$cores_per_numa
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
export ROMIO_HINTS="$(pwd)/.romio_hint"
if [ ! -f "$ROMIO_HINTS" ]; then
  echo "romio_no_indep_rw true"   >$ROMIO_HINTS
  echo "romio_cb_write enable"   >>$ROMIO_HINTS
  echo "romio_ds_write enable"   >>$ROMIO_HINTS
  echo "romio_cb_read enable"    >>$ROMIO_HINTS
  echo "romio_ds_read enable"    >>$ROMIO_HINTS
  echo "IBM_largeblock_io true"  >>$ROMIO_HINTS
  echo "cb_buffer_size 16777216" >>$ROMIO_HINTS
  echo "cb_config_list *:1"      >>$ROMIO_HINTS
fi
SFILE=s.bin
echo "#!/bin/bash" > $SFILE
echo "#SBATCH -A $PROJ_ID" >>$SFILE
echo "#SBATCH -J nekRS_$case" >>$SFILE
echo "#SBATCH -o %x-%j.out" >>$SFILE
echo "#SBATCH -t $time" >>$SFILE
echo "#SBATCH -N $nodes" >>$SFILE
echo "#SBATCH --exclusive" >>$SFILE
echo "#SBATCH --partition=$QUEUE" >>$SFILE
echo "#SBATCH --ntasks-per-node=$gpu_per_node" >>$SFILE
echo "#SBATCH --cpus-per-task=$cores_per_task" >>$SFILE
echo "#SBATCH --gres=gpu:$gpu_per_node" >> $SFILE
echo "#SBATCH --gpu-bind=closest" >>$SFILE
echo "#SBATCH --distribution=block:cyclic:fcyclic" >> $SFILE
echo "module load CMake GCC CUDA OpenMPI" >>$SFILE
echo "module list" >>$SFILE
echo "nvidia-smi" >>$SFILE
echo "ucx_info -f" >>$SFILE
echo "ulimit -s unlimited " >>$SFILE
echo "export NEKRS_HOME=$NEKRS_HOME" >>$SFILE
echo "export NEKRS_GPU_MPI=1 " >>$SFILE
echo "export ROMIO_HINTS=$ROMIO_HINTS" >>$SFILE
echo "export NEKRS_CACHE_BCAST=$NEKRS_CACHE_BCAST" >> $SFILE
echo "if [ \$NEKRS_CACHE_BCAST -eq 1 ]; then" >> $SFILE
echo "  export NEKRS_LOCAL_TMP_DIR=\$TMPDIR/nrs" >> $SFILE
echo "  mkdir \$NEKRS_LOCAL_TMP_DIR" >> $SFILE
echo "fi" >> $SFILE
if [ $NEKRS_SKIP_BUILD_ONLY -eq 0 ]; then
echo "# precompilation" >>$SFILE
echo "srun -n 1 $bin --backend $backend --device-id 0 --setup $case --build-only $ntasks" >>$SFILE
fi
echo "" >> $SFILE
echo "date" >>$SFILE
echo "srun --cpu-bind=cores $bin --backend $backend --device-id 0 --setup $case" >>$SFILE
sbatch $SFILE
rm -rf $ROMIO_HINTS
