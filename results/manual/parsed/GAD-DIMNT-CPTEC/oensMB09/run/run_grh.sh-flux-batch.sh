#!/bin/bash
#FLUX: --job-name=stinky-leopard-6256
#FLUX: --queue=${QUEUE}
#FLUX: -t=14400
#FLUX: --urgency=16

export FILEENV='$(find ./ -name EnvironmentalVariablesMCGA -print)'
export PATHENV='$(dirname ${FILEENV})'
export PATHBASE='$(cd ${PATHENV}; cd ; pwd)'
export RESOL='${TRCLV:0:6}'
export NIVEL='${TRCLV:6:4}'
export ROPERM='${DK_suite}/produtos'
export TMEAN='3600'
export SCRIPTFILEPATH1='${HOME_suite}/run/setgrh${ANLTYPE}.${DIRRESOL}.${LABELI}.${MAQUI}'
export SCRIPTFILEPATH2='${HOME_suite}/run/setgrh_figs${ANLTYPE}.${DIRRESOL}.${LABELI}.${MAQUI}'
export NAMELISTFILEPATH='${HOME_suite}/run'
export EXECFILEPATH='${DK_suite}/produtos/grh/exec'
export PATHMAIN='${DK_suite}'
export PBS_SERVER='${pbs_server2}'
export KMP_STACKSIZE='128m'
export job_model_id='$(echo ${job_model} | awk -F " " '{print $4}')'
export GRHDATAOUT='${DK_suite}/produtos/grh/gif/${LABELI}'
export name='GFGNNMC'
export ext='$(echo ${TRC} ${LV} |awk '{ printf("TQ%4.4dL%3.3d\n",$1,$2)  }')'
export ps='psuperf #reduzida'
export DATE='$(echo $LABELI | cut -c1-8)'
export HH='$(echo $LABELI | cut -c9-10)'
export DATEF='$(echo $LABELF | cut -c1-8)'
export HHF='$(echo $LABELF | cut -c9-10)'
export labelr='\$(date -d "\${DATE} \${HH}:00 12 hour ago" +"%Y%m%d%H")'
export julday1='\$(date -d "\${DATE} \${HH}:00" +"%j")'
export julday2='\$(date -d "\${DATEF} \${HHF}:00" +"%j")'
export ndays='\$(echo \${julday2} \${julday1} |awk '{{nday=\$1-\$2}if(nday < 0){nday = \$1 + (365-\$2)} if(nday >7){nday=7} {print nday}}')'

if [ "${1}" = "help" -o -z "${1}" ]
then
  cat < ${0} | sed -n '/^#BOP/,/^#EOP/p'
  exit 0
fi
cria_namelist() {
sed -e "s;#TRUNC#;${1};g" \
    -e "s;#LEV#;${2};g" \
    -e "s;#TIMESTEP#;${3};g" \
    -e "s;#TMEAN#;${4};g" \
    -e "s;#LABELI#;${5};g" \
    -e "s;#LABELF#;${6};g" \
    -e "s;#NMEM#;${7};g" \
    -e "s;#PATHIN#;${8};g" \
    -e "s;#PATHOUT#;${9};g" \
    -e "s;#PATHMAIN#;${10};g" \
    ${11}/PostGridHistory.nml.template > ${12}/PostGridHistory.nml
echo "Namelist criado em: ${12}/PostGridHistory.nml"
}
if [ -z "${1}" ]
then
  echo "MPPWIDTH esta faltando" 
  exit 3
else
  export MPPWIDTH=${1}  
fi
if [ -z "${2}" ]
then
  echo "RESOL esta faltando" 
  exit 3
else
  export RES=${2}  
fi
if [ -z "${3}" ]
then
  echo "LABELI esta faltando" 
  exit 3
else
  export LABELI=${3} 
fi
if [ -z "${4}" ]
then
  echo "LABELF esta faltando" 
  exit 3
else
  export LABELF=${4} 
fi
if [ -z "${5}" ]
then
  echo "ANLTYPE esta faltando" 
  exit 3
else
  export ANLTYPE=${5}  
fi
if [ -z "${6}" ]
then
  echo "ANLPERT esta faltando" 
else
  export ANLPERT=${6}  
fi
export FILEENV=$(find ./ -name EnvironmentalVariablesMCGA -print)
export PATHENV=$(dirname ${FILEENV})
export PATHBASE=$(cd ${PATHENV}; cd ; pwd)
. ${FILEENV} ${RES} ${ANLTYPE}
cd ${HOME_suite}/run
TRC=$(echo ${TRCLV} | cut -c 1-6 | tr -d "TQ0")
LV=$(echo ${TRCLV} | cut -c 7-11 | tr -d "L0")
export RESOL=${TRCLV:0:6}
export NIVEL=${TRCLV:6:4}
if [ ${TRCLV} == "TQ0126L028" ]
then
  export TIMESTEP=600
elif [ ${TRCLV} == "TQ0213L042" ]
then
  export TIMESTEP=360
elif [ ${TRCLV} == "TQ0299L064" ]
then
  export TIMESTEP=200
else
  echo "Erro na resolução ${TRCLV}"
  exit 1
fi
export ROPERM=${DK_suite}/produtos
export TMEAN=3600
DIRRESOL=$(echo ${TRC} ${LV} | awk '{printf("TQ%4.4dL%3.3d\n",$1,$2)}')
MAQUI=$(hostname -s)
export SCRIPTFILEPATH1=${HOME_suite}/run/setgrh${ANLTYPE}.${DIRRESOL}.${LABELI}.${MAQUI}
export SCRIPTFILEPATH2=${HOME_suite}/run/setgrh_figs${ANLTYPE}.${DIRRESOL}.${LABELI}.${MAQUI}
export NAMELISTFILEPATH=${HOME_suite}/run
export EXECFILEPATH=${DK_suite}/produtos/grh/exec
mkdir -p ${EXECFILEPATH}
export PATHMAIN=${DK_suite}
if [ ${ANLTYPE} == CTR -o ${ANLTYPE} == NMC -o ${ANLTYPE} == EIT -o ${ANLTYPE} == EIH ]
then
  PATHIN=${DK_suite}/model/dataout/${DIRRESOL}/${LABELI}/${ANLTYPE}/
  PATHOUT=${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${ANLTYPE}/
  EXECFILEPATH=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}
  mkdir -p ${EXECFILEPATH}/setout 
  ln -sf ${DK_suite}/produtos/grh/exec/PostGridHistory ${EXECFILEPATH}
  cria_namelist ${TRC} ${LV} ${TIMESTEP} ${TMEAN} ${LABELI} ${LABELF} ${ANLTYPE} ${PATHIN} ${PATHOUT} ${PATHMAIN} ${NAMELISTFILEPATH} ${EXECFILEPATH}
  if [ $(echo "$QSUB" | grep qsub) ]
  then
    export PBSDIRECTIVENAME1="#PBS -N GRH${ANLTYPE}"
    export PBSDIRECTIVENAME2="#PBS -N GRH${ANLTYPE}FIGS"
    export PBSOUTFILE1="#PBS -o ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.out"
    export PBSERRFILE1="#PBS -e ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.err"
    export PBSOUTFILE2="#PBS -o ${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.out"
    export PBSERRFILE2="#PBS -e ${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.err"
  else
    export PBSDIRECTIVENAME1="#SBATCH --job-name=GRH${ANLTYPE}"
    export PBSDIRECTIVENAME2="#SBATCH --job-name=GRH${ANLTYPE}FIGS"
    export PBSOUTFILE1="#SBATCH --output=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.out"
    export PBSERRFILE1="#SBATCH --error=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.err"
    export PBSOUTFILE2="#SBATCH --output=${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.out"
    export PBSERRFILE2="#SBATCH --error=${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.err"
  fi
  export PBSDIRECTIVEARRAY=""
  export PBSMEM=""
  export PBSEXECFILEPATH="export EXECFILEPATH=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/"
else
  for MEM in $(seq -f %02g 1 ${ANLPERT})
  do
    export NMEM=${MEM}${ANLTYPE:0:1}
    PATHIN=${DK_suite}/model/dataout/${DIRRESOL}/${LABELI}/${NMEM}/
    PATHOUT=${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${NMEM}/
    EXECFILEPATH=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}
    EXECFILEPATHMEM=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/${NMEM}
    mkdir -p ${EXECFILEPATHMEM}/setout
    ln -sf ${DK_suite}/produtos/grh/exec/PostGridHistory ${EXECFILEPATHMEM}
    cria_namelist ${TRC} ${LV} ${TIMESTEP} ${TMEAN} ${LABELI} ${LABELF} ${NMEM} ${PATHIN} ${PATHOUT} ${PATHMAIN} ${NAMELISTFILEPATH} ${EXECFILEPATHMEM}
    if [ $(echo "$QSUB" | grep qsub) ]
    then
      export PBSDIRECTIVENAME1="#PBS -N GRHENS${ANLTYPE}"
      export PBSDIRECTIVENAME2="#PBS -N GRHENS${ANLTYPE}FIGS"
      export PBSDIRECTIVEARRAY="#PBS -J 1-${ANLPERT}"
      export PBSMEM="export MEM=\$(printf %02g \${PBS_ARRAY_INDEX})"
      export PBSOUTFILE1="#PBS -o ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/${NMEM}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.out"
      export PBSERRFILE1="#PBS -e ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/${NMEM}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.err"
      export PBSOUTFILE2="#PBS -o ${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}_${NMEM}.out"
      export PBSERRFILE2="#PBS -e ${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}_${NMEM}.err"
    else
      export PBSDIRECTIVENAME1="#SBATCH --job-name=GRHENS${ANLTYPE}"
      export PBSDIRECTIVENAME2="#SBATCH --job-name=GRHENS${ANLTYPE}FIGS"
      export PBSDIRECTIVEARRAY="#SBATCH --array=1-${ANLPERT}"
      export PBSMEM="export MEM=\$(printf %02g \${SLURM_ARRAY_TASK_ID})"
      export PBSOUTFILE1="#SBATCH --output=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/${NMEM}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.out"
      export PBSERRFILE1="#SBATCH --error=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/${NMEM}/setout/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}.err"
      export PBSOUTFILE2="#SBATCH --output=${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}_${NMEM}.out"
      export PBSERRFILE2="#SBATCH --error=${DK_suite}/produtos/grh/scripts/Out.grh.${LABELI}.${ANLTYPE}.MPI${MPPWIDTH}_${NMEM}.err"
    fi
    export PBSEXECFILEPATH="export EXECFILEPATH=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/\${MEM}${ANLTYPE:0:1}"
  done
fi
if [ $(echo "$QSUB" | grep qsub) ]
then
  SCRIPTHEADER1="
${PBSDIRECTIVENAME1}
${PBSDIRECTIVEARRAY}
"
  SCRIPTHEADER2="
${PBSDIRECTIVENAME2}
${PBSDIRECTIVEARRAY}
"
  SCRIPTRUNCMD="aprun -n 1 -N 1 -d 1 \${EXECFILEPATH}/PostGridHistory < \${EXECFILEPATH}/PostGridHistory.nml > \${EXECFILEPATH}/setout/Print.grh.${LABELI}.MPI${MPPWIDTH}.log"
  #SCRIPTRUNJOB="qsub -W block=true ${SCRIPTFILEPATH}"
  SCRIPTRUNJOB="qsub -W block=true "
else
  SCRIPTHEADER1="
${PBSOUTFILE1}
${PBSERRFILE1}
${PBSDIRECTIVENAME1}
${PBSDIRECTIVEARRAY}
"
  SCRIPTHEADER2="
${PBSOUTFILE2}
${PBSERRFILE2}
${PBSDIRECTIVENAME2}
${PBSDIRECTIVEARRAY}
"
  if [ $USE_SINGULARITY == true ]
  then          
    SCRIPTRUNCMD="module load singularity ; singularity exec -e --bind ${WORKBIND}:${WORKBIND} ${SIFIMAGE} mpirun -np ${MPPWIDTH} /usr/local/bin/PostGridHistory < \${EXECFILEPATH}/PostGridHistory.nml > \${EXECFILEPATH}/setout/Print.grh.${LABELI}.MPI${MPPWIDTH}.log"
  else
    SCRIPTRUNCMD="mpirun -np ${MPPWIDTH} \${EXECFILEPATH}/PostGridHistory < \${EXECFILEPATH}/PostGridHistory.nml > \${EXECFILEPATH}/setout/Print.grh.${LABELI}.MPI${MPPWIDTH}.log"
  fi        
  #SCRIPTRUNJOB="sbatch ${SCRIPTFILEPATH}"
  SCRIPTRUNJOB="sbatch "
  if [ $USE_INTEL == true ]
  then         
    SCRIPTMODULE="
module purge
module load ohpc
module swap gnu9 intel
module swap openmpi4 impi
module load hwloc
module load phdf5
module load netcdf
module load netcdf-fortran
module swap intel intel/2022.1.0
module list
"
  else
    if [ $USE_SINGULARITY == true ]
    then
      SCRIPTMODULE=""
    else      
      SCRIPTMODULE="
module purge
module load gnu9/9.4.0
module load ucx/1.11.2
module load openmpi4/4.1.1
module load netcdf/4.7.4
module load netcdf-fortran/4.5.3
module load phdf5/1.10.8
module load hwloc
module load libfabric/1.13.0
module list
"
  fi
fi
fi
if [ ${ANLTYPE} == CTR -o ${ANLTYPE} == NMC -o ${ANLTYPE} == EIT -o ${ANLTYPE} == EIH ]
then
  if [ -e ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/monitor.t ]
  then 
    rm ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/monitor.t
  fi
else
  for mem in $(seq 1 ${ANLPERT})
  do
    if [ -e ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/0${mem}${ANLTYPE:0:1}/monitor.t ]
    then 
      rm ${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/0${mem}${ANLTYPE:0:1}/monitor.t
    fi
  done        
fi        
if [ -e ${EXECFILEPATH}/monitor.t ]; then rm ${EXECFILEPATH}/monitor.t; fi
cat <<EOF0 > ${SCRIPTFILEPATH1}
${SCRIPTHEADER1}
${SCRIPTMODULE}
export PBS_SERVER=${pbs_server2}
${PBSMEM}
${PBSEXECFILEPATH}
mkdir -p \${EXECFILEPATH}/setout
cd \${EXECFILEPATH}
if [[ Linux == "Linux" || Linux == "linux" ]]
then
  export F_UFMTENDIAN=10,20,30,40,50,60,70,80
  export GFORTRAN_CONVERT_UNIT=big_endian:10,20,30,40,50,60,70,80
fi
export KMP_STACKSIZE=128m
ulimit -s unlimited
${SCRIPTRUNCMD}
touch \${EXECFILEPATH}/monitor.t
EOF0
mkdir -p ${ROPERM}/grh/dataout/${RES}/${LABELI}/
chmod +x ${SCRIPTFILEPATH1}
job_model=$(${SCRIPTRUNJOB} ${SCRIPTFILEPATH1})
export job_model_id=$(echo ${job_model} | awk -F " " '{print $4}')
echo "grh ${job_model_id}"
if [ ${ANLTYPE} == CTR -o ${ANLTYPE} == NMC -o ${ANLTYPE} == EIT -o ${ANLTYPE} == EIH ]
then
  EXECFILEPATH=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}
  until [ -e ${EXECFILEPATH}/monitor.t ]; do sleep 1s; done
else
  for MEM in $(seq -f %02g 1 ${ANLPERT})
  do
    EXECFILEPATHMEM=${DK_suite}/produtos/grh/exec_${LABELI}.${ANLTYPE}/${MEM}${ANLTYPE:0:1}
    until [ -e ${EXECFILEPATHMEM}/monitor.t ]; do sleep 1s; done
  done
fi
if [ $(echo "$QSUB" | grep qsub) ]
then
  if [ ${ANLTYPE} != CTR -a ${ANLTYPE} != NMC -a ${ANLTYPE} != EIT -a ${ANLTYPE} != EIH ]
  then
    JOBID=$(cat ${HOME_suite}/run/this.job.${LABELI}.${ANLTYPE} | awk -F "[" '{print $1}')
    for mem in $(seq 1 ${ANLPERT})
    do
      jobidname="BAMENS${ANLTYPE}.o${JOBID}.${mem}"
      bamoutname="Out.grh.${LABELI}.MPI${MPPWIDTH}.${mem}.out"
      until [ -e "${HOME_suite}/run/${jobidname}" ]; do sleep 1s; done
      mv -v ${HOME_suite}/run/${jobidname} ${EXECFILEPATH}/setout/${bamoutname}
    done
  else
    JOBID=$(cat ${HOME_suite}/run/this.job.${LABELI}.${ANLTYPE} | awk -F "." '{print $1}')
    jobidname="BAM${ANLTYPE}.o${JOBID}"
    bamoutname="Out.grh.${LABELI}.MPI${MPPWIDTH}.out"
    until [ -e "${HOME_suite}/run/${jobidname}" ]; do sleep 1s; done 
    mv -v ${HOME_suite}/run/${jobidname} ${EXECFILEPATH}/setout/${bamoutname}
  fi
  rm ${HOME_suite}/run/this.job.${LABELI}.${ANLTYPE}
fi
if [ ${ANLTYPE} == CTR -o ${ANLTYPE} == NMC -o ${ANLTYPE} == EIT -o ${ANLTYPE} == EIH ]
then
  ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${ANLTYPE}/GFGN${ANLTYPE}${LABELI}${LABELF}M.grh.TQ0126L028.ctl ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/GFGN${ANLTYPE}${LABELI}${LABELF}M.grh.TQ0126L028.ctl
  ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${ANLTYPE}/GFGN${ANLTYPE}${LABELI}${LABELF}M.grh.TQ0126L028 ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/GFGN${ANLTYPE}${LABELI}${LABELF}M.grh.TQ0126L028
  ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${ANLTYPE}/Preffix${LABELI}${LABELF}.${DIRRESOL} ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/Preffix${ANLTYPE}${LABELI}${LABELF}.${DIRRESOL}
  ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${ANLTYPE}/Localiz${LABELI}${LABELF}.${DIRRESOL} ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/Localiz${ANLTYPE}${LABELI}${LABELF}.${DIRRESOL}
  ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${ANLTYPE}/Identif${LABELI}${LABELF}.${DIRRESOL} ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/Identif${ANLTYPE}${LABELI}${LABELF}.${DIRRESOL}
else
  for MEM in $(seq -f %02g 1 ${ANLPERT})
  do
    export NMEM=${MEM}${ANLTYPE:0:1}
    ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${NMEM}/GFGN${NMEM}${LABELI}${LABELF}M.grh.${DIRRESOL}.ctl ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/GFGN${NMEM}${LABELI}${LABELF}M.grh.${DIRRESOL}.ctl
    ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${NMEM}/GFGN${NMEM}${LABELI}${LABELF}M.grh.${DIRRESOL} ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/GFGN${NMEM}${LABELI}${LABELF}M.grh.${DIRRESOL}
    ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${NMEM}/Preffix${LABELI}${LABELF}.${DIRRESOL} ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/Preffix${NMEM}${LABELI}${LABELF}.${DIRRESOL}
    ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${NMEM}/Localiz${LABELI}${LABELF}.${DIRRESOL} ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/Localiz${NMEM}${LABELI}${LABELF}.${DIRRESOL}
    ln -sf ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/${NMEM}/Identif${LABELI}${LABELF}.${DIRRESOL} ${DK_suite}/pos/dataout/${DIRRESOL}/${LABELI}/Identif${NMEM}${LABELI}${LABELF}.${DIRRESOL}
  done
fi
if [ ${ANLTYPE} == CTR -o ${ANLTYPE} == NMC -o ${ANLTYPE} == EIT -o ${ANLTYPE} == EIH ]
then
  if [ -e ${DK_suite}/produtos/grh/dataout/TQ0126L028/${LABELI}/monitor.t ]; then rm ${DK_suite}/produtos/grh/dataout/TQ0126L028/${LABELI}/monitor.t; fi
cat <<EOF1 > ${SCRIPTFILEPATH2}
${SCRIPTHEADER2}
export GRHDATAOUT=${DK_suite}/produtos/grh/gif/${LABELI}
mkdir -p \${GRHDATAOUT}/AC/; mkdir -p \${GRHDATAOUT}/AL/; mkdir -p \${GRHDATAOUT}/AM/;
mkdir -p \${GRHDATAOUT}/AP/; mkdir -p \${GRHDATAOUT}/BA/; mkdir -p \${GRHDATAOUT}/CE/;
mkdir -p \${GRHDATAOUT}/DF/; mkdir -p \${GRHDATAOUT}/ES/; mkdir -p \${GRHDATAOUT}/GO/;
mkdir -p \${GRHDATAOUT}/MA/; mkdir -p \${GRHDATAOUT}/MG/; mkdir -p \${GRHDATAOUT}/MS/;
mkdir -p \${GRHDATAOUT}/MT/; mkdir -p \${GRHDATAOUT}/PA/; mkdir -p \${GRHDATAOUT}/PB/;
mkdir -p \${GRHDATAOUT}/PE/; mkdir -p \${GRHDATAOUT}/PI/; mkdir -p \${GRHDATAOUT}/PR/;
mkdir -p \${GRHDATAOUT}/RJ/; mkdir -p \${GRHDATAOUT}/RN/; mkdir -p \${GRHDATAOUT}/RO/;
mkdir -p \${GRHDATAOUT}/RR/; mkdir -p \${GRHDATAOUT}/RS/; mkdir -p \${GRHDATAOUT}/SC/;
mkdir -p \${GRHDATAOUT}/SE/; mkdir -p \${GRHDATAOUT}/SP/; mkdir -p \${GRHDATAOUT}/TO/;
mkdir -p \${GRHDATAOUT}/WW/; mkdir -p \${GRHDATAOUT}/ZZ/;
DATE=$(echo ${LABELI} | cut -c 1-8)
HH=$(echo ${LABELI} | cut -c 9-10)
DATEF=$(echo ${LABELF} | cut -c 1-8)
HHF=$(echo ${LABELF} | cut -c 9-10)
time1=\$(date -d "\${DATE} \${HH}:00" +"%HZ%d%b%Y")
time2=\$(date -d "\${DATEF} \${HHF}:00" +"%HZ%d%b%Y")
echo "LABELI = ${LABELI}   LABELF = ${LABELF}   LABELR = \${labelr}"
echo "PARAMETROS GRADS ==> ${LABELI} ${LABELF} \${name} \${ext} \${ps} \${labelr}"
cd \${GRHDATAOUT}
rm -f \${GRHDATAOUT}/umrs_min??????????.txt
export name=GFGNNMC
export ext=$(echo ${TRC} ${LV} |awk '{ printf("TQ%4.4dL%3.3d\n",$1,$2)  }')
export ps=psuperf #reduzida
export DATE=$(echo $LABELI | cut -c1-8)
export HH=$(echo $LABELI | cut -c9-10)
export DATEF=$(echo $LABELF | cut -c1-8)
export HHF=$(echo $LABELF | cut -c9-10)
export labelr=\$(date -d "\${DATE} \${HH}:00 12 hour ago" +"%Y%m%d%H")
export julday1=\$(date -d "\${DATE} \${HH}:00" +"%j")
export julday2=\$(date -d "\${DATEF} \${HHF}:00" +"%j")
export ndays=\$(echo \${julday2} \${julday1} |awk '{{nday=\$1-\$2}if(nday < 0){nday = \$1 + (365-\$2)} if(nday >7){nday=7} {print nday}}')
echo "${LABELI} ${LABELF} \${name} \${ext} \${ps} \${labelr}"
mkdir -p ${HOME_suite}/produtos/grh/scripts
DATE=$(echo ${LABELI} | cut -c 1-8)
HH=$(echo ${LABELI} | cut -c 9-10)
DATEF=$(echo ${LABELF} | cut -c 1-8)
HHF=$(echo ${LABELF} | cut -c 9-10)
time1=\$(date -d "\$DATE \$HH:00" +"%HZ%d%b%Y")
time2=\$(date -d "\$DATEF \$HHF:00" +"%HZ%d%b%Y")
echo ${LABELI} ${LABELF} \${name} \${ext} \${ps} \${labelr}
echo \${time1} \${time2}
if [ $GSSTEP = 1 ]
then
echo "plot_meteogr.gs ${LABELI} ${LABELF} \${name} \${ext} \${ps} \${labelr} \${time1} \${time2} ${DK_suite}/pos/dataout ${ROPERM}/grh/gif ${convert}"
${DIRGRADS}/grads -bp  << EOT1
run ${HOME_suite}/produtos/grh/scripts/plot_meteogr.gs
${LABELI} ${LABELF} \${name} \${ext} \${ps} \${labelr} \${time1} \${time2} ${DK_suite}/pos/dataout ${ROPERM}/grh/gif ${convert}
EOT1
fi
if [ ${ANLTYPE} == NMC ]
then
  touch ${ROPERM}/grh/dataout/${RES}/${LABELI}/monitor_nmc.t
else
  touch ${ROPERM}/grh/dataout/${RES}/${LABELI}/monitor.t
fi
EOF1
chmod +x ${SCRIPTFILEPATH2}
${SCRIPTRUNJOB} ${SCRIPTFILEPATH2}
while [ ! -e ${ROPERM}/grh/dataout/${RES}/${LABELI}/monitor_nmc.t ]; do sleep 1s; done
fi
if [ ${SEND_TO_FTP} == true ]
then
  cd ${ROPERM}/grh/gif/${LABELI}/
  #cd ${DK_suite}/produtos/grh/gif/${LABELI}/
  find . -name "*.png" > list.txt
  rsync -arv * ${FTP_ADDRESS}/grh/${LABELI}/
fi
