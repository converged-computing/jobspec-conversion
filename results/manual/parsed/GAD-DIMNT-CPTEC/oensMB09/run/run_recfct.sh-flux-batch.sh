#!/bin/bash
#FLUX: --job-name=RECFCT
#FLUX: --queue=${AUX_QUEUE}
#FLUX: --urgency=16

export FILEENV='$(find ${PWD} -name EnvironmentalVariablesMCGA -print)'
export MODELDATAOUT='cd ${DK_suite}/model/dataout/${TRCLV}/${LABELI}/\${MEM}${PREFIC}/'
export ENSTYPE='export TYPES=FCT\${MEM}${PREFIC}'
export PBSDIRECTIVE='#SBATCH --array=1-${NMEM}'
export DEFINEMEM='export MEM=\$(printf %02g \${SLURM_ARRAY_TASK_ID})'
export PBS_SERVER='${pbs_server2}'
export TRCLV='${TRCLV}'
export DATE='\$(date +'%Y')\$(date +'%m')\$(date +'%d')'
export HOUR='\$(date +'%H:%M')'
export LABELI='${LABELI}'
export NAMEL='G\${TYPES}'
export NAMES='G\${TYPES}'
export NAMER='G\${TYPES}'
export EXTL='F.fct'
export ERS1='F.fct'
export ERR1='R.fct'
export job_recfct_id='$(echo ${job_recfct} | awk -F " " '{print $4}')'

if [ "${1}" = "help" -o -z "${1}" ]
then
cat < ${0} | sed -n '/^#BOP/,/^#EOP/p'
exit 0
fi
. ${FILEENV} ${1} ${2}
cd ${HOME_suite}/run
if [ -z "${1}" ]
then
echo "TRCLV está faltando"
exit 1
else
TRCLV=${1}
fi
if [ -z "${2}" ]
then
echo "PREFIC esta faltando"
exit 1
else
if ! [[ "${2}" =~ ^[0-9]+$ ]]
then
PREFIC=${2}
TYPES=FCT${PREFIC}
else
PREFIC=R
NMEM=${2}
TYPES=FCT${PREFIC}PT
fi
fi
if [ -z "${3}" ]
then
echo "LABELI esta faltando"
exit 1
else
LABELI=${3}
fi
TRC=$(echo ${TRCLV} | cut -c 1-6 | tr -d "TQ0")
LV=$(echo ${TRCLV} | cut -c 7-11 | tr -d "L0")
HSTMAQ=$(hostname)
RUNTM=$(date +'%y')$(date +'%m')$(date +'%d')$(date +'%H:%M')
EXT=out
mkdir -p ${DK_suite}/recfct/output
if [ ${PREFIC} == NMC -o ${PREFIC} == CTR ]
then
else
if [ $(echo "$QSUB" | grep qsub) ]
then
else
fi
fi
RUNTM=$(date +"%s")
SCRIPTSFILE=setrecfct${TYPES}.${TRCLV}.${LABELI}${LABELF}.${MAQUI}
if [ $(echo "$QSUB" | grep qsub) ]
then
SCRIPTHEADER="
${PBSDIRECTIVE}
"
SCRIPTRUNCMD="aprun -n 1 -N 1 -d 1 ${DK_suite}/recfct/bin/\${TRCLV}/recfct.\${TRCLV} < ${DK_suite}/recfct/datain/recfct\${TYPES}.nml > ${DK_suite}/recfct/output/recfct\${TYPES}.out.\${LABELI}\${LABELF}.\${HOUR}.\${TRCLV}"
SCRIPTRUNJOB="qsub -W block=true "
else
SCRIPTHEADER="
${PBSDIRECTIVE}
"
if [ $USE_SINGULARITY == true ]
then
SCRIPTRUNCMD="module load singularity ; singularity exec -e --bind ${WORKBIND}:${WORKBIND} ${SIFIMAGE} mpirun -np 1 ${SIFOENSMB09BIN}/recfct/bin/\${TRCLV}/recfct.\${TRCLV} < ${DK_suite}/recfct/datain/recfct\${TYPES}.nml > ${DK_suite}/recfct/output/recfct\${TYPES}.out.\${LABELI}\${LABELF}.\${HOUR}.\${TRCLV}"
else
SCRIPTRUNCMD="mpirun -np 1 ${DK_suite}/recfct/bin/\${TRCLV}/recfct.\${TRCLV} < ${DK_suite}/recfct/datain/recfct\${TYPES}.nml > ${DK_suite}/recfct/output/recfct\${TYPES}.out.\${LABELI}\${LABELF}.\${HOUR}.\${TRCLV}"
fi
if [ ! -z ${job_model_id} ]
then
SCRIPTRUNJOB="sbatch --dependency=afterok:${job_model_id}"
else
SCRIPTRUNJOB="sbatch "
fi
fi
monitor=${DK_suite}/recfct/output/monitor_${PREFIC}.t
if [ -e ${monitor} ]; then rm ${monitor}; fi
cat <<EOT0 > ${HOME_suite}/run/${SCRIPTSFILE}
${SCRIPTHEADER}
${DEFINEMEM}
${MODELDATAOUT}
${ENSTYPE}
mkdir -p ${DK_suite}/recfct/datain/
for LABELF in \$(ls G\${TYPES}${LABELI}* | cut -c 18-27)
do
echo "Date: "\$DATE
echo "Hour: "\$HOUR
if [ \${TYPES} = ANLAVN ]
then
else
fi
GNAMEL=\${NAMEL}\${LABELI}\${LABELF}\${EXTL}.\${TRCLV}
echo \${GNAMEL}
echo ${DK_suite}/recfct/datain/\${GNAMEL}
cat <<EOT2 > ${DK_suite}/recfct/datain/\${GNAMEL}
\${NAMES}\${LABELI}\${LABELF}\${ERS1}.\${TRCLV}
\${NAMER}\${LABELI}\${LABELF}\${ERR1}.\${TRCLV}
EOT2
cat <<EOT3 > ${DK_suite}/recfct/datain/recfct\${TYPES}.nml
&DATAIN
LDIM=1
DIRL='${DK_suite}/recfct/datain/ '
DIRS='${DK_suite}/model/dataout/\${TRCLV}/\${LABELI}/\${TYPES:3}/  '
DIRR='${DK_suite}/recfct/dataout/\${TRCLV}/\${LABELI}/ '
GNAMEL='\${GNAMEL} '
&END
EOT3
mkdir -p ${DK_suite}/recfct/dataout/\${TRCLV}/\${LABELI}/
cd ${HOME_suite}/recfct/bin/\${TRCLV}
${SCRIPTRUNCMD}
done
touch ${monitor}
EOT0
chmod +x ${HOME_suite}/run/${SCRIPTSFILE}
job_recfct=$(${SCRIPTRUNJOB} ${HOME_suite}/run/${SCRIPTSFILE})
echo "recfct ${job_recfct_id}"
until [ -e ${monitor} ]; do sleep 1s; done
