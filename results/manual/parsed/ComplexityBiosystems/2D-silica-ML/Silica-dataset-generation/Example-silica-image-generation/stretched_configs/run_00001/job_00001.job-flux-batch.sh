#!/bin/bash
#FLUX: --job-name=GL-00001
#FLUX: -n=16
#FLUX: --queue=debug
#FLUX: --urgency=16

export PATH='$PATH:/bin'
export CJST='$(date +%s)'
export CJET='$(date +%s)'

[ -n "${SLURM_SUBMIT_DIR}" ] && cd ${SLURM_SUBMIT_DIR}
export PATH=$PATH:/bin
lammps=/home/guerra/Apps/lammps-3Mar20/src/lmp_mpi
mpiexec=/opt/share/openmpi-3.0.0-el-6.9/bin/mpiexec
echo "Job $SLURM_JOB_NAME submitted from host $SLURM_SUBMIT_HOST ; started "$(date)" ; jobid $SLURM_JOB_ID"
echo "Running on host: $(hostname)."
echo "In directory: $(pwd) (Should be the same than this $SLURM_SUBMIT_HOST)."
export CJST=$(date +%s)
i=00001
echo "conf = "$i
scripinputvars="-v conf ${i}"
$mpiexec $lammps ${scripinputvars} -in ../template_silica_2D_v4.lmp -log /dev/null > out.lammps
export CJET=$(date +%s)
echo "Elapsed seconds: $((CJET-CJST))"
function broken {
  touch sio2_3_bondbreak_${1}.is_broken
  strain=$(head -q -n 6 sio2_1_initial.dump sio2_3_bondbreak_${1}.dump | awk 'NR==6{Lx0=$2}NR==12{Lx=$2}END{print (Lx-Lx0)/Lx0}')
  echo "$strain" > bondbreak.dat
  echo "$check" >> bondbreak.dat
}
rm -f sio2_3_bondbreak_?.is_broken
[ ! -s sio2_1_initial.dump -o ! -s sio2_2_aqs.dump -o ! -s sio2_3_bondbreak_1.dump ] && exit 1
check=$(../get_fracture.awk sio2_1_initial.dump sio2_2_aqs.dump)
[ -n "$check" ] && touch sio2_2_aqs.is_broken && rm -f bondbreak.dat && exit 1
check=$(../get_fracture.awk sio2_1_initial.dump sio2_3_bondbreak_1.dump)
[ -n "$check" ] && broken 1 && exit 0
check=$(../get_fracture.awk sio2_1_initial.dump sio2_3_bondbreak_2.dump)
[ -n "$check" ] && broken 2 && exit 0
check=$(../get_fracture.awk sio2_1_initial.dump sio2_3_bondbreak_3.dump)
[ -n "$check" ] && broken 3 && exit 0
