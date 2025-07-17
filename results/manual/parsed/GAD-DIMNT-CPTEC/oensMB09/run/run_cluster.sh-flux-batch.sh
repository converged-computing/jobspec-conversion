#!/bin/bash
#FLUX: --job-name=CLUSTERFIGS
#FLUX: --queue=${AUX_QUEUE}
#FLUX: -t=1800
#FLUX: --urgency=16

export FILEENV='$(find ./ -name EnvironmentalVariablesMCGA -print)'
export PATHENV='$(dirname ${FILEENV})'
export PATHBASE='$(cd ${PATHENV}; cd ; pwd)'
export RESOL='${TRCLV:0:6}'
export NIVEL='${TRCLV:6:4}'
export NMEMBR='$((2*${NRNDP}+1))'
export LABELF='$(${inctime} ${LABELI} +${NFCTDY}d %y4%m2%d2%h2)'
export RUNTM='$(date +'%Y%m%d%T')'
export OPERM='${DK_suite}'
export ROPERM='${DK_suite}/produtos'
export SCRIPTFILEPATH1='${DK_suite}/run/setcluster.${RESOL}${NIVEL}.${LABELI}.${MAQUI}'
export SCRIPTFILEPATH2='${DK_suite}/run/setcluster_figs.${RESOL}${NIVEL}.${LABELI}.${MAQUI}'
export DATE='$(date +'%Y%m%d')'
export HOUR='$(date +'%T')'
export OPERMOD='${OPERM}'
export ROPERMOD='${ROPERM}'
export LEV='${NIVEL}'
export TRUNC='${RESOL}'
export MACH='${MAQUI}'
export EXTS='S.unf'
export PBS_SERVER='${pbs_server2}'

if [ "${1}" = "help" -o -z "${1}" ]
then
  cat < ${0} | sed -n '/^#BOP/,/^#EOP/p'
  exit 0
fi
if [ -z ${1} ]
then
  echo "RES esta faltando"
  exit 1
else
  export RES=${1}
fi
if [ -z ${2} ]
then
  echo "LABELI esta faltando"
  exit 1
else
  export LABELI=${2}
fi
if [ -z ${3} ]
then
  echo "NFCTDY esta faltando"
  exit 1
else
  export NFCTDY=${3}
fi
if [ -z ${4} ]
then
  echo "PREFX esta faltando"
  exit 1
else
  export PREFX=${4}
fi
if [ -z ${5} ]
then
  echo "NRNDP esta faltando"
  exit 1
else
  export NRNDP=${5}
fi
export FILEENV=$(find ./ -name EnvironmentalVariablesMCGA -print)
export PATHENV=$(dirname ${FILEENV})
export PATHBASE=$(cd ${PATHENV}; cd ; pwd)
. ${FILEENV} ${RES} ${PREFX}
cd ${HOME_suite}/run
TRC=$(echo ${TRCLV} | cut -c 1-6 | tr -d "TQ0")
LV=$(echo ${TRCLV} | cut -c 7-11 | tr -d "L0")
export RESOL=${TRCLV:0:6}
export NIVEL=${TRCLV:6:4}
export NMEMBR=$((2*${NRNDP}+1))
export LABELF=$(${inctime} ${LABELI} +${NFCTDY}d %y4%m2%d2%h2)
case ${TRC} in
  021) MR=22  ; IR=64  ; JR=32  ; NPGH=93   ; DT=1800 ;;
  030) MR=31  ; IR=96  ; JR=48  ; NPGH=140  ; DT=1800 ;;
  042) MR=43  ; IR=128 ; JR=64  ; NPGH=187  ; DT=1800 ;;
  047) MR=48  ; IR=144 ; JR=72  ; NPGH=26   ; DT=1200 ;;
  062) MR=63  ; IR=192 ; JR=96  ; NPGH=315  ; DT=1200 ;;
  079) MR=80  ; IR=240 ; JR=120 ; NPGH=26   ; DT=900  ;;
  085) MR=86  ; IR=256 ; JR=128 ; NPGH=26   ; DT=720  ;;
  094) MR=95  ; IR=288 ; JR=144 ; NPGH=591  ; DT=720  ;;
  106) MR=107 ; IR=320 ; JR=160 ; NPGH=711  ; DT=600  ;;
  126) MR=127 ; IR=384 ; JR=192 ; NPGH=284  ; DT=600  ;;
  159) MR=160 ; IR=480 ; JR=240 ; NPGH=1454 ; DT=450  ;;
  170) MR=171 ; IR=512 ; JR=256 ; NPGH=1633 ; DT=450  ;;
  213) MR=214 ; IR=640 ; JR=320 ; NPGH=2466 ; DT=360  ;;
  254) MR=255 ; IR=768 ; JR=384 ; NPGH=3502 ; DT=300  ;;
  319) MR=320 ; IR=960 ; JR=480 ; NPGH=26   ; DT=240  ;;
  *) echo "Wrong request for horizontal resolution: ${TRC}" ; exit 1;
esac
export RUNTM=$(date +'%Y%m%d%T')
export OPERM=${DK_suite}
export ROPERM=${DK_suite}/produtos
cd ${OPERM}/run
export SCRIPTFILEPATH1=${DK_suite}/run/setcluster.${RESOL}${NIVEL}.${LABELI}.${MAQUI}
export SCRIPTFILEPATH2=${DK_suite}/run/setcluster_figs.${RESOL}${NIVEL}.${LABELI}.${MAQUI}
if [ $(echo "$QSUB" | grep qsub) ]
then
  SCRIPTHEADER1="
"
  SCRIPTHEADER2="
"
  SCRIPTRUNCMD="aprun -n 1 -N 1 -d 1 \${ROPERMOD}/cluster/bin/cluster.x ${LABELI} ${LABELF} > \${ROPERMOD}/cluster/output/cluster.${RUNTM}.log"
  SCRIPTRUNJOB="qsub -W block=true "
else
  SCRIPTHEADER1="
"
  SCRIPTHEADER2="
"
  if [ $USE_SINGULARITY == true ]
  then
    SCRIPTRUNCMD="module load singularity ; singularity exec -e --bind ${WORKBIND}:${WORKBIND} ${SIFIMAGE} mpirun -np 1 ${SIFOENSMB09BIN}/produtos/cluster/bin/cluster.x ${LABELI} ${LABELF} > \${ROPERMOD}/cluster/output/cluster.${RUNTM}.log"
  else
    SCRIPTRUNCMD="mpirun -np 1 \${ROPERMOD}/cluster/bin/cluster.x ${LABELI} ${LABELF} /ensmed/output/ensmed.${RUNTM}.log"
  fi
  SCRIPTRUNJOB="sbatch "
fi
if [ -e ${ROPERM}/cluster/bin/cluster-${LABELI}.ok ]; then rm ${ROPERM}/cluster/bin/cluster-${LABELI}.ok; fi
if [ -e ${ROPERM}/cluster/bin/cluster_figs-${LABELI}.ok ]; then rm ${ROPERM}/cluster/bin/cluster_figs-${LABELI}.ok; fi
cat <<EOT0 > ${SCRIPTFILEPATH1}
${SCRIPTHEADER1}
export DATE=$(date +'%Y%m%d')
export HOUR=$(date +'%T')
export OPERMOD=${OPERM}
export ROPERMOD=${ROPERM}
export LEV=${NIVEL}
export TRUNC=${RESOL}
export MACH=${MAQUI}
export EXTS=S.unf
mkdir -p \${ROPERMOD}/cluster/dataout/\${TRUNC}\${LEV}/\${LABELI}/clusters/
mkdir -p \${ROPERMOD}/cluster/rmsclim
cat <<EOF0 > \${ROPERMOD}/cluster/bin/clustersetup.${LABELI}.nml
IMAX      :   ${IR}
JMAX      :   ${JR}
NMEMBERS  :   ${NMEMBR}
NFCTDY    :   ${NFCTDY}
GRPETA    :    4
FREQCALC  :    6
LONW      :   -101.25 
LONE      :    -11.25 
LATS      :    -60.00
LATN      :     15.00
DATALSTDIR:   \${OPERMOD}/pos/dataout/\${TRUNC}\${LEV}/\${LABELI}/
DATARMSDIR:   \${ROPERMOD}/cluster/rmsclim/
DATAOUTDIR:   \${ROPERMOD}/cluster/dataout/\${TRUNC}\${LEV}/\${LABELI}/
DATACLTDIR:   \${ROPERMOD}/cluster/dataout/\${TRUNC}\${LEV}/\${LABELI}/clusters/
RESOL     :   \${TRUNC}\${LEV}
PREFX     :   ${PREFX}
EOF0
cd \${ROPERMOD}/cluster/bin
${SCRIPTRUNCMD}
echo "" > \${ROPERMOD}/cluster/bin/cluster-${LABELI}.ok
EOT0
cat <<EOT1 > ${SCRIPTFILEPATH2}
${SCRIPTHEADER2}
export DATE=$(date +'%Y%m%d')
export HOUR=$(date +'%T')
export OPERMOD=${OPERM}
export ROPERMOD=${ROPERM}
export LEV=${NIVEL}
export TRUNC=${RESOL}
export MACH=${MAQUI}
export EXTS=S.unf
DIRSCR=${ROPERM}/cluster/scripts
DIRGIF=${ROPERM}/cluster/gif/${LABELI}
DIRCTL=${OPERM}/pos/dataout/${RES}/${LABELI}
DIRCLT=${ROPERM}/cluster/dataout/${RES}/${LABELI}/clusters
if [ ! -d \${DIRGIF} ]; then mkdir -p \${DIRGIF}; fi
if [ ! -d \${DIRCTL} ]; then mkdir -p \${DIRCTL}; fi
cd \${DIRSCR}
NPERT=1
while [ \${NPERT} -le ${NRNDP} ]
do
  if [ \${NPERT} -lt 10 ]; then NPERT='0'\${NPERT}; fi
  rm -f filefct\${NPERT}P${LABELI}.${TRC}
  rm -f filefct\${NPERT}N${LABELI}.${TRC}
  let NPERT=NPERT+1
done
rm -f filefct${PREFX}${LABELI}.${TRC}
rm -f fileclt${LABELI}.${TRC}
let NHOURS=24*NFCTDY
NCTLS=0
TIM=0
while [ \${TIM} -le \${NHOURS} ]
do
  LABELF=\$(${inctime} ${LABELI} +\${TIM}hr %y4%m2%d2%h2)
  echo 'LABELF='${LABELF}
  if [ \${TIM} -eq 0 ]; then TYPE='P.icn'; else TYPE='P.fct'; fi
  NPERT=1
  while [ \${NPERT} -le ${NRNDP} ]
  do
    if [ \${NPERT} -lt 10 ]; then  NPERT='0'\${NPERT}; fi
    if [ -s \${DIRCTL}/GPOS\${NPERT}P${LABELI}\${LABELF}\${TYPE}.${RES}.ctl ]
    then
cat <<EOF0 >> filefct\${NPERT}P${LABELI}.${TRC}
\${DIRCTL}/GPOS\${NPERT}P${LABELI}\${LABELF}\${TYPE}.${RES}.ctl
EOF0
    else
       echo "\${DIRCTL}/GPOS\${NPERT}P${LABELI}\${LABELF}\${TYPE}.${RES}.ctl nao existe"
       exit 2
    fi
    if [ -s \${DIRCTL}/GPOS\${NPERT}N${LABELI}\${LABELF}\${TYPE}.${RES}.ctl ]
    then
cat <<EOF1 >> filefct\${NPERT}N${LABELI}.${TRC}
\${DIRCTL}/GPOS\${NPERT}N${LABELI}\${LABELF}\${TYPE}.${RES}.ctl
EOF1
    else
      echo "\${DIRCTL}/GPOS\${NPERT}N${LABELI}\${LABELF}\${TYPE}.${RES}.ctl nao existe"
      exit 2
    fi
    let NPERT=NPERT+1
  done
  if [ -s \${DIRCTL}/GPOS\${PREFX}${LABELI}\${LABELF}\${TYPE}.${RES}.ctl ]
  then
cat <<EOF2 >> filefct\${PREFX}${LABELI}.${TRC}
\${DIRCTL}/GPOS\${PREFX}${LABELI}\${LABELF}\${TYPE}.${RES}.ctl
EOF2
  else
    echo "\${DIRCTL}/GPOS\${PREFX}${LABELI}\${LABELF}\${TYPE}.${RES}.ctl nao existe"
    exit 2
  fi
  if [ -s \${DIRCLT}/clusters${LABELI}\${LABELF}.${RES} ]
  then
cat <<EOF3 >> fileclt${LABELI}.${TRC}
\${DIRCLT}/clusters${LABELI}\${LABELF}.${RES}
EOF3
  else
    echo "\${DIRCLT}/clusters${LABELI}\${LABELF}.${RES} nao existe"
    exit 2
  fi
  let NCTLS=NCTLS+1
  let TIM=TIM+6
done
echo "NCTLS="\${NCTLS}
${DIRGRADS}/grads -bp << EOF4
run plot_temp_zgeo.gs
${TRC} ${LABELI} ${NMEMBR} \${NCTLS} ${RES} ${PREFX} \${DIRGIF} ${convert}
EOF4
${DIRGRADS}/grads -bp << EOF5
run plot_prec_psnm_wind.gs
${TRC} ${LABELI} ${NMEMBR} \${NCTLS} ${RES} ${PREFX} \${DIRGIF} ${convert}
EOF5
${DIRGRADS}/grads -bp << EOF6
run plot_tems.gs
${TRC} ${LABELI} ${NMEMBR} \${NCTLS} ${RES} ${PREFX} \${DIRGIF} ${convert}
EOF6
NPERT=1
while [ \${NPERT} -le ${NRNDP} ]
do
  if [ \${NPERT} -lt 10 ]; then NPERT='0'\${NPERT}; fi
  rm -f filefct\${NPERT}P${LABELI}.${TRC}
  rm -f filefct\${NPERT}N${LABELI}.${TRC}
  let NPERT=NPERT+1
done
rm -f filefct${PREFX}${LABELI}.${TRC}
rm -f fileclt${LABELI}.${TRC}
echo "" > \${ROPERMOD}/cluster/bin/cluster_figs-${LABELI}.ok
EOT1
export PBS_SERVER=${pbs_server2}
chmod +x ${SCRIPTFILEPATH1}
${SCRIPTRUNJOB} ${SCRIPTFILEPATH1}
until [ -e "${ROPERM}/cluster/bin/cluster-${LABELI}.ok" ]; do sleep 1s; done
chmod +x ${SCRIPTFILEPATH2}
${SCRIPTRUNJOB} ${SCRIPTFILEPATH2}
until [ -e "${ROPERM}/cluster/bin/cluster_figs-${LABELI}.ok" ]; do sleep 1s; done
if [ ${SEND_TO_FTP} == true ]
then
  cd ${ROPERM}/cluster/gif/${LABELI}/
  ls *.png >  list.txt
  rsync -arv * ${FTP_ADDRESS}/cluster/${LABELI}/
fi
