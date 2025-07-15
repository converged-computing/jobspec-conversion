#!/bin/bash
#FLUX: --job-name=loopy-squidward-1982
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 256'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 256"
set -x
set -e
ls -lrt
for ECH in '001' '002' '003' '004' '005' '006' '007' '008' '009' '010' 
do
cat > DIAG1.nam << EOF
&NAM_CONFIO LCDF4=T LLFIOUT=T LLFIREAD=T / 
&NAM_DIAG 
  CISO='PREVTK',
  LVAR_RS=T,
  LMSLP=T, LRADAR=T,
  LDIAG(:)=.FALSE. /
&NAM_DIAG_FILE  YINIFILE(1)= "REFid.1.D70Ca.${ECH}",
                YINIFILEPGD(1)="PGD_mer04km",
                YSUFFIX = "type" /
&NAM_DIAG_SURFn N2M=2, LSURF_BUDGET=T N2M=2,
                LSURF_BUDGET=T/
&NAM_SEAFLUXn CSEA_FLUX='DIRECT',
              CSEA_ALB='TA96'/
EOF
rm -f REFid.1.D70Ca.${ECH}type.??? 
time ${MPIRUN} DIAG${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_diagA.${ECH}
mv OUTPUT_LISTING1  OUTPUT_LISTING1_diagA.${ECH}
ls -lrt
done
rm -f file_for_xtransfer pipe_name
rm -f DIAG1.nam
ls -lrt
sbatch run_diag2
ja
