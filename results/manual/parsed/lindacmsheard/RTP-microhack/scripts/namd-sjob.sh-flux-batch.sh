#!/bin/bash
#FLUX: --job-name=namd
#FLUX: -n=120
#FLUX: --queue=hpc
#FLUX: --urgency=16

export SINGULARITYENV_PATH='${PATH}'
export SINGULARITYENV_LD_LIBRARY_PATH='${LD_LIBRARY_PATH}'

module load mpi/hpcx
WORKDIR=/shared/home/team06/namd/namd-benchmarks/1400k-atoms/
cd $WORKDIR
INPUT=benchmark.in
CHARMRUN="/sw/namd/charmrun +n ${SLURM_NTASKS} ++mpiexec ++remote-shell srun"
SINGULARITY="`which singularity` exec --bind /opt,/etc/libibverbs.d,/usr/bin/srun,/var/run/munge,/usr/lib64/libmunge.so.2,/usr/lib64/libmunge.so.2.0.0,/run/munge,/etc/slurm,/sched,/usr/lib64/slurm /shared/home/team06/namd/namd-2.14.sif"
NAMD2="/sw/namd/namd2"
export SINGULARITYENV_PATH=${PATH}
export SINGULARITYENV_LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
${SINGULARITY} ${CHARMRUN} ${SINGULARITY} ${NAMD2} ${INPUT}
