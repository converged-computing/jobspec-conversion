#!/bin/bash
#FLUX: --job-name=DECEOF
#FLUX: --queue=${AUX_QUEUE}
#FLUX: --urgency=16

export FILEENV='$(find ${PWD} -name EnvironmentalVariablesMCGA -print)'
export RESOL='${TRCLV:0:6}'
export NIVEL='${TRCLV:6:4}'
export NUMPERT='${NPERT}'
export PBS_SERVER='${pbs_server2}'
export NUM='${SCRIPTNUM}'
export PREFXI='\${NUM}'
export LABELI='${LABELI}'
export NAMEL='GEOFPE\${NUM}'
export GNAME='GANL${PREF}'
export NAMER='GANL\${PREFXI}R'
export NAMES1='GANL\${NUM}P'
export NAMES3='GANL\${NUM}N'
export EXTL='P.rpt'
export EXTG='S.unf'
export ERR1='P.rp1'
export ERR2='P.rp2'
export ERR3='P.rp3'
export ERS1='S.rp1'
export ERS2='S.rp2'
export ERS3='S.rp3'
export TRUNC='$(echo ${TRC} |awk '{ printf("TQ%4.4d\n",$1)  }' )'
export LEV='$(echo ${LV} |awk '{ printf("L%3.3d\n",$1)  }' )'
export MACH='${MAQUI}'
export job_deceof_id='$(echo ${job_deceof} | awk -F " " '{print $4}')'

if [ "${1}" = "help" -o -z "${1}" ]
then
cat < ${0} | sed -n '/^#BOP/,/^#EOP/p'
exit 0
fi
. ${FILEENV} ${1} ${2}
cd ${HOME_suite}/run
TRC=$(echo ${TRCLV} | cut -c 1-6 | tr -d "TQ0")
LV=$(echo ${TRCLV} | cut -c 7-11 | tr -d "L0")
if [ -z "${2}" ]
then
echo "PREFIC esta faltando"
exit 1
else
PREFIC=${2}
fi
if [ -z "${3}" ]
then
echo "HUMID esta faltando"
exit 1
else
HUMID=${3}
fi
if [ -z "${4}" ]
then
echo "LABELI esta faltando"
exit 1
else
LABELI=${4}
fi
if [ -z "${5}" ]
then
echo "NPERT esta faltando"
exit 1
else
NPERT=${5}
fi
if [ -z "${6}" ]
then
echo "PREF esta faltando"
exit 1
else
PREF=${6}
fi
MPHN=1; MPTR=1; MPHS=1; MPNAS=1; MPSAS=1
MTHN=1; MTTR=1; MTHS=1; MTNAS=1; MTSAS=1
MQHN=1; MQTR=1; MQHS=1; MQNAS=1; MQSAS=1
MUHN=1; MUTR=1; MUHS=1; MUNAS=1; MUSAS=1
MVHN=1; MVTR=1; MVHS=1; MVNAS=1; MVSAS=1
cd ${HOME_suite}/run
RUNTM=$(date +"%s")
SCRIPTSFILES=setdec${2}.${TRCLV}.${LABELI}.${MAQUI}
if [ $(echo "$QSUB" | grep qsub) ]
then
SCRIPTHEADER="
"
SCRIPTNUM="\$(printf %02g \${PBS_ARRAY_INDEX})"
SCRIPTRUNCMD="aprun -n 1 -N 1 -d 1 ${DK_suite}/deceof/bin/\${TRUNC}\${LEV}/deceof.\${TRUNC}\${LEV} < \${HOME_suite}/deceof/datain/deceof\${NUM}.nml > \${HOME_suite}/deceof/output/deceof.\${NUM}.${LABELI}.\${HOUR}.\${TRUNC}\${LEV}"
SCRIPTRUNJOB="qsub -W block=true "
else
SCRIPTHEADER="
"
SCRIPTNUM="\$(printf %02g \${SLURM_ARRAY_TASK_ID})"
if [ $USE_SINGULARITY == true ]
then
SCRIPTRUNCMD="module load singularity ; singularity exec -e --bind ${WORKBIND}:${WORKBIND} ${SIFIMAGE} mpirun -np 1 ${SIFOENSMB09BIN}/deceof/bin/\${TRUNC}\${LEV}/deceof.\${TRUNC}\${LEV} < \${HOME_suite}/deceof/datain/deceof\${NUM}.nml > \${HOME_suite}/deceof/output/deceof.\${NUM}.${LABELI}.\${HOUR}.\${TRUNC}\${LEV}"
else
SCRIPTRUNCMD="mpirun -np 1 ${DK_suite}/deceof/bin/\${TRUNC}\${LEV}/deceof.\${TRUNC}\${LEV} < \${HOME_suite}/deceof/datain/deceof\${NUM}.nml > \${HOME_suite}/deceof/output/deceof.\${NUM}.${LABELI}.\${HOUR}.\${TRUNC}\${LEV}"
fi
if [ ! -z ${job_eof_id} ]
then
SCRIPTRUNJOB="sbatch --dependency=afterok:${job_eof_id}"
else
SCRIPTRUNJOB="sbatch "
fi
fi
monitor=${DK_suite}/deceof/output/monitor.t
if [ -e ${monitor} ]; then rm ${monitor}; fi
cat <<EOT0 > ${HOME_suite}/run/${SCRIPTSFILES}
${SCRIPTHEADER}
DATE=\$(date +'%Y')\$(date +'%m')\$(date +'%d')
HOUR=\$(date +'%H:%M')
echo "Date: "\${DATE}
echo "Hour: "\${HOUR}
echo \${HOME_suite}
echo ${DK_suite}
echo ${DK_suite}/model/datain
mkdir -p ${DK_suite}/deceof/datain/
GNAMEL=\${NAMEL}\${LABELI}\${EXTL}.\${TRUNC}\${LEV}
cat <<EOT3 > ${DK_suite}/deceof/datain/deceof\${NUM}.nml
&DATAIN
GNAMEL='\${GNAMEL} '
DIRL='${DK_suite}/deceof/datain/ '
DIRI='${DK_suite}/model/datain/ '
DIRG='${DK_suite}/eof/dataout/\${TRUNC}\${LEV}/ '
DIRS='${DK_suite}/model/datain/ '
&END
&HUMIDI
HUM='${HUMID}'
&END
EOT3
filephn=prssehn\${NUM}${MPHN}\${LABELI}
fileptr=prssetr\${NUM}${MPTR}\${LABELI}
filephs=prssehs\${NUM}${MPHS}\${LABELI}
filepnas=prssenas\${NUM}${MPNAS}\${LABELI}
filepsas=prssesas\${NUM}${MPSAS}\${LABELI}
echo "filephn= "\${filephn}
echo "fileptr= "\${fileptr}
echo "filephs= "\${filephs}
echo "filepnas="\${filepnas}
echo "filepsas="\${filepsas}
filethn=tempehn\${NUM}${MTHN}\${LABELI}
filettr=tempetr\${NUM}${MTTR}\${LABELI}
fileths=tempehs\${NUM}${MTHS}\${LABELI}
filetnas=tempenas\${NUM}${MTNAS}\${LABELI}
filetsas=tempesas\${NUM}${MTSAS}\${LABELI}
echo "filethn= "\${filethn}
echo "filettr= "\${filettr}
echo "fileths= "\${fileths}
echo "filetnas="\${filetnas}
echo "filetsas="\${filetsas}
fileqhn=humpehn\${NUM}${MQHN}\${LABELI}
fileqtr=humpetr\${NUM}${MQTR}\${LABELI}
fileqhs=humpehs\${NUM}${MQHS}\${LABELI}
fileqnas=humpenas\${NUM}${MQNAS}\${LABELI}
fileqsas=humpesas\${NUM}${MQSAS}\${LABELI}
echo "fileqhn= "\${fileqhn}
echo "fileqtr= "\${fileqtr}
echo "fileqhs= "\${fileqhs}
echo "fileqnas="\${fileqnas}
echo "fileqsas="\${fileqsas}
fileuhn=winpehn\${NUM}${MUHN}\${LABELI}
fileutr=winpetr\${NUM}${MUTR}\${LABELI}
fileuhs=winpehs\${NUM}${MUHS}\${LABELI}
fileunas=winpenas\${NUM}${MUNAS}\${LABELI}
fileusas=winpesas\${NUM}${MUSAS}\${LABELI}
echo "fileuhn= "\${fileuhn}
echo "fileutr= "\${fileutr}
echo "fileuhs= "\${fileuhs}
echo "fileunas="\${fileunas}
echo "fileusas="\${fileusas}
filevhn=winpehn\${NUM}${MVHN}\${LABELI}
filevtr=winpetr\${NUM}${MVTR}\${LABELI}
filevhs=winpehs\${NUM}${MVHS}\${LABELI}
filevnas=winpenas\${NUM}${MVNAS}\${LABELI}
filevsas=winpesas\${NUM}${MVSAS}\${LABELI}
echo "filevhn= "\${filevhn}
echo "filevtr= "\${filevtr}
echo "filevhs= "\${filevhs}
echo "filevnas="\${filevnas}
echo "filevsas="\${filevsas}
rm -f ${DK_suite}/deceof/datain/\${GNAMEL}
cat <<EOT2 > ${DK_suite}/deceof/datain/\${GNAMEL}
\${GNAME}\${LABELI}\${EXTG}.\${TRUNC}\${LEV}
\${filephn}
\${fileptr}
\${filephs}
\${filepnas}
\${filepsas}
\${filethn}
\${filettr}
\${fileths}
\${filetnas}
\${filetsas}
\${fileqhn}
\${fileqtr}
\${fileqhs}
\${fileqnas}
\${fileqsas}
\${fileuhn}
\${fileutr}
\${fileuhs}
\${fileunas}
\${fileusas}
\${filevhn}
\${filevtr}
\${filevhs}
\${filevnas}
\${filevsas}
\${NAMES1}\${LABELI}\${EXTG}.\${TRUNC}\${LEV}
EOT2
cd \${HOME_suite}/deceof/bin/\${TRUNC}\${LEV}
${SCRIPTRUNCMD}
filephn=prssnhn\${NUM}${MPHN}\${LABELI}
fileptr=prssntr\${NUM}${MPTR}\${LABELI}
filephs=prssnhs\${NUM}${MPHS}\${LABELI}
filepnas=prssnnas\${NUM}${MPNAS}\${LABELI}
filepsas=prssnsas\${NUM}${MPSAS}\${LABELI}
echo "filephn= "\${filephn}
echo "fileptr= "\${fileptr}
echo "filephs= "\${filephs}
echo "filepnas="\${filepnas}
echo "filepsas="\${filepsas}
filethn=tempnhn\${NUM}${MTHN}\${LABELI}
filettr=tempntr\${NUM}${MTTR}\${LABELI}
fileths=tempnhs\${NUM}${MTHS}\${LABELI}
filetnas=tempnnas\${NUM}${MTNAS}\${LABELI}
filetsas=tempnsas\${NUM}${MTSAS}\${LABELI}
echo "filethn= "\${filethn}
echo "filettr= "\${filettr}
echo "fileths= "\${fileths}
echo "filetnas="\${filetnas}
echo "filetsas="\${filetsas}
fileqhn=humpnhn\${NUM}${MQHN}\${LABELI}
fileqtr=humpntr\${NUM}${MQTR}\${LABELI}
fileqhs=humpnhs\${NUM}${MQHS}\${LABELI}
fileqnas=humpnnas\${NUM}${MQNAS}\${LABELI}
fileqsas=humpnsas\${NUM}${MQSAS}\${LABELI}
echo "fileqhn= "\${fileqhn}
echo "fileqtr= "\${fileqtr}
echo "fileqhs= "\${fileqhs}
echo "fileqnas="\${fileqnas}
echo "fileqsas="\${fileqsas}
fileuhn=winpnhn\${NUM}${MUHN}\${LABELI}
fileutr=winpntr\${NUM}${MUTR}\${LABELI}
fileuhs=winpnhs\${NUM}${MUHS}\${LABELI}
fileunas=winpnnas\${NUM}${MUNAS}\${LABELI}
fileusas=winpnsas\${NUM}${MUSAS}\${LABELI}
echo "fileuhn= "\${fileuhn}
echo "fileutr= "\${fileutr}
echo "fileuhs= "\${fileuhs}
echo "fileunas="\${fileunas}
echo "fileusas="\${fileusas}
filevhn=winpnhn\${NUM}${MVHN}\${LABELI}
filevtr=winpntr\${NUM}${MVTR}\${LABELI}
filevhs=winpnhs\${NUM}${MVHS}\${LABELI}
filevnas=winpnnas\${NUM}${MVNAS}\${LABELI}
filevsas=winpnsas\${NUM}${MVSAS}\${LABELI}
echo "filevhn= "\${filevhn}
echo "filevtr= "\${filevtr}
echo "filevhs= "\${filevhs}
echo "filevnas="\${filevnas}
echo "filevsas="\${filevsas}
rm -f ${DK_suite}/deceof/datain/\${GNAMEL}
cat <<EOT4 > ${DK_suite}/deceof/datain/\${GNAMEL}
\${GNAME}\${LABELI}\${EXTG}.\${TRUNC}\${LEV}
\${filephn}
\${fileptr}
\${filephs}
\${filepnas}
\${filepsas}
\${filethn}
\${filettr}
\${fileths}
\${filetnas}
\${filetsas}
\${fileqhn}
\${fileqtr}
\${fileqhs}
\${fileqnas}
\${fileqsas}
\${fileuhn}
\${fileutr}
\${fileuhs}
\${fileunas}
\${fileusas}
\${filevhn}
\${filevtr}
\${filevhs}
\${filevnas}
\${filevsas}
\${NAMES3}\${LABELI}\${EXTG}.\${TRUNC}\${LEV}
EOT4
cd \${HOME_suite}/deceof/bin/\${TRUNC}\${LEV}
${SCRIPTRUNCMD}
touch ${monitor}
EOT0
chmod +x ${HOME_suite}/run/${SCRIPTSFILES}
job_deceof=$(${SCRIPTRUNJOB} ${HOME_suite}/run/${SCRIPTSFILES})
echo "deceof ${job_deceof_id}"
until [ -e ${monitor} ]; do sleep 1s; done
