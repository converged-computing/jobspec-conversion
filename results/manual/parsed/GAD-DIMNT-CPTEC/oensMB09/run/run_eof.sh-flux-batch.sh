#!/bin/bash
#FLUX: --job-name=EOFPERT
#FLUX: --queue=${AUX_QUEUE}
#FLUX: --urgency=16

export FILEENV='$(find ${PWD} -name EnvironmentalVariablesMCGA -print)'
export RESOL='${TRCLV:0:6}'
export NIVEL='${TRCLV:6:4}'
export MAQUI='$(hostname -s)'
export PBS_SERVER='${pbs_server2}'
export MEM='${SCRIPTMEM}'
export USE_SINGULARITY='${USE_SINGULARITY}'
export DK_suite_exe='${DK_suite}'
export MR='${MR}'
export KR='${KR}'
export LR='${LR}'
export IR='${IR}'
export JR='${JR}'
export NI='${NASNI}'
export NJ='${NASNJ}'
export II='${NASII}'
export IS='${NASIS}'
export JI='${NASJI}'
export JS='${NASJS}'
export IIPS='${NASIIPS}'
export ISPS='${NASISPS}'
export JIPS='${NASJIPS}'
export JSPS='${NASJSPS}'
export TRUNC='${RESOL}'
export LEV='${NIVEL}'
export DATE='\$(date +'%Y')\$(date +'%m')\$(date +'%d')'
export HOUR='\$(date +'%H:%M')'
export ext='R.unf'
export job_eof_id='$(echo ${job_eof} | awk -F " " '{print $4}')'

if [ "${1}" = "help" -o -z "${1}" ]
then
cat < ${0} | sed -n '/^#BOP/,/^#EOP/p'
exit 0
fi
if [ -z "${1}" ]
then
echo "TRCLV esta faltando"
exit 1
else
TRCLV=${1}
fi
if [ -z "${2}" ]
then
echo "NMEM esta faltando"
exit 1
else
NMEM=${2}
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
echo "PREF esta faltando"
exit 1
else
PREF=${5}
fi
. ${FILEENV} ${TRCLV} ${NMEM}
cd ${HOME_suite}/run
TRC=$(echo ${TRCLV} | cut -c 1-6 | tr -d "TQ0")
LV=$(echo ${TRCLV} | cut -c 7-11 | tr -d "L0")
LABELF=$(date -d "${LABELI:0:8} ${LABELI:8:2}:00 ${NFDAYS} days" +"%Y%m%d%H")
case ${TRC} in
126) MR=126      ; KR=28       ; LR=11       ;               # Define a resolução do modelo e número de EOFs
IR=384      ; JR=192      ;                             # Define o número de pontos da grade
HSNI=384    ; HSNJ=75     ;                             # Define o número de pontos da região
HSII=1      ; HSIS=384    ; HSJI=118    ; HSJS=192    ; # Define a região da perturbação
HSIIPS=192  ; HSISPS=299  ; HSJIPS=118  ; HSJSPS=153  ; # Não usado
TRNI=384    ; TRNJ=42     ;                             # Define o número de pontos da região
TRII=1      ; TRIS=384    ; TRJI=76     ; TRJS=117    ; # Define a região da perturbação
TRIIPS=192  ; TRISPS=299  ; TRJIPS=76   ; TRJSPS=117  ; # Não usado
HNNI=384    ; HNNJ=75     ;                             # Define o número de pontos da região
HNII=1      ; HNIS=384    ; HNJI=1      ; HNJS=75     ; # Define a região da perturbação
HNIIPS=192  ; HNISPS=299  ; HNJIPS=40   ; HNJSPS=75   ; # Não usado
NASNI=97    ; NASNJ=34    ;                             # Define o número de pontos da região
NASII=276   ; NASIS=372   ; NASJI=75    ; NASJS=108   ; # Define a região da perturbação
NASIIPS=276 ; NASISPS=316 ; NASJIPS=75  ; NASJSPS=108 ; # Não usado
SASNI=97    ; SASNJ=53    ;                             # Define o número de pontos da região
SASII=266   ; SASIS=362   ; SASJI=109   ; SASJS=161   ; # Define a região da perturbação
SASIIPS=266 ; SASISPS=316 ; SASJIPS=109 ; SASJSPS=160 ; # Não usado
;;
213) MR=213      ; KR=42       ; LR=11      ;
IR=640      ; JR=320      ;
HSNI=640    ; HSNJ=125    ;                           # Define o número de pontos da região
HSII=1      ; HSIS=640    ; HSJI=196   ; HSJS=320   ; # Define a região da perturbação
HSIIPS=1    ; HSISPS=640  ; HSJIPS=196 ; HSJSPS=320 ; # Não usado
TRNI=640    ; TRNJ=70     ;                           # Define o número de pontos da região
TRII=1      ; TRIS=640    ; TRJI=126   ; TRJS=195   ; # Define a região da perturbação
TRIIPS=1    ; TRISPS=640  ; TRJIPS=126 ; TRJSPS=195 ; # Não usado
HNNI=640    ; HNNJ=125    ;                           # Define o número de pontos da região
HNII=1      ; HNIS=640    ; HNJI=1     ; HNJS=125   ; # Define a região da perturbação
HNIIPS=1    ; HNISPS=640  ; HNJIPS=1   ; HNJSPS=125 ; # Não usado
NASNI=161   ; NASNJ=70    ;                           # Define o número de pontos da região
NASII=459   ; NASIS=619   ; NASJI=126  ; NASJS=195  ; # Define a região da perturbação
NASIIPS=459 ; NASISPS=619 ; NASJIPS=126; NASJSPS=195; # Não usado
SASNI=161   ; SASNJ=73    ;                            # Define o número de pontos da região
SASII=443   ; SASIS=603   ; SASJI=196  ; SASJS=268   ; # Define a região da perturbação
SASIIPS=443 ; SASISPS=603 ; SASJIPS=196; SASJSPS=268 ; # Não usado
;;
299) MR=299      ; KR=64       ; LR=11      ;
IR=900      ; JR=450      ;
HSNI=900    ; HSNJ=176    ;                           # Define o número de pontos da região
HSII=1      ; HSIS=900    ; HSJI=275   ; HSJS=450   ; # Define a região da perturbação
HSIIPS=1    ; HSISPS=900  ; HSJIPS=275 ; HSJSPS=450 ; # Não usado
TRNI=900    ; TRNJ=98     ;                           # Define o número de pontos da região
TRII=1      ; TRIS=900    ; TRJI=177   ; TRJS=274   ; # Define a região da perturbação
TRIIPS=1    ; TRISPS=900  ; TRJIPS=177 ; TRJSPS=274 ; # Não usado
HNNI=900    ; HNNJ=176    ;                           # Define o número de pontos da região
HNII=1      ; HNIS=900    ; HNJI=1     ; HNJS=176   ; # Define a região da perturbação
HNIIPS=1    ; HNISPS=900  ; HNJIPS=1   ; HNJSPS=176 ; # Não usado
NASNI=226   ; NASNJ=98    ;                           # Define o número de pontos da região
NASII=645   ; NASIS=870   ; NASJI=177  ; NASJS=274  ; # Define a região da perturbação
NASIIPS=645 ; NASISPS=870 ; NASJIPS=177; NASJSPS=274; # Não usado
SASNI=226   ; SASNJ=103   ;                            # Define o número de pontos da região
SASII=623   ; SASIS=848   ; SASJI=275   ; SASJS=377  ; # Define a região da perturbação
SASIIPS=623 ; SASISPS=848 ; SASJIPS=275 ; SASJSPS=377; # Não usado
;;
*) echo "Wrong request for horizontal resolution: ${TRC}" ; exit 1;
esac
cd ${HOME_suite}/run
mkdir -p ${DK_suite}/model/exec/setout
SCRIPTSFILE=set${NMEM}pereof.${TRCLV}.${LABELI}.${MAQUI}
RUNTM=$(date +"%s")
if [ $(echo "$QSUB" | grep qsub) ]
then
SCRIPTHEADER="
"
SCRIPTMEM="\$(printf %02g \${PBS_ARRAY_INDEX})"
SCRIPTRUNCMD="aprun -n 1 -N 1 -d 1 "
SCRIPTRUNJOB="qsub -W block=true "
else
SCRIPTHEADER="
"
SCRIPTMEM="\$(printf %02g \${SLURM_ARRAY_TASK_ID})"
if [ $USE_SINGULARITY == true ]
then
SCRIPTRUNCMD="module load singularity ; singularity exec -e --bind ${WORKBIND}:${WORKBIND} ${SIFIMAGE} mpirun -np 1 "
else
SCRIPTRUNCMD="mpirun -np 1 "
fi
if [ ! -z ${job_recfct_id} ]
then
SCRIPTRUNJOB="sbatch --dependency=afterok:${job_recfct_id}"
else
SCRIPTRUNJOB="sbatch "
fi
fi
monitor=${DK_suite}/eof/output/monitor.t
if [ -e ${monitor} ]; then rm ${monitor}; fi
cat <<EOT0 > ${HOME_suite}/run/${SCRIPTSFILE}
${SCRIPTHEADER}
mkdir -p ${DK_suite}/eof/datain/
mkdir -p ${DK_suite}/eof/dataout/${RESOL}${NIVEL}/
cd ${HOME_suite}/run
if [ \$USE_SINGULARITY == true ]
then
else
fi
Regs=(hs tr hn nas sas)
for REG in \${Regs[@]}
do
if [ \${REG} == hs ]
then
elif [ \${REG} == tr ]
then
elif [ \${REG} == hn ]
then
elif [ \${REG} == sas ]
then
elif [ \${REG} == nas ]
then
else
echo "Region undefined."
exit 1
fi
echo "Date: "\$DATE
echo "Hour: "\$HOUR
cd ${DK_suite}/recfct/dataout/${RESOL}${NIVEL}/${LABELI}/
for LABELF in \$(ls -1 GFCTCTR${LABELI}*fct* | cut -c18-27)
do
cat <<EOT1 >> ${DK_suite}/eof/datain/templ\${REG}\${MEM}${LABELI}
${DK_suite}/recfct/dataout/${RESOL}${NIVEL}/${LABELI}/GFCTCTR${LABELI}\${LABELF}\${ext}
${DK_suite}/recfct/dataout/${RESOL}${NIVEL}/${LABELI}/GFCT\${MEM}R${LABELI}\${LABELF}\${ext}
EOT1
done
echo ${DK_suite}/eof/datain/templ\${REG}\${MEM}${LABELI}
cp ${DK_suite}/eof/datain/templ\${REG}\${MEM}${LABELI} ${DK_suite}/eof/datain/templ\${MEM}${LABELI}
cd ${DK_suite}/eof/datain
cat <<EOT1 > eofpres\${REG}\${MEM}.nml
&DATAIN
DIRI='${DK_suite}/eof/datain/ '
DIRA='${DK_suite}/model/datain/ '
DIRO='${DK_suite}/eof/dataout/${RESOL}${NIVEL}/ '
NAMEL='templ\${MEM}${LABELI} '
ANAME='GANL${PREF}\${LABELI}\${ext}.${RESOL}${NIVEL} '
PRSOUT='prsout\${REG}\${MEM}${LABELI} '
PRSSCM='prsscm\${REG}\${MEM}${LABELI} '
&END
&PRSSER
PRSSER1(1)='prsse\${REG}\${MEM}1${LABELI} ',
PRSSER1(2)='prsse\${REG}\${MEM}2${LABELI} ',
PRSSER1(3)='prsse\${REG}\${MEM}3${LABELI} ',
PRSSER1(4)='prsse\${REG}\${MEM}4${LABELI} ',
PRSSER1(5)='prsse\${REG}\${MEM}5${LABELI} ',
PRSSER1(6)='prsse\${REG}\${MEM}6${LABELI} ',
PRSSER1(7)='prsse\${REG}\${MEM}7${LABELI} ',
PRSSER1(8)='prsse\${REG}\${MEM}8${LABELI} ',
PRSSER1(9)='prsse\${REG}\${MEM}9${LABELI} ',
PRSSER1(10)='prsse\${REG}\${MEM}10${LABELI} ',
PRSSER1(11)='prsse\${REG}\${MEM}11${LABELI} '
&END
&PRSSEN
PRSSEN1(1)='prssn\${REG}\${MEM}1${LABELI} ',
PRSSEN1(2)='prssn\${REG}\${MEM}2${LABELI} ',
PRSSEN1(3)='prssn\${REG}\${MEM}3${LABELI} ',
PRSSEN1(4)='prssn\${REG}\${MEM}4${LABELI} ',
PRSSEN1(5)='prssn\${REG}\${MEM}5${LABELI} ',
PRSSEN1(6)='prssn\${REG}\${MEM}6${LABELI} ',
PRSSEN1(7)='prssn\${REG}\${MEM}7${LABELI} ',
PRSSEN1(8)='prssn\${REG}\${MEM}8${LABELI} ',
PRSSEN1(9)='prssn\${REG}\${MEM}9${LABELI} ',
PRSSEN1(10)='prssn\${REG}\${MEM}10${LABELI} ',
PRSSEN1(11)='prssn\${REG}\${MEM}11${LABELI} '
&END
$(cat ${HOME_suite}/include/${RESOL}${NIVEL}/prespert_eof.nml)
&PARMET
IINF=\${II},ISUP=\${IS},IMAX0=\${NI},
JINF=\${JI},JSUP=\${JS},JMAX0=\${NJ},
IIPS=\${IIPS},ISPS=\${ISPS},JIPS=\${JIPS},JSPS=\${JSPS},
&END
EOT1
cd ${DK_suite}/eof/bin/\${TRUNC}\${LEV}/
${SCRIPTRUNCMD} \${DK_suite_exe}/eof/bin/\${TRUNC}\${LEV}/eofpres.\${TRUNC}\${LEV} < ${DK_suite}/eof/datain/eofpres\${REG}\${MEM}.nml > ${DK_suite}/eof/dataout/eofpres-\${MEM}.\${REG}.${LABELI}.\${HOUR}.\${TRUNC}\${LEV}
cd ${DK_suite}/eof/datain
cat <<EOT1 > eoftem\${REG}\${MEM}.nml
&DATAIN
DIRI='${DK_suite}/eof/datain/ '
DIRA='${DK_suite}/model/datain/ '
DIRO='${DK_suite}/eof/dataout/${RESOL}${NIVEL}/ '
NAMEL='templ\${REG}\${MEM}\${LABELI} '
ANAME='GANL${PREF}\${LABELI}\${ext}.${RESOL}${NIVEL} '
TEMOUT='temout\${REG}\${MEM}\${LABELI} '
TEMPCM='tempcm\${REG}\${MEM}\${LABELI} '
&END
&TEMPER
TEMPER1(1)='tempe\${REG}\${MEM}1\${LABELI} ',
TEMPER1(2)='tempe\${REG}\${MEM}2\${LABELI} ',
TEMPER1(3)='tempe\${REG}\${MEM}3\${LABELI} ',
TEMPER1(4)='tempe\${REG}\${MEM}4\${LABELI} ',
TEMPER1(5)='tempe\${REG}\${MEM}5\${LABELI} ',
TEMPER1(6)='tempe\${REG}\${MEM}6\${LABELI} ',
TEMPER1(7)='tempe\${REG}\${MEM}7\${LABELI} ',
TEMPER1(8)='tempe\${REG}\${MEM}8\${LABELI} ',
TEMPER1(9)='tempe\${REG}\${MEM}9\${LABELI} ',
TEMPER1(10)='tempe\${REG}\${MEM}10\${LABELI} ',
TEMPER1(11)='tempe\${REG}\${MEM}11\${LABELI} '
&END
&TEMPEN
TEMPEN1(1)='tempn\${REG}\${MEM}1\${LABELI} ',
TEMPEN1(2)='tempn\${REG}\${MEM}2\${LABELI} ',
TEMPEN1(3)='tempn\${REG}\${MEM}3\${LABELI} ',
TEMPEN1(4)='tempn\${REG}\${MEM}4\${LABELI} ',
TEMPEN1(5)='tempn\${REG}\${MEM}5\${LABELI} ',
TEMPEN1(6)='tempn\${REG}\${MEM}6\${LABELI} ',
TEMPEN1(7)='tempn\${REG}\${MEM}7\${LABELI} ',
TEMPEN1(8)='tempn\${REG}\${MEM}8\${LABELI} ',
TEMPEN1(9)='tempn\${REG}\${MEM}9\${LABELI} ',
TEMPEN1(10)='tempn\${REG}\${MEM}10\${LABELI} ',
TEMPEN1(11)='tempn\${REG}\${MEM}11\${LABELI} '
&END
$(cat ${HOME_suite}/include/${RESOL}${NIVEL}/temppert_eof.nml)
&PARMET
IINF=\${II},ISUP=\${IS},IMAX0=\${NI},
JINF=\${JI},JSUP=\${JS},JMAX0=\${NJ},
IIPS=\${IIPS},ISPS=\${ISPS},JIPS=\${JIPS},JSPS=\${JSPS}
&END
EOT1
cd ${DK_suite}/eof/bin/\${TRUNC}\${LEV}/
${SCRIPTRUNCMD} \${DK_suite_exe}/eof/bin/\${TRUNC}\${LEV}/eoftem.\${TRUNC}\${LEV} < ${DK_suite}/eof/datain/eoftem\${REG}\${MEM}.nml > ${DK_suite}/eof/dataout/eoftem-\${MEM}.\${REG}.${LABELI}.\${HOUR}.\${TRUNC}\${LEV}
if [ ${HUMID} = YES ]
then
cd ${DK_suite}/eof/datain
cat <<EOT1 > eofhum\${REG}\${MEM}.nml
&DATAIN
DIRI='${DK_suite}/eof/datain/ '
DIRA='${DK_suite}/model/datain/ '
DIRO='${DK_suite}/eof/dataout/${RESOL}${NIVEL}/ '
NAMEL='templ\${REG}\${MEM}\${LABELI} '
ANAME='GANL${PREF}\${LABELI}\${ext}.${RESOL}${NIVEL} '
HUMOUT='humout\${REG}\${MEM}\${LABELI} '
HUMPCM='humpcm\${REG}\${MEM}\${LABELI} '
&END
&HUMPER
HUMPER1(1)='humpe\${REG}\${MEM}1\${LABELI} ',
HUMPER1(2)='humpe\${REG}\${MEM}2\${LABELI} ',
HUMPER1(3)='humpe\${REG}\${MEM}3\${LABELI} ',
HUMPER1(4)='humpe\${REG}\${MEM}4\${LABELI} ',
HUMPER1(5)='humpe\${REG}\${MEM}5\${LABELI} ',
HUMPER1(6)='humpe\${REG}\${MEM}6\${LABELI} ',
HUMPER1(7)='humpe\${REG}\${MEM}7\${LABELI} ',
HUMPER1(8)='humpe\${REG}\${MEM}8\${LABELI} ',
HUMPER1(9)='humpe\${REG}\${MEM}9\${LABELI} ',
HUMPER1(10)='humpe\${REG}\${MEM}10\${LABELI} ',
HUMPER1(11)='humpe\${REG}\${MEM}11\${LABELI} '
&END
&HUMPEN
HUMPEN1(1)='humpn\${REG}\${MEM}1\${LABELI} ',
HUMPEN1(2)='humpn\${REG}\${MEM}2\${LABELI} ',
HUMPEN1(3)='humpn\${REG}\${MEM}3\${LABELI} ',
HUMPEN1(4)='humpn\${REG}\${MEM}4\${LABELI} ',
HUMPEN1(5)='humpn\${REG}\${MEM}5\${LABELI} ',
HUMPEN1(6)='humpn\${REG}\${MEM}6\${LABELI} ',
HUMPEN1(7)='humpn\${REG}\${MEM}7\${LABELI} ',
HUMPEN1(8)='humpn\${REG}\${MEM}8\${LABELI} ',
HUMPEN1(9)='humpn\${REG}\${MEM}9\${LABELI} ',
HUMPEN1(10)='humpn\${REG}\${MEM}10\${LABELI} ',
HUMPEN1(11)='humpn\${REG}\${MEM}11\${LABELI} '
&END
$(cat ${HOME_suite}/include/${RESOL}${NIVEL}/umipert_eof.nml)
&PARMET
IINF=\${II},ISUP=\${IS},IMAX0=\${NI},
JINF=\${JI},JSUP=\${JS},JMAX0=\${NJ},
IIPS=\${IIPS},ISPS=\${ISPS},JIPS=\${JIPS},JSPS=\${JSPS}
&END
EOT1
cd \${HOME_suite}/eof/bin/\${TRUNC}\${LEV}/
${SCRIPTRUNCMD} \${DK_suite_exe}/eof/bin/\${TRUNC}\${LEV}/eofhum.\${TRUNC}\${LEV} < ${DK_suite}/eof/datain/eofhum\${REG}\${MEM}.nml > ${DK_suite}/eof/dataout/eofhum-\${MEM}.\${REG}.${LABELI}.\${HOUR}.\${TRUNC}\${LEV}
fi
cd ${DK_suite}/eof/datain
cat <<EOT1 > eofwin\${REG}\${MEM}.nml
&DATAIN
DIRI='${DK_suite}/eof/datain/ '
DIRA='${DK_suite}/model/datain/ '
DIRO='${DK_suite}/eof/dataout/${RESOL}${NIVEL}/ '
NAMEL='templ\${REG}\${MEM}\${LABELI} '
ANAME='GANL${PREF}\${LABELI}\${ext}.${RESOL}${NIVEL} '
WINOUT='winout\${REG}\${MEM}\${LABELI} '
WINPCM='winpcm\${REG}\${MEM}\${LABELI} '
&END
&WINPER
WINPER1(1)='winpe\${REG}\${MEM}1\${LABELI} ',
WINPER1(2)='winpe\${REG}\${MEM}2\${LABELI} ',
WINPER1(3)='winpe\${REG}\${MEM}3\${LABELI} ',
WINPER1(4)='winpe\${REG}\${MEM}4\${LABELI} ',
WINPER1(5)='winpe\${REG}\${MEM}5\${LABELI} ',
WINPER1(6)='winpe\${REG}\${MEM}6\${LABELI} ',
WINPER1(7)='winpe\${REG}\${MEM}7\${LABELI} ',
WINPER1(8)='winpe\${REG}\${MEM}8\${LABELI} ',
WINPER1(9)='winpe\${REG}\${MEM}9\${LABELI} ',
WINPER1(10)='winpe\${REG}\${MEM}10\${LABELI} ',
WINPER1(11)='winpe\${REG}\${MEM}11\${LABELI} '
&END
&WINPEN
WINPEN1(1)='winpn\${REG}\${MEM}1\${LABELI} ',
WINPEN1(2)='winpn\${REG}\${MEM}2\${LABELI} ',
WINPEN1(3)='winpn\${REG}\${MEM}3\${LABELI} ',
WINPEN1(4)='winpn\${REG}\${MEM}4\${LABELI} ',
WINPEN1(5)='winpn\${REG}\${MEM}5\${LABELI} ',
WINPEN1(6)='winpn\${REG}\${MEM}6\${LABELI} ',
WINPEN1(7)='winpn\${REG}\${MEM}7\${LABELI} ',
WINPEN1(8)='winpn\${REG}\${MEM}8\${LABELI} ',
WINPEN1(9)='winpn\${REG}\${MEM}9\${LABELI} ',
WINPEN1(10)='winpn\${REG}\${MEM}10\${LABELI} ',
WINPEN1(11)='winpn\${REG}\${MEM}11\${LABELI} '
&END
&PRSSER
PRSSER1(1)='prsse\${REG}\${MEM}1\${LABELI} ',
PRSSER1(2)='prsse\${REG}\${MEM}2\${LABELI} ',
PRSSER1(3)='prsse\${REG}\${MEM}3\${LABELI} ',
PRSSER1(4)='prsse\${REG}\${MEM}4\${LABELI} ',
PRSSER1(5)='prsse\${REG}\${MEM}5\${LABELI} ',
PRSSER1(6)='prsse\${REG}\${MEM}6\${LABELI} ',
PRSSER1(7)='prsse\${REG}\${MEM}7\${LABELI} ',
PRSSER1(8)='prsse\${REG}\${MEM}8\${LABELI} ',
PRSSER1(9)='prsse\${REG}\${MEM}9\${LABELI} ',
PRSSER1(10)='prsse\${REG}\${MEM}10\${LABELI} ',
PRSSER1(11)='prsse\${REG}\${MEM}11\${LABELI} '
&END
&PRSSEN
PRSSEN1(1)='prssn\${REG}\${MEM}1\${LABELI} ',
PRSSEN1(2)='prssn\${REG}\${MEM}2\${LABELI} ',
PRSSEN1(3)='prssn\${REG}\${MEM}3\${LABELI} ',
PRSSEN1(4)='prssn\${REG}\${MEM}4\${LABELI} ',
PRSSEN1(5)='prssn\${REG}\${MEM}5\${LABELI} ',
PRSSEN1(6)='prssn\${REG}\${MEM}6\${LABELI} ',
PRSSEN1(7)='prssn\${REG}\${MEM}7\${LABELI} ',
PRSSEN1(8)='prssn\${REG}\${MEM}8\${LABELI} ',
PRSSEN1(9)='prssn\${REG}\${MEM}9\${LABELI} ',
PRSSEN1(10)='prssn\${REG}\${MEM}10\${LABELI} ',
PRSSEN1(11)='prssn\${REG}\${MEM}11\${LABELI} '
&END
&TEMPER
TEMPER1(1)='tempe\${REG}\${MEM}1\${LABELI} ',
TEMPER1(2)='tempe\${REG}\${MEM}2\${LABELI} ',
TEMPER1(3)='tempe\${REG}\${MEM}3\${LABELI} ',
TEMPER1(4)='tempe\${REG}\${MEM}4\${LABELI} ',
TEMPER1(5)='tempe\${REG}\${MEM}5\${LABELI} ',
TEMPER1(6)='tempe\${REG}\${MEM}6\${LABELI} ',
TEMPER1(7)='tempe\${REG}\${MEM}7\${LABELI} ',
TEMPER1(8)='tempe\${REG}\${MEM}8\${LABELI} ',
TEMPER1(9)='tempe\${REG}\${MEM}9\${LABELI} ',
TEMPER1(10)='tempe\${REG}\${MEM}10\${LABELI} ',
TEMPER1(11)='tempe\${REG}\${MEM}11\${LABELI} '
&END
&TEMPEN
TEMPEN1(1)='tempn\${REG}\${MEM}1\${LABELI} ',
TEMPEN1(2)='tempn\${REG}\${MEM}2\${LABELI} ',
TEMPEN1(3)='tempn\${REG}\${MEM}3\${LABELI} ',
TEMPEN1(4)='tempn\${REG}\${MEM}4\${LABELI} ',
TEMPEN1(5)='tempn\${REG}\${MEM}5\${LABELI} ',
TEMPEN1(6)='tempn\${REG}\${MEM}6\${LABELI} ',
TEMPEN1(7)='tempn\${REG}\${MEM}7\${LABELI} ',
TEMPEN1(8)='tempn\${REG}\${MEM}8\${LABELI} ',
TEMPEN1(9)='tempn\${REG}\${MEM}9\${LABELI} ',
TEMPEN1(10)='tempn\${REG}\${MEM}10\${LABELI} ',
TEMPEN1(11)='tempn\${REG}\${MEM}11\${LABELI} '
&END
&HUMPER
HUMPER1(1)='humpe\${REG}\${MEM}1\${LABELI} ',
HUMPER1(2)='humpe\${REG}\${MEM}2\${LABELI} ',
HUMPER1(3)='humpe\${REG}\${MEM}3\${LABELI} ',
HUMPER1(4)='humpe\${REG}\${MEM}4\${LABELI} ',
HUMPER1(5)='humpe\${REG}\${MEM}5\${LABELI} ',
HUMPER1(6)='humpe\${REG}\${MEM}6\${LABELI} ',
HUMPER1(7)='humpe\${REG}\${MEM}7\${LABELI} ',
HUMPER1(8)='humpe\${REG}\${MEM}8\${LABELI} ',
HUMPER1(9)='humpe\${REG}\${MEM}9\${LABELI} ',
HUMPER1(10)='humpe\${REG}\${MEM}10\${LABELI} ',
HUMPER1(11)='humpe\${REG}\${MEM}11\${LABELI} '
&END
&HUMPEN
HUMPEN1(1)='humpn\${REG}\${MEM}1\${LABELI} ',
HUMPEN1(2)='humpn\${REG}\${MEM}2\${LABELI} ',
HUMPEN1(3)='humpn\${REG}\${MEM}3\${LABELI} ',
HUMPEN1(4)='humpn\${REG}\${MEM}4\${LABELI} ',
HUMPEN1(5)='humpn\${REG}\${MEM}5\${LABELI} ',
HUMPEN1(6)='humpn\${REG}\${MEM}6\${LABELI} ',
HUMPEN1(7)='humpn\${REG}\${MEM}7\${LABELI} ',
HUMPEN1(8)='humpn\${REG}\${MEM}8\${LABELI} ',
HUMPEN1(9)='humpn\${REG}\${MEM}9\${LABELI} ',
HUMPEN1(10)='humpn\${REG}\${MEM}10\${LABELI} ',
HUMPEN1(11)='humpn\${REG}\${MEM}11\${LABELI} '
&END
$(cat ${HOME_suite}/include/${RESOL}${NIVEL}/uvelpert_eof.nml)
$(cat ${HOME_suite}/include/${RESOL}${NIVEL}/vvelpert_eof.nml)
&HUMIDI
HUM='${HUMID}'
&END
&PARMET
IINF=\${II},ISUP=\${IS},IMAX0=\${NI},
JINF=\${JI},JSUP=\${JS},JMAX0=\${NJ},
IIPS=\${IIPS},ISPS=\${ISPS},JIPS=\${JIPS},JSPS=\${JSPS}
&END
EOT1
cd \${HOME_suite}/eof/bin/\${TRUNC}\${LEV}/
${SCRIPTRUNCMD} \${DK_suite_exe}/eof/bin/\${TRUNC}\${LEV}/eofwin.\${TRUNC}\${LEV} < ${DK_suite}/eof/datain/eofwin\${REG}\${MEM}.nml > ${DK_suite}/eof/dataout/eofwin-\${MEM}.\${REG}.${LABELI}.\${HOUR}.\${TRUNC}\${LEV}
done
touch ${monitor}
EOT0
chmod +x ${HOME_suite}/run/${SCRIPTSFILE}
job_eof=$(${SCRIPTRUNJOB} ${HOME_suite}/run/${SCRIPTSFILE})
echo "eof ${job_eof_id}"
until [ -e ${monitor} ]; do sleep 1s; done
