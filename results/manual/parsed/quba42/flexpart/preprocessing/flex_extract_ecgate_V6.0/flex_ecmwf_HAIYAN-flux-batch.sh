#!/bin/bash
#FLUX: --job-name=flex_ecmwf
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MARS_MULTITARGET_STRICT_FORMAT='1'
export SCRATCHDIR='${SCRATCH}/${JOBNAME}_$$'

set -x
JOBNAME=flex_ecmwf_${HOST}
env
ulimit -a
export OMP_NUM_THREADS=1
export MARS_MULTITARGET_STRICT_FORMAT=1
export SCRATCHDIR=${SCRATCH}/${JOBNAME}_$$
[ -z "$WSHOME" ] && WSHOME=$HOME
mkdir $SCRATCHDIR
cd $SCRATCHDIR
LOG_FILE=$SCRATCHDIR/${JOBNAME}_$$
exec 1>${LOG_FILE}
CONTROLFILE=./CONTROL_ERA
cat <<EOF >CONTROL_ERA
DAY1 20131107
DAY2 20131108
DTIME 3
M_TYPE AN FC FC FC FC FC AN FC FC FC FC FC AN FC FC FC FC FC AN FC FC FC FC FC
M_TIME 00 00 00 00 00 00 06 00 00 00 00 00 12 12 12 12 12 12 18 12 12 12 12 12
M_STEP 00 01 02 03 04 05 00 07 08 09 10 11 00 01 02 03 04 05 00 07 08 09 10 11
M_CLASS OD
M_STREAM OPER
M_NUMBER OFF
M_EXPVER 1
M_GRID 200  
M_LEFT 113000
M_LOWER 00000
M_UPPER 30000
M_RIGHT 190000
M_LEVEL 137
M_RESOL 799
M_GAUSS 0
M_ACCURACY 24
M_OMEGA 0
M_OMEGADIFF 0
M_ETA 1
M_ETADIFF 0
M_DPDETA 1
M_SMOOTH 0
M_FORMAT GRIB1
M_ADDPAR /27/28/173/186/187/188/235/139/39
PREFIX EH
GATEWAY srvx7.img.univie.ac.at
DESTINATION leo@genericSftp
ECSTORAGE 1
ECTRANS 0
ECFSDIR ectmp:/${USER}/econdemand/
MAILOPS ${USER}
MAILFAIL ${USER}
EXEDIR .
SOURCECODE ${WSHOME}/flex_extract_ecgate_V6.0
EOF
NRW=0
juldate2()
   {
    let jc=$1
    if (( ${#jc} < 8 ))
    then
    print "illegal date!"
    exit 1
    fi
    let y=`echo $jc | cut -c1-4`
    let m1=`echo $jc | cut -c5`
    let m2=`echo $jc | cut -c6`
    m=$m1$m2
    let d1=`echo $jc | cut -c7`
    let d2=`echo $jc | cut -c8`
    d=$d1$d2
    let jd=367*y-7*(y+(m+9)/12)/4+275*m/9+d+1721014
    let jd=jd+15-3*((y+(m-9)/7)/100+1)/4
    print $jd
    }
civildate2()
   {
    let jd=$1
    if (( jd < 1721060 ))
    then
       print "Julian date not in AD."
       exit 1
    fi
    let k=jd+68569
    let n=4*k/146097
    let k=k-\(146097*n+3\)/4
    let y=4000*(k+1)/1461001
    let k=k-1461*y/4+31
    let m=80*k/2447
    let d=k-\(2447*m\)/80
    let k=m/11
    let m=m+2-12*k
    let y=100*(n-49)+y+k
    [ $m -le 9 ] && m=0$m
    [ $d -le 9 ] && d=0$d
    print $y$m$d
    }
date2m1()
    {
    let ymd=$1
    let j1=`juldate2 $ymd`
    let j0=j1-1
    civildate2 $j0
    }
date2p1()
    {
    let ymd=$1
    let j1=`juldate2 $ymd`
    let j0=j1+1
    civildate2 $j0
    }
marsinst()
{
MTYPE="${1}"
MDAY="${2}"
MTIME="${3}"
MSTEP="${4}"
MPAR="${5}"
MFN=$6
MLTY=$7
MGRID="${8}"
MLEV="${9}"
RED=0
  MPAR2=`echo ${MPAR} | sed s,160/,,`
  MPAR2=`echo ${MPAR2} | sed s,27/,,`
  MPAR2=`echo ${MPAR2} | sed s,28/,,`
  MPAR2=`echo ${MPAR2} | sed s,173/,,`
  if [[ ${MPAR2} != ${MPAR} ]] ; then
    MPAR=${MPAR2}
    RED=1
  fi
MAREA=${M_AREA}
if [[ ${10} == 'GAUSSIAN=REDUCED,' ]] ; then
  MAREA=G
fi
if [[ -f ${MFN} ]] ; then
  rm ${MFN}
fi
cat <<EOF >> marsjob
RETRIEVE,
TYPE=${MTYPE},
CLASS=${M_CLASS},NUMBER=${M_NUMBER},
EXPVER=${M_EXPVER},STREAM=${M_STREAM},
PARAM=${MPAR},
RESOL=${M_RESOL},
AREA=${MAREA},
GRID=${MGRID},
LEVTYPE=${MLTY},
LEVELIST=${MLEV},
ACCURACY=${M_ACCURACY},
DATE=${MDAY},
TIME=${MTIME},
STEP=${MSTEP},${10}
TARGET="${MFN}"
EOF
if [[ ! -f 'OROLSM' && $RED -eq 1 ]] ; then
cat <<EOF >> marsjob
RETRIEVE,TYPE=AN,TIME=0,STEP=0,CLASS=OD,
  PARAM=160/27/28/173,
  TARGET="OROLSM"
EOF
fi
}
marsflux()
{
MTYPE="${1}"
MSTEP="${2}"
cat <<EOF >>mars_flux
RETRIEVE,
TYPE=${MTYPE},
CLASS=${M_CLASS},NUMBER=${M_NUMBER},
EXPVER=${M_EXPVER},STREAM=${M_STREAM},
PARAM=LSP/CP/SSHF/EWSS/NSSS/SSR,
AREA=${M_AREA},
GRID=${D_GRID},
LEVTYPE=SFC,
LEVELIST=OFF,
ACCURACY=${M_ACCURACY}, REPRES=GG,
DATE=${DAY1M1}/TO/${DAY2P1},
TIME=00/12,
AC=N,
STEP=${MSTEP},
TARGET="surf_${MSTEP}_ub"
EOF
}
myerror()
  {
    echo $1
    echo $2
    echo $3
    echo ABORT!
    for MUSER in $MAILFAIL
    do
      mailx -s ERROR:${JOBNAME} ${MUSER} <${LOG_FILE}
    done
  }
while read NAME PARA
do
if [[ $NAME == 'M_TYPE' || $NAME == 'M_TIME' || $NAME == 'M_STEP' ]] ; then
  eval "set -A $NAME $PARA"
else
  eval "export $NAME='$PARA'"
fi
echo `echo $NAME`=$PARA
done <${CONTROLFILE}
if [ -z "$DAY1" -o -z "$DAY2" ]; then
    myerror 'DAY specification missing !'
    exit 1
fi
[ -z "$M_EXPVER" ] && M_EXPVER=1
[ -z "$M_CLASS" ] && M_CLASS=OD
[ -z "$M_STREAM" ] && M_STREAM=OPER
[ -z "$M_NUMBER" ] && M_NUMBER=OFF
[ -z "$M_TYPE" ] && set -A M_TYPE AN FC FC FC FC FC AN FC FC FC FC FC AN FC FC FC FC FC AN FC FC FC FC FC
[ -z "$M_TIME" ] && set -A M_TIME 00 00 00 00 00 00 06 00 00 00 00 00 12 12 12 12 12 12 18 12 12 12 12 12
[ -z "$M_STEP" ] && set -A M_STEP 00 01 02 03 04 05 00 07 08 09 10 11 00 01 02 03 04 05 00 07 08 09 10 11
[ -z "$DTIME" ] && DTIME=6
[ -z "$M_GRID" ] && M_GRID=1000
[ -z "$M_LOWER" ] && M_LOWER=-90000
[ -z "$M_LEFT" ] && M_LEFT=-179000
[ -z "$M_UPPER" ] && M_UPPER=90000
[ -z "$M_RIGHT" ] && M_RIGHT=180000
[ -z "$M_LEVEL" ] && M_LEVEL=91
[ -z "$M_LEVELIST" ] && M_LEVELIST=1/TO/$M_LEVEL
[ -z "$M_ADDPAR" ] && M_ADDPAR=''
[ -z "$M_RESOL" ] &&  M_RESOL=799
[ -z "$M_GAUSS" ] &&  M_GAUSS=0
[ -z "$M_SMOOTH" ] &&  M_SMOOTH=0
[ -z "$M_OMEGA" ] &&  M_OMEGA=0
[ -z "$M_OMEGADIFF" ] &&  M_OMEGADIFF=0
[ -z "$M_ETA" ] &&  M_ETA=0
[ -z "$M_ETADIFF" ] &&  M_ETADIFF=0
[ -z "$M_ETAPAR" ] &&  M_ETAPAR=77
[ -z "$M_DPDETA" ] &&  M_DPDETA=1
[ -z "$M_ACCURACY" ] &&  M_ACCURACY=24
[ -z "$EXEDIR" ] && EXEDIR=.
[ -z "$SOURCECODE" ] && SOURCECODE=ecgate:flex_extract_ecgate
[ -z "$GATEWAY" ] && GATEWAY=''
[ -z "$DESTINATION" ] && DESTINATION=''
[ -z "$PREFIX" ] && PREFIX=EN
[ -z "$COMPRESSION" ] && COMPRESSION=grid_simple
[ -z "$ECTRANS" ] && ECTRANS=0
[ -z "$ECSTORAGE" ] && ECSTORAGE=1
[ -z "$ECFSDIR" ] && ECFSDIR=ectmp:
[ -z "$MAILOPS" ] && MAILOPS=${USER}
[ -z "$MAILFAIL" ] && MAILFAIL=${USER}
DAY1M1=`date2m1 ${DAY1}`
DAY2P1=`date2p1 ${DAY2}`
JULDAY1=`juldate2 ${DAY1}`
JULDAY2=`juldate2 ${DAY2}`
echo JULDATES $JULDAY1 $JULDAY2
if [ ${DAY1} -gt ${DAY2} ]; then
    `myerror "ERROR: DAY1 > DAY2: ${DAY1}, ${DAY2}"`
    exit 1
fi
ZYK=`expr \( $M_RIGHT + 360000 \) % 360000 - \( $M_LEFT + 360000 \) % 360000 + $M_GRID`
if [ $M_RIGHT -le $M_LEFT ] ; then
  if [ $M_RIGHT -le 0 ] ; then
    M_RIGHT=$(($M_RIGHT+360000))
  else
    M_LEFT=$(($M_LEFT-360000))
  fi
fi
if [[ $ZYK -ne 0 ]] ; then
  MAXB=$((($M_UPPER-($M_LOWER))/$M_GRID+1))
  MAXL=$((($M_RIGHT-($M_LEFT))/$M_GRID+1))
  if [[ $((($M_RIGHT-($M_LEFT))%$M_GRID)) -ne 0 || $((($M_UPPER-($M_LOWER))%$M_GRID)) -ne 0 ]] ; then
    myerror "ERROR: LAT/LON RANGE MUST BE INTEGER MULTIPLES OF GRID SIZE"     "URLO: $M_UPPER  $M_RIGHT $M_LOWER  $M_LEFT GRID: $M_GRID"     "GRID ASSUMED NON-CYCLIC"
    exit 1
  fi
else
  MAXL=$((($M_RIGHT-($M_LEFT))/$M_GRID+1))
  MAXB=$((($M_UPPER-($M_LOWER))/$M_GRID+1))
  if [[ $((($M_RIGHT-($M_LEFT))%$M_GRID)) -ne 0 || $((($M_UPPER-($M_LOWER))%$M_GRID)) -ne 0 ]] ; then
    myerror "ERROR: LAT/LON RANGE MUST BE INTEGER MULTIPLES OF GRID SIZE"           "URLO: $M_UPPER  $M_RIGHT $M_LOWER  $M_LEFT GRID: $M_GRID"           "GRID ASSUMED CYCLIC"
    exit 1
  fi
fi
if [ $((180000/$M_GRID-$M_RESOL)) -lt 0 ] ; then
   if [ ${M_SMOOTH} -eq 0 ] ; then
    myerror "ERROR: OUTPUT GRID SPACING OF $((${M_GRID}/1000)).$((${M_GRID}%1000)) DEGREE IS TOO COARSE FOR GIVEN SPECTRAL RESOLUTION ${M_RESOL} " "USE M_SMOOTH FOR SMOOTHING OR FINER OUTPUT GRID"
   else
    if [ $((180000/$M_GRID-$M_SMOOTH)) -lt 0 ] ; then
      myerror "ERROR: OUTPUT GRID SPACING OF $((${M_GRID}/1000)).$((${M_GRID}%1000)) DEGREE IS TOO COARSE FOR GIVEN SMOOTHED SPECTRAL RESOLUTION ${M_SMOOTH} " 
    fi
   fi
fi
if [[ $M_LEFT -lt 0 ]] ; then
  LLLO=$(($M_LEFT / 1000)).$((($M_LEFT)*(-1) % 1000))
else
  LLLO=$(($M_LEFT / 1000)).$(($M_LEFT % 1000))
fi
if [[ $M_LOWER -lt 0 ]] ; then
  LLLA=$(($M_LOWER / 1000)).$(($M_LOWER*(-1) % 1000))
else
  LLLA=$(($M_LOWER / 1000)).$((($M_LOWER) % 1000))
fi
if [[ $M_RIGHT -lt 0 ]] ; then
  URLO=$(($M_RIGHT / 1000)).$((($M_RIGHT)*(-1) % 1000))
else
  URLO=$(($M_RIGHT / 1000)).$(($M_RIGHT % 1000))
fi
if [[ $M_UPPER -lt 0 ]] ; then
  URLA=$(($M_UPPER / 1000)).$((($M_UPPER)*(-1) % 1000))
else
  URLA=$(($M_UPPER / 1000)).$(($M_UPPER % 1000))
fi
M_AREA=${URLA}/${LLLO}/${LLLA}/${URLO}
if [ $M_GAUSS -eq 1 ] ; then
  D_GRID=$(($M_GRID / 1000)).$(($M_GRID % 1000))
  G_GRID=OFF
  QG_GRID=OFF
  if [ $M_RESOL -le 799 ] ; then
    QG_GRID=$((($M_RESOL+1)/2))
  fi
  D_GRID=${D_GRID}/${D_GRID}
else
  D_GRID=$(($M_GRID / 1000)).$(($M_GRID % 1000))
  G_GRID=$(($M_GRID / 1000)).$(($M_GRID % 1000))
  G_GRID=${G_GRID}/${G_GRID}
  D_GRID=${D_GRID}/${D_GRID}
fi
G_LEVELIST=1/to/${M_LEVEL}
cat <<EOF >fort.4
&NAMGEN
   MAXL=${MAXL}, MAXB=${MAXB},
   MLEVEL=${M_LEVEL}, MLEVELIST="${M_LEVELIST}",
   MNAUF=${M_RESOL},METAPAR=${M_ETAPAR},
   RLO0=${LLLO}, RLO1=${URLO}, RLA0=${LLLA}, RLA1=${URLA},
   MOMEGA=${M_OMEGA},MOMEGADIFF=${M_OMEGADIFF},MGAUSS=${M_GAUSS},
   MSMOOTH=${M_SMOOTH},META=${M_ETA},METADIFF=${M_ETADIFF},
   MDPDETA=${M_DPDETA}
/
&NAMFX2
   NX=${MAXL}, NY=${MAXB},
   MAXTIME=400,JPOLY=4,
   JHRF=${DTIME},
   RLO0=${LLLO}, RLA0=${LLLA}, DX=${D_GRID}, DY=${D_GRID}
/
EOF
if [[ $OS_VERSION == aix ]] ; then
  scp ecgb:${SOURCECODE}/source.tar .
  tar -xvf source.tar
  make -f Makefile.IBM FLXACC2 CONVERT2 CHECK
else
  cp ${SOURCECODE}/source.tar .
  tar -xvf source.tar
  make -f Makefile.ecgb FLXACC2 CONVERT2 CHECK
fi
if [ $? -ne 0 ]; then
   ls
   myerror 'ERROR: FLXACC2 and CONVERT2 could not be compiled:' 'ABORT!'
   exit 1
else
  echo 'compile worked'
fi
imax=6
set -A PARLIST  U/V  T    Q  LNSP SD/MSL/TCC/10U/10V/2T/2D 129/172/160${M_ADDPAR}
set -A PARNAME  131/132 130 133 152 SURF OROLSM
set -A REPR     SH    SH   GG   SH   GG   GG
set -A UNIT     10    11   17   12   14   20
set -A LTY      ML    ML   ML   ML   SFC  SFC
set -A GRID  ${G_GRID} ${D_GRID} ${D_GRID} OFF ${D_GRID} ${D_GRID}
set -A LEVELIST ${M_LEVELIST} ${M_LEVELIST} ${M_LEVELIST} 1 1 1
set -A FIELD    00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 00
if [[ $M_OMEGA -eq 1 || $M_OMEGADIFF -eq 1 ]] ; then
  M_OMEGA=1
  PARLIST[imax]=W
  PARNAME[imax]=135
  REPR[imax]=SH
  UNIT[imax]=19
  LTY[imax]=ML
  GRID[imax]=${D_GRID}
  LEVELIST[imax]=${M_LEVELIST}
  imax=$(($imax+1))
fi
if [[ $M_ETA -eq 1 || $M_ETADIFF -eq 1 ]] ; then
  M_ETA=1
  PARLIST[imax]=77
  PARNAME[imax]=77
  REPR[imax]=SH
  UNIT[imax]=21
  LTY[imax]=ML
  GRID[imax]=${D_GRID}
  LEVELIST[imax]=${M_LEVELIST}
  imax=$(($imax+1))
fi
if [[ $M_GAUSS -eq 2 ]] ; then
  PARLIST[imax]=VO
  PARNAME[imax]=138
  REPR[imax]=SH
  UNIT[imax]=30
  LTY[imax]=ML
  GRID[imax]=${G_GRID}
  LEVELIST[imax]=${G_LEVELIST}
  imax=$(($imax+1))
fi
if [[ $M_ETA -eq 0 || $M_GAUSS -eq 1 || $M_ETADIFF -eq 1 ]] ; then
  PARLIST[imax]=D
  PARNAME[imax]=155
  REPR[imax]=SH
  UNIT[imax]=13
  LTY[imax]=ML
  GRID[imax]=${G_GRID}
  LEVELIST[imax]=${G_LEVELIST}
  LEVELIST[1]=${G_LEVELIST} # U/V needed on all levels for calculating ETA
  imax=$(($imax+1))
fi
jmax=${#M_TYPE[*]}
j=0
while [[ $j -lt $jmax ]] ; do
  if [[ ${M_TIME[$j]} -lt 10 ]] ; then
    M_TIME[$j]=0$((${M_TIME[$j]}))
  fi
  if [[ ${M_STEP[$j]} -lt 10 ]] ; then
    M_STEP[$j]=$((${M_STEP[$j]}))
  fi
  j=$(($j+1))
done
echo ${M_TIME[*]}
echo ${M_STEP[*]}
rm mars_flux 2>/dev/null
j=$DTIME
while [[ $j -lt 13 ]] ; do 
  marsflux ${M_TYPE[2]} ${FIELD[$j]} 
  j=$(($j+$DTIME))
done
mars mars_flux | grep -i -v 'MARS - INFO'
[ $? -ne 0 ] && myerror "Job stopped because of failing MARS request"
${EXEDIR}/FLXACC2
if [ -f OROLSM ] ; then
  rm OROLSM
fi
IJULDAY=${JULDAY1}
while [ $IJULDAY -le $JULDAY2 ];
do
MDATE=`civildate2 ${IJULDAY}`
MDATEX=`echo ${MDATE} | cut -c3-8`
i=0
rm marsjob 2>/dev/null
if [ ${M_GAUSS} -eq 1 ] ; then
  NGRID=$(( ( ${M_RESOL} + 1 ) / 2 ))
  marsinst ${M_TYPE[0]} ${DAY1} 00 00 Q fort.18 ML ${QG_GRID} 1 'GAUSSIAN=REDUCED,'
set -e
mars marsjob | grep -i -v 'MARS - INFO'
[ $? -ne 0 ] && myerror "Job stopped because of failing MARS request"
rm marsjob
fi
set -e
set -A TYPEKEY ${M_TYPE[0]}
j=$DTIME
kmax=0
while [[ $j -lt $jmax ]] ; do
  if [[ ${M_TYPE[j]} != ${TYPEKEY[0]} ]] ; then
    if [[ $kmax == 1 ]] ; then
      if [[ ${M_TYPE[j]} != ${TYPEKEY[1]} ]] ; then 
        set -A TYPEKEY ${TYPEKEY[0]} ${TYPEKEY[1]} ${M_TYPE[j]}
        kmax=2
      fi
    else
      if [[ $kmax == 0 ]] ; then    
      set -A TYPEKEY ${TYPEKEY[0]} ${M_TYPE[j]}
      kmax=1
      else
        if [[ $kmax == 2 && ${M_TYPE[j]} != ${TYPEKEY[1]}  ]] ; then    
          if [[ $kmax == 2 && ${M_TYPE[j]} != ${TYPEKEY[2]}  ]] ; then    
            echo ${TYPEKEY[0]} ${TYPEKEY[1]}  ${TYPEKEY[2]} ${M_TYPE[j]}
            myerror 'More than three different MARS TYPES not supported'
            exit 1
          fi
        fi
      fi
    fi
  fi
  j=$(($j+$DTIME))
done
set -A GRIDKEY $D_GRID
mmax=1
i=0
while [[ $i -lt $imax ]] ; do
  if [[ ${GRID[$i]} == 'OFF' && ${PARLIST[$i]} != LNSP ]] ; then
    set -A GRIDKEY $D_GRID OFF
    mmax=2
  fi 
  i=$(($i+1))
done
k=0
kmax=$(($kmax+1))
while [[ $k -lt $kmax ]] ; do
MMTIME=''
MMSTEP=''
TSUFF=''
SSUFF=''
j=0
while [[ $j -lt $jmax ]] ; do
  if [[ ${M_TYPE[$j]} == ${TYPEKEY[$k]} ]] ; then
    if [[ `echo $MMTIME | grep ${M_TIME[$j]}` == '' ]] ; then
      MMTIME=${MMTIME}$TSUFF${M_TIME[$j]}
      TSUFF='/'
    fi
    if [[ `echo $MMSTEP | grep ${M_STEP[$j]}` == '' ]] ; then
      MMSTEP=${MMSTEP}$SSUFF${M_STEP[$j]}
      SSUFF='/'
    fi
  fi
j=$(($j+$DTIME))
done
m=0
while [[ $m -lt $mmax ]] ; do
MMPAR=''
PSUFF=''
i=0
while [[ $i -lt $imax ]] ; do
  if [[ ${LTY[$i]} == ML && ${GRID[$i]} == ${GRIDKEY[m]} && ${PARLIST[$i]} != LNSP ]] ; then
    if [[ `echo $MMPAR | grep ${PARLIST[$i]}` == '' ]] ; then
      MMPAR=${MMPAR}$PSUFF${PARLIST[$i]}
      PSUFF='/'
    fi
  fi
i=$(($i+1))
done
  marsinst ${TYPEKEY[$k]} ${MDATE} ${MMTIME} ${MMSTEP} $MMPAR "[param].[date].[time].[step]" ML ${GRIDKEY[$m]} ${LEVELIST[$m]}
  mars marsjob | grep -i -v 'MARS - INFO'
  [ $? -ne 0 ] && myerror "Job stopped because of failing MARS request"
  rm marsjob
m=$(($m+1))
done
  marsinst ${TYPEKEY[$k]} ${MDATE} ${MMTIME} ${MMSTEP} LNSP "[param].[date].[time].[step]" ML OFF 1
  mars marsjob | grep -i -v 'MARS - INFO'
  [ $? -ne 0 ] && myerror "Job stopped because of failing MARS request"
  rm marsjob
  set +e
  TNR=`ls 131*${MDATE}.${M_TIME[00]}00.${M_STEP[00]} | awk -F . '{print $2}' - | grep -v ${MDATE}`.
  set -e
  if [[ $TNR != '.' ]] ; then
    TNR=.$TNR
  fi
  marsinst ${TYPEKEY[$k]} ${MDATE} ${MMTIME} ${MMSTEP} ${PARLIST[4]} "SURF${TNR}[date].[time].[step]" SFC $D_GRID OFF
  mars marsjob | grep -i -v 'MARS - INFO'
  [ $? -ne 0 ] && myerror "Job stopped because of failing MARS request"
  rm marsjob
  marsinst ${TYPEKEY[$k]} ${MDATE} ${MMTIME} ${MMSTEP} ${PARLIST[5]} "OROLSM${TNR}[date].[time].[step]" SFC $D_GRID OFF
  mars marsjob | grep -i -v 'MARS - INFO'
  [ $? -ne 0 ] && myerror "Job stopped because of failing MARS request"
  rm marsjob
k=$(($k+1))
done
j=0
while [[ $j -lt $jmax ]] ; do
TIME=${FIELD[j]}
XTIME=${TIME}00
set +e
i=0
while [[ $i -lt $imax ]] ; do 
  \rm fort.${UNIT[$i]} 2>/dev/null
  if [[ ${PARLIST[$i]} == U/V ]] ; then
    cat 131${TNR}${MDATE}.${M_TIME[$j]}00.${M_STEP[$j]} 132${TNR}${MDATE}.${M_TIME[$j]}00.${M_STEP[$j]} > fort.${UNIT[$i]}
    rm  131${TNR}${MDATE}.${M_TIME[$j]}00.${M_STEP[$j]} 132${TNR}${MDATE}.${M_TIME[$j]}00.${M_STEP[$j]}
  else
    mv  ${PARNAME[$i]}${TNR}${MDATE}.${M_TIME[$j]}00.${M_STEP[$j]}  fort.${UNIT[$i]}
  fi
  i=$(($i+1))
done
${EXEDIR}/CONVERT2
INFILE=${PREFIX}${MDATEX}${TIME}
if [ -s fort.15 ]; then
    cp fort.15                   ${INFILE}
    cat fort.14              >>  ${INFILE}
    cat flux${MDATE}${TIME}  >>  ${INFILE}
    cat OROLSM   >>  ${INFILE}
    cat fort.20  >>  ${INFILE}
if [ ${M_FORMAT} == GRIB2 ] ; then
 grib_set -s edition=2,productDefinitionTemplateNumber=8 $INFILE ${INFILE}_2
 mv ${INFILE}_2 ${INFILE}
  if [ ${COMPRESSION} != grid_simple ] ; then
cat >rule.filter<<EOF
set packingType="${COMPRESSION}";
write "[file]_2";
EOF
    grib_filter rule.filter ${INFILE}
    mv ${INFILE}_2 ${INFILE}
  fi
fi
ls -l ${INFILE}
else 
    myerror "ERROR: ENfile ${INFILE} missing!" "ABORT!"
    exit 1
fi
if [ -s fort.25 ]; then
    mv fort.25 OMEGA${MDATEX}${TIME}
    ln -s  OMEGA${MDATEX}${TIME} fort.25
fi
\rm fort.15 2>/dev/null
ln -s ${INFILE} fort.15
[ -s CHECK.SUCCESS ] && rm CHECK.SUCCESS
${EXEDIR}/CHECK
if [ -s CHECK.SUCCESS ]; then
    SUCCESS=1
else
    myerror 'ERROR: check on ENfile failed:' ${INFILE} "ABORT!"
    exit 1
fi
if [ $SUCCESS -eq 1 -a $ECTRANS -eq 1 ] ; then
  ectrans -overwrite -gateway ${GATEWAY} -remote ${DESTINATION} -source $INFILE
fi
if [[ $M_OMEGA -eq 1 && $SUCCESS -eq 1 && $ECTRANS -eq 1 ]] ; then
   ectrans -overwrite -gateway ${GATEWAY} -remote ${DESTINATION} -source OMEGA${MDATEX}${TIME}
fi
if [ $SUCCESS -eq 1 -a $ECSTORAGE -eq 1 ] ; then
 ecp -o $INFILE $ECFSDIR
fi
if [[ $SUCCESS -eq 1 && $ECSTORAGE -eq 1 &&  $M_OMEGA -eq 1 ]] ; then
  ecp -o OMEGA${MDATEX}${TIME} $ECFSDIR
fi
rm ${INFILE}_2 ${INFILE} fort.15  flux${MDATE}${TIME}* OMEGA${MDATEX}${TIME} fort.25
j=$(($j+$DTIME))
done
(( IJULDAY = IJULDAY + 1 ))
done
[ $NRW -gt 0 ] && echo There were $NRW warnings !
for MUSER in $MAILOPS
do
mailx -s ${JOBNAME} ${MUSER} <${LOG_FILE}
done
cd ${SCRATCH}
echo $SCRATCHDIR not removed!
exit 0
