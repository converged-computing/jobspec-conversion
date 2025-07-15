#!/bin/bash
#FLUX: --job-name=gmx_centering
#FLUX: --queue=CPU
#FLUX: -t=7200
#FLUX: --priority=16

export RUNTIME='$( echo "$end - $start" | bc -l )'

start=`date +%s.%N`
echo "Starting"
echo '---------------------------------------------'
num_proc=${SLURM_NTASKS}
echo 'num_proc='$num_proc
echo '---------------------------------------------'
LD_LIBRARY_PATH="" printf "4 0"|singularity run --nv -B ${PWD}:/host_pwd --pwd /host_pwd ~/SIFDIR/gromacs/gromacs-2022.3_20230206.sif gmx trjconv -s md_0_10.tpr -f md_0_10.xtc -o md_0_10_center.xtc -center -pbc mol -ur compact
end=`date +%s.%N`
echo "OMP_NUM_THREADS= "$OMP_NUM_THREADS", MPI_NUM_PROCS= "$MPI_NUM_PROCS
export RUNTIME=$( echo "$end - $start" | bc -l )
echo '---------------------------------------------'
echo "Runtime: "$RUNTIME" sec"
echo '---------------------------------------------'
