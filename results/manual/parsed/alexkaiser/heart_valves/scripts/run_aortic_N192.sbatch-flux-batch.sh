#!/bin/bash
#FLUX: --job-name=aortic_1
#FLUX: --queue=willhies,amarsden
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load gcc/8.1.0
module load openmpi/2.0.2
SRCDIR=$PWD
RUNDIR=$SCRATCH/aortic_${SLURM_JOBID/.*}_192_8f290e8_convergence_check_layers_up
mkdir $RUNDIR
BASE_NAME=aortic_192
INPUT_NAME=input_aortic_192
RUN_LINE="mpiexec --bind-to core -report-bindings main3d"
OPTIONS="-velocity_ksp_type cg -velocity_pc_type none -velocity_ksp_max_it 1 -velocity_ksp_norm_type none > output.txt 2>&1"
SESSION_NAME="aortic_192_visit2pt9.session"
VIEW_CLIPPING="-0.2"
pwd
cd $SRCDIR
cp $BASE_NAME*                               $RUNDIR
cp aorta_bdry.vertex                         $RUNDIR
cp atrium_bdry.vertex                        $RUNDIR
cp $INPUT_NAME                               $RUNDIR
cp *.cpp                                     $RUNDIR
cp main3d                                    $RUNDIR
cp fourier_coeffs*.txt                       $RUNDIR
cp watchdog_job_restart.py                   $RUNDIR
cp kill_all_mpi.sh                           $RUNDIR
cp run_aortic_N192.sbatch                    $RUNDIR
cp run_parallel_movie.py                     $RUNDIR
cd $RUNDIR
env_log=$RUNDIR/env.log
rm -rf $env_log
env | grep -v '{' | grep -v '}' | grep -v '()' | grep -v _= > $env_log
python watchdog_job_restart.py "$RUN_LINE" "$INPUT_NAME" "$OPTIONS" 
source ~/.bash_profile
SESSION_NAME_PARAVIEW="~/copies_scripts/velocity_slices_5.py"
visit -cli -nowin -s ~/copies_scripts/run_parallel_convert_visit_to_paraview.py $SLURM_NTASKS $SLURM_NTASKS
python ~/copies_scripts/run_parallel_movie_paraview.py $SESSION_NAME_PARAVIEW $SLURM_NTASKS
