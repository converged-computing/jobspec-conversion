#!/bin/bash
#FLUX: --job-name=frigid-kerfuffle-9886
#FLUX: --urgency=16

: ${PROJ_ID:="bbhx-delta-cpu"}
: ${QUEUE:="cpu"}
if [ $# -ne 3 ]; then
  echo "usage: [PROJ_ID] [QUEUE] $0 <casename> <number of compute nodes> <hh:mm:ss>"
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
bin=./nek5000
case=$1
nodes=$2
cpu_per_node=128
let nn=$nodes*$cpu_per_node
let ntasks=nn
time=$3
if [ ! -f $bin ]; then
  echo "Cannot find" $bin
  exit 1
fi
if [ ! -f ./nek5000 ]; then
  echo "Cannot find ./nek5000"
  exit 1
fi
echo $case     >  SESSION.NAME
echo `pwd`'/' >>  SESSION.NAME
SFILE=s.bin
echo "#!/bin/bash" > $SFILE
echo "#SBATCH --account=$PROJ_ID" >>$SFILE
echo "#SBATCH --job-name=nek5000_$case" >>$SFILE
echo "#SBATCH -o %x-%j.out" >>$SFILE
echo "#SBATCH --time=$time" >>$SFILE
echo "#SBATCH --nodes=$nodes" >>$SFILE
echo "#SBATCH --partition=$QUEUE" >>$SFILE
echo "#SBATCH --exclusive" >>$SFILE
echo "#SBATCH --mem=0" >>$SFILE
echo "#SBATCH --ntasks-per-node=$cpu_per_node" >>$SFILE
echo "#SBATCH --cpus-per-task=1" >>$SFILE
echo "export OMP_NUM_THREADS=1" >>$SFILE
echo "ulimit -s unlimited " >>$SFILE
echo "module list" >>$SFILE
echo "nvidia-smi" >>$SFILE
echo "nvcc --version" >>$SFILE
echo "cmake --version" >>$SFILE
echo "date" >>$SFILE
echo "srun $bin " >>$SFILE
sbatch $SFILE
