#!/bin/bash
#FLUX: --job-name=crusty-nunchucks-9581
#FLUX: -c=10
#FLUX: --queue=_R_PARTITION_
#FLUX: --priority=16

export TEMPWORKDIR='${SCRATCH}/JOB-${SLURM_JOBID}'

DeepMD_MODEL_VERSION="_R_DEEPMD_VERSION_"
DeepMD_MODEL_FILES=("_R_MODEL_FILES_")
LAMMPS_IN_FILE="_R_LAMMPS_IN_FILE_"
LAMMPS_LOG_FILE="_R_LAMMPS_LOG_FILE_"
LAMMPS_OUT_FILE="_R_LAMMPS_OUT_FILE_"
EXTRA_FILES=("_R_DATA_FILE_" "_R_PLUMED_FILES_" "_R_RERUN_FILE_")
cd "${SLURM_SUBMIT_DIR}" || { echo "Could not go to ${SLURM_SUBMIT_DIR}. Aborting..."; exit 1; }
[ -f "${LAMMPS_IN_FILE}" ] || { echo "${LAMMPS_IN_FILE} does not exist. Aborting..."; exit 1; }
if [ "${DeepMD_MODEL_VERSION}" == "2.2" ]; then
    # Load the DeepMD module
    module load DeepMD-kit
elif [ "${DeepMD_MODEL_VERSION}" == "2.1" ]; then
    # Load the DeepMD module
    module load "DeepMD-kit/${DeepMD_MODEL_VERSION}"
else
    echo "DeepMD version ${DeepMD_MODEL_VERSION} is not available. Aborting..."
    exit 1
fi
export TEMPWORKDIR=${SCRATCH}/JOB-${SLURM_JOBID}
mkdir -p "${TEMPWORKDIR}"
ln -s "${TEMPWORKDIR}" "${SLURM_SUBMIT_DIR}/JOB-${SLURM_JOBID}"
cp "${LAMMPS_IN_FILE}" "${TEMPWORKDIR}" && echo "${LAMMPS_IN_FILE} copied successfully"
for f in "${DeepMD_MODEL_FILES[@]}"; do [ -f "${f}" ] && ln -s "$(realpath "${f}")" "${TEMPWORKDIR}" && echo "${f} linked successfully"; done
for f in "${EXTRA_FILES[@]}"; do [ -f "${f}" ] && cp "${f}" "${TEMPWORKDIR}" && echo "${f} copied successfully"; done
cd "${TEMPWORKDIR}" || { echo "Could not go to ${TEMPWORKDIR}. Aborting..."; exit 1; }
echo "# [$(date)] Running LAMMPS..."
lmp -in "${LAMMPS_IN_FILE}" -log "${LAMMPS_LOG_FILE}" -screen none > "${LAMMPS_OUT_FILE}" 2>&1
echo "# [$(date)] LAMMPS finished."
if [ -f log.cite ]; then rm log.cite ; fi
find ./ -type l -delete
mv ./* "${SLURM_SUBMIT_DIR}"
cd "${SLURM_SUBMIT_DIR}" || { echo "Could not go to ${SLURM_SUBMIT_DIR}. Aborting..."; exit 1; }
rmdir "${TEMPWORKDIR}" 2> /dev/null || echo "Leftover files on ${TEMPWORKDIR}"
[ ! -d "${TEMPWORKDIR}" ] && { [ -h JOB-"${SLURM_JOBID}" ] && rm JOB-"${SLURM_JOBID}"; }
sleep 2
exit
