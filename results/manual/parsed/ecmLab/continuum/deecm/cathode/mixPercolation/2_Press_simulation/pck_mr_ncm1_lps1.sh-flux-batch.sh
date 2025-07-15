#!/bin/bash
#FLUX: --job-name=NMC_LPS
#FLUX: -c=4
#FLUX: --queue=tier3
#FLUX: -t=9000
#FLUX: --priority=16

nMdl=1        # number of models studied
iNcm=1        # NMC size studied, iNcm=1 for 5.0um, iNcm=2 for 10um, iNcm=3 for 12um
iLps=2        # LPS size studied, iLps=3 for 3um, iLps=4 for 4um
sxy=50        # area length studied
sz=100         # initial height
for irt in $(seq 1 $nMdl);
do
  sed "s/index000/index ${irt}/" < lmp_mr.in > tmp0.in
  sed "s/iNcm   equal 1/iNcm   equal ${iNcm}/" < tmp0.in > tmp1.in
  sed "s/iLps   equal 3/iLps   equal ${iLps}/" < tmp1.in > tmp2.in
  sed "s/sxy    equal 80/sxy    equal ${sxy}/" < tmp2.in > tmp3.in
  sed "s/sz     equal 83/sz     equal ${sz}/" < tmp3.in > mr.in  
  cp mr.in    massratio/mr${irt}/
  cp myjob.sh massratio/mr${irt}/ 
  cd massratio/mr${irt}/  
  sbatch myjob.sh
  cd ../../
  rm -f mr.in tmp* job*
done
