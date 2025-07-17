#!/bin/bash
#FLUX: --job-name=LiFePO4.PHtest.1u
#FLUX: -n=16
#FLUX: --queue=AMG-medium
#FLUX: --urgency=16

export PATH='$PATH:/home/d.aksenov/tools/'

cd /home/d.aksenov//LiFePO4/PH///LiFePO4.PHtest.1u/
module load Compiler/Intel/17u8 Q-Ch/VASP/5.4.4_OMC ScriptLang/python/3.6i_2018u3 Q-Ch/Gaussian/16.RevA03
ulimit -s unlimited
export PATH=$PATH:/home/d.aksenov/tools/
touch RUNNING
cp 1.POSCAR POSCAR
python /home/d.aksenov/tools/siman/polaron.py > polaron.log
sleep 20
rm RUNNING
