#!/bin/bash
#FLUX: --job-name=rainbow-noodle-4955
#FLUX: -n=24
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --urgency=16

ntrain=
ntest=
reptype=
date
hostname
here=`pwd` 
DATE=`date +%d-%m-%y`                               #name the folder in the scratch  
random=`date +%s | sha256sum | base64 | head -c30` 
work="./work/${reptype}/${ntrain}/${ntest}" 
mkdir -p $work 
cp -r ../mp-spdz-0.2.5 $work
data_dir=${work}/mp-spdz-0.2.5/Player-Data
mkdir $data_dir
source_dir=${work}/mp-spdz-0.2.5/Programs/Source/
model_dir=${here}/input/data_${reptype}
echo $model_dir
echo ${data_dir}
cp ${work}/mp-spdz-0.2.5/bin/Linux-amd64/mascot-party.x ${work}/mp-spdz-0.2.5
cp CM_${reptype}.mpc ${source_dir}/CM_${reptype}.mpc
sed -i "/ntrain =/c\ntrain = ${ntrain}"  ${source_dir}/CM_${reptype}.mpc
touch ${data_dir}/Input-P0-0
touch ${data_dir}/Input-P1-0
cat ${model_dir}/train/MODEL_${ntrain}  > ${data_dir}/Input-P0-0
echo "TEST POINT" ${ntest}
sed -i "/testid =/c\testid = ${ntest}"  ${source_dir}/CM_${reptype}.mpc
cat ${model_dir}/test/X_QUERY_${ntest}  > ${data_dir}/Input-P1-0
cd ${work}/mp-spdz-0.2.5
./compile.py CM_${reptype}.mpc
sleep 3
touch out
./Scripts/mascot.sh CM_${reptype} >> out
sleep 3
echo "PYTHON/TEST"
cat ${model_dir}/test/PRED_${ntrain}_${ntest} >> out
mkdir ${here}/results/${reptype}
cp out ${here}/results/${reptype}/out_${ntrain}_${ntest}
