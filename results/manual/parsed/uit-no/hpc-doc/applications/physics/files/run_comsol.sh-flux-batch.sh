#!/bin/bash
#FLUX: --job-name=comsol_runex
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=highmem
#FLUX: -t=3600
#FLUX: --urgency=16

inp=$1  # First input argument: Name of input without extention
std=$2  # Second input argument: Type of study
ext=mph # We use the same naming scheme as the software default extention
submitdir=${SLURM_SUBMIT_DIR}
workdir=/global/work/${USER}/${SLURM_JOBID}
mkdir -p ${workdir}
cp ${inp}.${ext} ${workdir}
module purge --quiet
module load COMSOL/5.3-intel-2016a
cd ${workdir}
time comsol -nn ${SLURM_NNODES}\
            -np ${SLURM_CPUS_PER_TASK}\
            -mpirsh /usr/bin/ssh\
            -mpiroot $I_MPI_ROOT\
            -mpi intel batch\
            -inputfile ${inp}.${ext}\
            -outputfile ${inp}_out.${ext}\
            -study ${std}\
            -mlroot /global/apps/matlab/R2014a
mv *out* $submitdir
cd $submitdir
rm -r ${workdir}
exit 0
