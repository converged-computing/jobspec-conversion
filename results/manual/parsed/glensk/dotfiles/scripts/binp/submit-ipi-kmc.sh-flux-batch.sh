#!/bin/bash
#FLUX: --job-name=NNP-mpi
#FLUX: -N=2
#FLUX: -n=56
#FLUX: -t=258600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

set +e
source $MODULESHOME/init/bash    # necessary in the case of zsh or other init shells
module load intel intel-mpi intel-mkl fftw python/2.7.14
export OMP_NUM_THREADS=1
sed -i 's/<ffsocket.*/<ffsocket name="lmpserial" mode="inet">/' input-runner.xml
sed -i 's/address>.*<.addr/address>'$(hostname)'<\/addr/' input-runner.xml
sed -i 's/all ipi [^ ]*/all ipi '$(hostname)'/' in.lmp
python /home/glensk/sources/ipi/bin/i-pi input-runner.xml &> log.i-pi &
sleep 10
for i in `seq 4`
do
      srun --hint=nomultithread --exclusive -n 14 --mem=4G /home/glensk/scripts/lammps/src/lmp_fidis < in.lmp > log.lmp$i  &
done
wait 
exit 0
