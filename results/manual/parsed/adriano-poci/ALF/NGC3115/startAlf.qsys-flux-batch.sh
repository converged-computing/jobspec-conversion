#!/bin/bash
#FLUX: --job-name="alf_NGC3115_SN100_aperture"
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export ALF_HOME='/fred/oz059/poci/alf/'

source ${HOME}/.bashrc
module load gcc/9.2.0
module load openmpi/4.0.2
module load python/3.10.4
module load anaconda3/2021.05
export ALF_HOME=/fred/oz059/poci/alf/
cd ${ALF_HOME}src
cp alf.perm.f90 alf.f90
sed -i "/prlo%velz = -999./d" alf.f90
sed -i "/prhi%velz = 999./d" alf.f90
make all && make clean
cd ${ALF_HOME}
mpirun --oversubscribe -np ${SLURM_CPUS_PER_TASK} ./bin/alf.exe "NGC3115_SN100_aperture" 2>&1 | tee -a "NGC3115/out_aperture.log"
Ipy='ipython --pylab --pprint --autoindent'
galax='NGC3115'
SN=100
pythonOutput=$($Ipy alf_aperRead.py -- -g "$galax" -sn "$SN")
echo "$pythonOutput" 2>&1 | tee -a "NGC3115/out_aperture.log"
readarray -t tmp <<< $(echo "$pythonOutput" | tail -n1)
IFS=',' read -ra aperKin <<< "$tmp"
echo "${aperKin[*]}" 2>&1 | tee -a "NGC3115/out_aperture.log"
cd src
cp alf.perm.f90 alf.f90
newVLo=$(bc -l <<< "(${aperKin[0]} - ${aperKin[1]}) - 5.0 * (${aperKin[2]} + ${aperKin[3]})")
newVHi=$(bc -l <<< "(${aperKin[0]} + ${aperKin[1]}) + 5.0 * (${aperKin[2]} + ${aperKin[3]})")
sed -i "s/prlo%velz = -999./prlo%velz = ${newVLo}/g" alf.f90
sed -i "s/prhi%velz = 999./prhi%velz = ${newVHi}/g" alf.f90
sed -i "s/velz = 999/velz = ${aperKin[0]}/g" ${ALF_HOME}NGC3115/alf_replace.sed
sed -n -f ${ALF_HOME}NGC3115/alf_replace.sed alf.f90 >> alf_tmp.f90
mv alf_tmp.f90 alf.f90
make all && make clean
cd ${ALF_HOME}
mkdir NGC3115/bin
cp bin/* NGC3115/bin/
find "NGC3115" -name "alf*.qsys" -type f -exec sbatch {} \;
