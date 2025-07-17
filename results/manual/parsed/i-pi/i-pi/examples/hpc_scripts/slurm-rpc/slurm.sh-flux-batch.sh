#!/bin/bash
#FLUX: --job-name=SL-RPC
#FLUX: -t=600
#FLUX: --urgency=16

set -e  # stop on error
NTIME=500
source  <path-to-i-pi-root>/env.sh
IPI_EXE=<path-to-i-pi-root>/bin/i-pi
LMP_EXE=<path-to-lammps-exe>/lmp_mpi
HOST=`echo $HOSTNAME`
echo "IPI NODE ADDRESS IS $HOST"
echo  {"init",$( date )} >> LIST
if [ -f RESTART ]
then
  grep '<step>'  RESTART >> LIST
  # Save the last restart for the case something goes wrong
  cp RESTART RESTART.save
fi
if [ -f EXIT ]
then
	rm EXIT
fi
sed -e "s:<address>.*</address>:<address>$HOST</address>:" input.template-inet.xml > INITIAL.xml
python3 -u ${IPI_EXE} INITIAL.xml | tee log.ipi &
echo "Waiting 10 seconds..."
sleep 10
cd full_sys
  sed -e "s/localhost/${HOST}/g" in.template.lmp > in.lmp
  srun -n 4 ${LMP_EXE} -in in.lmp -screen log.lmp -log none &
cd ..
cd beads
  sed -e "s/localhost/${HOST}/g" in.template.lmp > in.lmp
  srun -n 1 ${LMP_EXE} -in in.lmp -screen log.instance1.lmp -log none &
  srun -n 1 ${LMP_EXE} -in in.lmp -screen log.instance2.lmp -log none &
  srun -n 1 ${LMP_EXE} -in in.lmp -screen log.instance3.lmp -log none &
  srun -n 1 ${LMP_EXE} -in in.lmp -screen log.instance4.lmp -log none &
cd ..
cd contracted
  sed -e "s/localhost/${HOST}/g" in.template.lmp > in.lmp
  srun -n 1 ${LMP_EXE} -in in.lmp -screen log.lmp -log none &
cd ..
wait
sleep 2
grep '<step>'  RESTART >> LIST
echo  {"Final and restart",$( date )} >> LIST
echo '1' >> count
l=`cat count|wc -l`
if [ ! -d IPI_LOGS ]
then
    mkdir IPI_LOGS
fi
cp -p log.ipi IPI_LOGS/log.ipi_$l
if [ ! -f "STOP"   ]
    then
        echo "Resubmit: YES" >> LIST
    else
        echo "Stop file is found." >> LIST
fi
