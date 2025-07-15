#!/bin/bash
#FLUX: --job-name=$( whoami )-$1
#FLUX: -c=6
#FLUX: --queue=eagle
#FLUX: -t=28800
#FLUX: --priority=16

export OMP_NUM_THREADS='6'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

if [ $# -lt 1 ]; then
	echo "Please provide a path to the executable you want to run"
	exit 1
fi
if [ -x "$1" ]; then
	echo "Program: $@"
else
	echo "The file provided is not an executable. Please provide an executable"
	exit 1
fi
if [ $( hostname ) != "kudu" ]; then
	echo "This is not being ran on kudu. Please run the following to connect to kudu from any DCS machine."
	echo "    ssh kudu"
	exit 1
fi
echo "#!/bin/sh
echo "===== ENVIRONMENT ====="
. /etc/profile.d/modules.sh
echo "===== CUDA INFO ====="
echo "CUDA 12.3"
echo "===== COMPILER INFO ====="
echo "GCC 12.2.0"
echo "===== CPU INFO ====="
lscpu
echo "===== GPU INFO ====="
lshw -C display
echo "===== GPU INFO NVIDIA-SMI ====="
nvidia-smi
echo "===== RUNNING ON $( hostname ) ====="
echo
" > tmp
if [ -f "Makefile" ]; then
	echo "echo ===== COMPILING Makefile IN $( pwd ) =====
make clean
make -j KOKKOS_DEVICES=Cuda,OpenMP
export OMP_NUM_THREADS=6
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
echo
" >> tmp
fi
echo "echo ===== RUNNING $@ =====
srun ncu -o profile $@" >> tmp
BATCH=$( sbatch tmp )
BATCHNO=$( echo $BATCH | sed 's/[^0-9]//g' )
rm tmp
mkdir $BATCHNO
echo "===== Job $BATCHNO has been submitted! ====="
echo "===== My jobs ====="
echo "Note: Don't worry if the job is PENDING, the job will be ran as soon as possible."
squeue -u $( whoami ) -o "%.8i %.20j %.10T %.5M %.20R %.20e"
