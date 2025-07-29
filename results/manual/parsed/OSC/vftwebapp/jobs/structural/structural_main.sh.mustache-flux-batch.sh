#!/bin/bash
#FLUX: --job-name=structural
#FLUX: --urgency=16

WORKSPACE="${SLURM_SUBMIT_DIR}"
STAGEDDIR="${SLURM_SUBMIT_DIR}"
LOGDIR="{{{log_root}}}"
ERRORFILE="{{{structural_error_file}}}"
PATTERN="*.wrp"
echo "---Job started at:"
date
echo ""
clean_up ()
{
paraview
echo "Cleaning up temporary workspace (${WORKSPACE})..."
time rsync -avu "${WORKSPACE}/" "${STAGEDDIR}"
echo "Done cleaning up"
}
die ()
{
echo "ERROR: $1" 1>&2
echo "$1" >> ${ERRORFILE}
clean_up
exit 1
}
check_status ()
{
if [[ $1 -ne 0 ]]; then
die "Failed on '$2'"
fi
}
init ()
{
echo "Creating temporary workspace (${WORKSPACE})..."
time rsync -av "${STAGEDDIR}/" "${WORKSPACE}"
echo "Done creating temporary workspace"
cd "${WORKSPACE}"
}
paraview ()
{
[[ -n ${RAN_PARAVIEW} ]] && return
RAN_PARAVIEW="true"
FLATFILE="{{{warp3d_flat_file_name}}}"
if [[ ! -f "${FLATFILE}" ]]; then
die "Unable to find the flat file (${FLATFILE})"
fi
echo "Generating Paraview input files"
echo "" >> "${LOGFILE}"
time cat <<EOF | warp3d2exii &>> "${LOGFILE}"
wrp
1
${FLATFILE}
.
n
y
EOF
check_status $? warp3d2exii
}
rotate () {
[[ -e "$1" ]]
local suffix=0
while [[ -e "$1.$((++suffix))" ]]; do true; done
mv -v "$1" "$1.${suffix}"
}
module load python/2.7
module use /users/PZS0645/wiag/local-owens/emc2/share/modulefiles
module load intel/19.0.5 intelmpi/2019.7
module load warp3d
source $WARP3D_VENV/bin/activate
trap "die 'Unexpected termination'" TERM
init
LOGFILE="${LOGDIR}/warp3d.log"
rotate "${LOGFILE}"
> "${LOGFILE}"
echo "Running WARP3D"
time timeout $((SLURM_TIME_LIMIT-600)) warp3d.omp < "{{#restart_file}}restart_wrp{{/restart_file}}{{^restart_file}}{{{warp3d_input_file_name}}}{{/restart_file}}" &>> "${LOGFILE}"
check_status $? warp3d.omp
ECOUNT=$(awk -F: 'BEGIN{e=0;} /Errors:/{e+=$2;} END{print e;}' "${LOGFILE}")
if [[ ${ECOUNT} -ne 0 ]]; then
die "Errors were detected in the WARP3D calculation"
fi
if grep -aq "FATAL ERROR:" "${LOGFILE}"; then
die "A fatal error was detected in the WARP3D calculation"
fi
clean_up
echo ""
echo "---Job finished at:"
date
exit 0
