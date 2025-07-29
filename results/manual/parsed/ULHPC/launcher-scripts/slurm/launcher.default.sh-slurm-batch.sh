#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=28

echo "SLURM_JOBID  = ${SLURM_JOBID}"
echo "SLURM_JOB_NODELIST = ${SLURM_JOB_NODELIST}"
echo "SLURM_NNODES = ${SLURM_NNODES}"
echo "SLURM_NTASKS = ${SLURM_NTASKS}"
echo "SLURMTMPDIR  = ${SLURMTMPDIR}"
echo "Submission directory = ${SLURM_SUBMIT_DIR}"
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -n "${SLURM_SUBMIT_DIR}" ]; then
    [[ "${SCRIPTDIR}" == *"slurmd"* ]] && RUNDIR=${SLURM_SUBMIT_DIR} || RUNDIR=${SCRIPTDIR}
else
    RUNDIR=${SCRIPTDIR}
fi
print_error_and_exit() { echo "***ERROR*** $*"; exit 1; }
if [ -f  /etc/profile ]; then
   .  /etc/profile
fi
module purge
module load toolchain/intel
APPDIR="$HOME"
TASK="${APPDIR}/app.exe"
CMD="${TASK}"
LOGFILE="${RUNDIR}/$(date +%Y-%m-%d)_$(basename ${TASK})_${SLURM_JOBID}.log"
cat > ${LOGFILE} <<EOF
EOF
${CMD} |& tee -a ${LOGFILE}
cat >> ${LOGFILE} <<EOF
EOF
