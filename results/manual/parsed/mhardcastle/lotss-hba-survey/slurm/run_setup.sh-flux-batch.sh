#!/bin/bash
#FLUX: --job-name=tart-lemon-3709
#FLUX: -c=32
#FLUX: --queue=normal
#FLUX: -t=460800
#FLUX: --urgency=16

export INSTALL_DIR='/home/azimuth/software'
export VLBIDIR='${INSTALL_DIR}/VLBI-cwl'
export LINCDIR='${INSTALL_DIR}/LINC'
export FLOCSDIR='${INSTALL_DIR}/flocs'
export LOFARHELPERS='${INSTALL_DIR}/lofar_helpers'
export FACETSELFCAL='${INSTALL_DIR}/lofar_facet_selfcal'

OBSID=${1}
export INSTALL_DIR=/home/azimuth/software
export VLBIDIR=${INSTALL_DIR}/VLBI-cwl
export LINCDIR=${INSTALL_DIR}/LINC
export FLOCSDIR=${INSTALL_DIR}/flocs
export LOFARHELPERS=${INSTALL_DIR}/lofar_helpers
export FACETSELFCAL=${INSTALL_DIR}/lofar_facet_selfcal
BINDPATHS=${INSTALL_DIR},${LINC_DATA_DIR}
MYSINGULARITYDIR=/project/lofarvlbi/Software/singularity
SIMG=${MYSINGULARITYDIR}/lofar_sksp_v4.2.3_znver2_znver2_aocl4_debug.sif
DATADIR=${LINC_DATA_DIR}/${OBSID}
PROCDIR=${LINC_DATA_DIR}/processing
OUTDIR=${PROCDIR}/${OBSID}
TMPDIR=${PROCDIR}/${OBSID}/tmp/
LOGSDIR=${OUTDIR}/logs
mkdir -p ${TMPDIR}
mkdir -p ${LOGSDIR}
LINC_DATA_ROOT=${LINCDIR}
CONTAINERSTR=$(singularity --version)
if [[ "$CONTAINERSTR" == *"apptainer"* ]]; then
    export APPTAINERENV_LINC_DATA_ROOT=${LINC_DATA_ROOT}
    export APPTAINERENV_LOGSDIR=${LOGSDIR}
    export APPTAINERENV_TMPDIR=${TMPDIR}
    export APPTAINERENV_PREPEND_PATH=${LINC_DATA_ROOT}/scripts
    export APPTAINERENV_PREPEND_PATH=${VLBIDIR}/scripts
    export APPTAINERENV_PYTHONPATH="$VLBIDIR/scripts:$LINCDIR/scripts:\$PYTHONPATH"
else
    export SINGULARITYENV_LINC_DATA_ROOT=${LINC_DATA_ROOT}
    export SINGULARITYENV_LOGSDIR=${LOGSDIR}
    export SINGULARITYENV_TMPDIR=${TMPDIR}
    export SINGULARITYENV_PREPEND_PATH=${LINC_DATA_ROOT}/scripts
    export SINGULARITYENV_PREPEND_PATH=${VLBIDIR}/scripts
    export SINGULARITYENV_PYTHONPATH="$VLBIDIR/scripts:$LINCDIR/scripts:\$PYTHONPATH"
fi
cd ${OUTDIR}
singularity exec -B ${PWD},${BINDPATHS} ${SIMG} python3 ${FLOCSDIR}/runners/create_ms_list.py --vlbi --solset ${DATADIR}/cal_values/solutions.h5 --delay_calibrator ${DATADIR}/delay_calibrators.csv --configfile ${INSTALL_DIR}/lofar-vlbi/facetselfcal_config.txt --h5merger ${LOFARHELPERS} --linc ${LINCDIR} --selfcal ${FACETSELFCAL} ${DATADIR}/ >> test.log 2>&1
echo LINC starting
echo export PYTHONPATH=\$LINC_DATA_ROOT/scripts:\$PYTHONPATH > tmprunner_${OBSID}.sh
echo 'cwltool --parallel --preserve-entire-environment --no-container --tmpdir-prefix=${TMPDIR} --outdir=${OUTDIR} --log-dir=${LOGSDIR} ${VLBIDIR}/workflows/setup.cwl mslist.json' >> tmprunner_${OBSID}.sh
(time singularity exec -B ${PWD},${BINDPATHS} ${SIMG} bash tmprunner_${OBSID}.sh 2>&1) | tee ${OUTDIR}/job_output.txt
echo LINC ended
if grep 'Final process status is success' ${OUTDIR}/job_output.txt
then 
	echo 'SUCCESS: Pipeline finished successfully' > ${OUTDIR}/finished.txt
else
	echo "**FAILURE**: Pipeline failed with exit status: ${?}" > ${OUTDIR}/finished.txt
fi
