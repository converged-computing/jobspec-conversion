#!/bin/bash
#SBATCH --job-name=LiFePO4.PHtest.1u
#SBATCH --output=/home/d.aksenov//LiFePO4/PH///LiFePO4.PHtest.1u/sbatch.out
#SBATCH --error=/home/d.aksenov//LiFePO4/PH///LiFePO4.PHtest.1u/sbatch.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1

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
