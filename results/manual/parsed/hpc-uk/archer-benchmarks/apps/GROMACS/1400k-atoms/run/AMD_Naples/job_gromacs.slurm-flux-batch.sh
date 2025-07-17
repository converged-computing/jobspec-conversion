#!/bin/bash
#FLUX: --job-name=gmx_1400atoms_1node_16tasks
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=EPYC-16c_edr-ib1_256gb_2666
#FLUX: -t=43200
#FLUX: --urgency=16

export PATH='/scratch_lustre_DDN7k/xguox/gromacs/install/bin:$PATH'
export LD_LIBRARY_PATH='/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0-single/lib:$LD_LIBRARY_PATH'
export OMP_NUM_THREADS='1'

export PATH=/scratch_lustre_DDN7k/xguox/python/install-gnu7.2.0/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/python/install-gnu7.2.0/lib:$LD_LIBRARY_PATH
export PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0/lib:$LD_LIBRARY_PATH
export PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0-single/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0-single/lib:$LD_LIBRARY_PATH
export PATH=/scratch_lustre_DDN7k/xguox/gromacs/install/bin:$PATH
echo "PATH="
echo $PATH
cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=1
nodes=$SLURM_JOB_NUM_NODES
casename="benchmark"
cpn=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
mdrun="/scratch_lustre_DDN7k/xguox/gromacs/install/bin/mdrun_mpi"
cores=$(( nodes * cpn ))
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${timestamp}"
srun -n ${cores} ${mdrun} -s ${casename}.tpr -g ${resfile} -noconfout
rm ener.edr
