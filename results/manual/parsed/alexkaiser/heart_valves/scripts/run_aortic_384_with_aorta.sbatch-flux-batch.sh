#!/bin/bash
#FLUX: --job-name=aortic_1
#FLUX: -N=2
#FLUX: --queue=amarsden,willhies
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load gcc/8.1.0
module load openmpi/2.0.2
SRCDIR=$PWD
RUNDIR=$SCRATCH/aortic_${SLURM_JOBID/.*}_384_82b2164_basic_5pt6L
mkdir $RUNDIR
BASE_NAME=aortic_no_partition_384
BASE_NAME_VESSEL=aorta_384
INPUT_NAME=input_aortic_384_with_aorta
RUN_LINE="mpiexec --bind-to core -report-bindings main_aorta"
OPTIONS="-velocity_ksp_type cg -velocity_pc_type none -velocity_ksp_max_it 1 -velocity_ksp_norm_type none > output.txt 2>&1"
SESSION_NAME="aortic_384_with_aorta.session"
VIEW_CLIPPING="-0.2"
pwd
cd $SRCDIR
cp $BASE_NAME*                               $RUNDIR
cp $BASE_NAME_VESSEL*                        $RUNDIR
cp lvot_bdry_384.vertex                      $RUNDIR
cp aorta_bdry_384.vertex                     $RUNDIR
cp $INPUT_NAME                               $RUNDIR
cp *.cpp                                     $RUNDIR
cp main_aorta                                $RUNDIR
cp fourier_coeffs_ventricle.txt              $RUNDIR
cp watchdog_job_restart.py                   $RUNDIR
cp kill_all_mpi.sh                           $RUNDIR
cp run_aortic_384_with_aorta.sbatch          $RUNDIR
cp run_parallel_movie.py                     $RUNDIR
cd $RUNDIR
env_log=$RUNDIR/env.log
rm -rf $env_log
env | grep -v '{' | grep -v '}' | grep -v '()' | grep -v _= > $env_log
python watchdog_job_restart.py "$RUN_LINE" "$INPUT_NAME" "$OPTIONS" 
source ~/.bash_profile
python run_parallel_movie.py $SESSION_NAME $SLURM_NTASKS $VIEW_CLIPPING
