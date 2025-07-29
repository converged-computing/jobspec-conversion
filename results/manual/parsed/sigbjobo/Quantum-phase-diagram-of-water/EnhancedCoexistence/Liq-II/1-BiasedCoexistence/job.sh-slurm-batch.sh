#!/bin/bash
#FLUX: --job-name=COEX
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpuA100x4
#FLUX: -t=86400
#FLUX: --urgency=16

export PLUMED_NUM_THREADS='16'
export OMP_NUM_THREADS='12'
export TF_INTRA_OP_PARALLELISM_THREADS='2'
export TF_INTER_OP_PARALLELISM_THREADS='2'
export SLURM_CPU_BIND='cores'
export cycles='100'

cd $SLURM_SUBMIT_DIR
source ~/env/lmp_deepmd.sh
export PLUMED_NUM_THREADS=16
export OMP_NUM_THREADS=12
export TF_INTRA_OP_PARALLELISM_THREADS=2
export TF_INTER_OP_PARALLELISM_THREADS=2
export SLURM_CPU_BIND="cores"
export cycles=100
START=$(date)
if [ -e restart.lmp.0 ] ; then
    if [ -s restart.lmp.0 ]; then
	echo restart.lmp.0 exists
    else
	echo restart.lmp.0 does not exists, copying restart2.lmp.0
	cp  restart2.lmp.0 restart.lmp.0
    fi
    nn=`tail -n 1 runno | awk '{print $1}'`
    if [ -s DELTAFS ]
    then
	cp plumed.restart.dat plumed.dat
    else
	cp plumed.start.dat plumed.dat
    fi
    srun $LAMMPS_EXE -in Restart.lmp
else
    nn=1
    srun $LAMMPS_EXE  -in start.lmp
fi
set +e
NUM_DONE=$(grep TIMESTEP -A1 dump.water.0 | tail -n1)
for j in $(seq 0 0)
do
    cp log.lammps log.lammps.${j}.${nn}
    cp restart2.lmp.${j} restart2.lmp.${j}.${nn}
    cp restart.lmp.${j} restart.lmp.${j}.${nn}
    cp data.final.${j} data.final.${j}.${nn}
    cp DELTAFS DELTAFS.${nn}
    mv dump.water.0 dump.water.0.${NUM_DONE}
    mv dump.water.dcd dump.water.dcd.${NUM_DONE}
done
mm=$((nn+1))
echo ${mm} > runno
END=$(date)
Time_diff_in_secs=$(($(date -d "$END" +%s) - $(date -d "$START" +%s)))
if [ "$Time_diff_in_secs" -le "300" ]; then
    echo Run exited premeaturely, no resubmission!
    exit
fi
if [ ${nn} -ge ${cycles} ]; then
  exit
fi
if [ -e procedure.lmp ] ; then
    NWALL=$(grep nsteps_wall procedure.lmp|head -n1 | grep equal |awk '{print $4}')
    NCOEX=$(grep nsteps_enhanced_coex procedure.lmp|head -n1 | grep equal |awk '{print $4}')
    let NUM_STOP=$NWALL+$NCOEX
else
    NUM_STOP=$(grep "run " Restart.lmp|head -n1 |awk '{print $2}')
fi
if [ ${NUM_DONE} -ge ${NUM_STOP} ]; then
  exit
fi
fold=$PWD
ice=$(basename $(realpath $fold/../../))
T=$(basename $fold)
P=$(echo $(basename $(realpath $fold/../))| sed 's#COEX_##g'|sed 's#000#k#g')
name=${ice}$P$T
sbatch --job-name=$name  /u/sigbjobo/Jobscripts/CoexDeePMD/job.sh
