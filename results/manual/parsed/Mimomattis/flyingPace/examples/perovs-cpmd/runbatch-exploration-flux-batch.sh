#!/bin/bash
#FLUX: --job-name=runbatch-exploration
#FLUX: --queue=batch3
#FLUX: -t=86340
#FLUX: --priority=16

  input="INP-lammps"
  output="OUT"
  workdir="/dev/shm/${SLURM_JOB_ID}"
  unset SLURM_EXPORT_ENV
  export ppn=${SLURM_NTASKS_PER_NODE}
  echo `scontrol show hostnames ${SLURM_JOB_NODELIST}`
  echo ${SLURM_JOB_PARTITION}
  echo "Number of OpenMP threads:     " ${SLURM_CPUS_PER_TASK}
  echo "Number of MPI procs per node: " ${SLURM_NTASKS_PER_NODE}
  echo "Number of MPI processes:      " ${SLURM_NTASKS}
module purge
module load openmpi/intel/4.1.2-2021.4.0.3422-hpcx2.10
module load ucx/2.10
module load hcoll/2.10
module load compiler-rt/latest
module load tbb/latest
  export LAMMPS="/path/to/lmp/"
  echo ${LAMMPS}
  export PAR_RUN="srun"
  which ${PAR_RUN}
  export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
  export OMPI_MCA_hwloc_base_report_bindings=true
  if [ ${workdir} != "." ]; then
    mkdir -p ${workdir}
    cp -a * ${workdir}
    cd ${workdir}
    rm *.o${SLURM_JOB_ID} *.e${SLURM_JOB_ID}
  fi
  echo -n "Starting run at: "
  date
  $PAR_RUN $LAMMPS -var submitdir "${SLURM_SUBMIT_DIR}" -in ${input} > ${output}
  touch CALC_DONE
  echo -n "Stopping run at: "
  date
  echo
  if [ ${workdir} != "." ]; then
    cp -a * ${SLURM_SUBMIT_DIR}
    cd ${SLURM_SUBMIT_DIR}
    rm -rf ${workdir}
  fi
