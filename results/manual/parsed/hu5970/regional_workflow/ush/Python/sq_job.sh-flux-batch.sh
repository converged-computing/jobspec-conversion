#!/bin/bash
#FLUX: --job-name=plot_allvars
#FLUX: -n=4
#FLUX: -t=1200
#FLUX: --urgency=16

export GLOBAL_VAR_DEFNS_FP='${EXPTDIR}/var_defns.sh'
export CDATE='${DATE_FIRST_CYCL}${CYCL_HRS}'
export FCST_START='6'
export FCST_END='${FCST_LEN_HRS}'
export FCST_INC='6'

cd ${HOMErrfs}/ush/Python
set -x
. /apps/lmod/lmod/init/sh
module purge
module load hpss
module use -a /contrib/miniconda3/modulefiles
module load miniconda3
conda activate pygraf
SHAPE_FILES=/scratch2/BMC/det/UFS_SRW_app/v1p0/fix_files/NaturalEarth
export GLOBAL_VAR_DEFNS_FP="${EXPTDIR}/var_defns.sh"
source ${GLOBAL_VAR_DEFNS_FP}
export CDATE=${DATE_FIRST_CYCL}${CYCL_HRS}
export FCST_START=6
export FCST_END=${FCST_LEN_HRS}
export FCST_INC=6
python plot_allvars.py ${CDATE} ${FCST_START} ${FCST_END} ${FCST_INC} \
                       ${EXPTDIR} ${SHAPE_FILES} ${POST_OUTPUT_DOMAIN_NAME}
