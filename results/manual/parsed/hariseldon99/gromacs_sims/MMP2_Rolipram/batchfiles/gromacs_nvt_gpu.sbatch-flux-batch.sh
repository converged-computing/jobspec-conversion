#!/bin/bash
#FLUX: --job-name=roli-nvt
#FLUX: -n=12
#FLUX: -c=2
#FLUX: --queue=GPU
#FLUX: -t=43200
#FLUX: --priority=16

export USE_OPENMP='true'
export NVT='nvt'
export OMP_NUM_THREADS='$SLURM_NTASKS'
export MPI_NUM_PROCS='$SLURM_CPUS_PER_TASK'
export GMX_IMGDIR='${SIFDIR}/gromacs/'
export GMX_IMG='gromacs-2022.3_20230206.sif'
export GMX_ENABLE_DIRECT_GPU_COMM='1'
export RUNTIME='$( echo "$end - $start" | bc -l )'

export USE_OPENMP=true
start=`date +%s.%N`
echo "Starting"
echo '---------------------------------------------'
num_proc=$((SLURM_NTASKS * SLURM_CPUS_PER_TASK))
echo 'num_proc='$num_proc
echo '---------------------------------------------'
export NVT=nvt
export OMP_NUM_THREADS=$SLURM_NTASKS
export MPI_NUM_PROCS=$SLURM_CPUS_PER_TASK
export GMX_IMGDIR=${SIFDIR}/gromacs/
export GMX_IMG=gromacs-2022.3_20230206.sif
export GMX_ENABLE_DIRECT_GPU_COMM=1
SINGULARITY="singularity run --nv -B ${PWD}:/host_pwd --pwd /host_pwd ${GMX_IMGDIR}/${GMX_IMG}"
${SINGULARITY} gmx mdrun -ntmpi $MPI_NUM_PROCS -ntomp $OMP_NUM_THREADS -nb gpu -bonded gpu -pin on -v -deffnm $NVT
end=`date +%s.%N`
echo "OMP_NUM_THREADS= "$OMP_NUM_THREADS", MPI_NUM_PROCS= "$MPI_NUM_PROCS
export RUNTIME=$( echo "$end - $start" | bc -l )
echo '---------------------------------------------'
echo "Runtime: "$RUNTIME" sec"
echo '---------------------------------------------'
