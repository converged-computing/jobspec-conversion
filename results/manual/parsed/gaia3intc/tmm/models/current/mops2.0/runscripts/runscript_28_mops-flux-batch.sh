#!/bin/bash
#FLUX: --job-name=sticky-leg-4181
#FLUX: -t=1200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo "Dir in slurm: " $PWD
module purge
module load intel
module load impi/intel
module load cmake
module list
mpirun -np 24 ./mops \
        -numtracers 9 \
        -i po4ini.petsc,dopini.petsc,oxyini.petsc,phyini.petsc,zooini.petsc,detini.petsc,no3ini.petsc,dicini.petsc,alkini.petsc \
        -me Ae \
        -mi Ai \
        -t0 0.0 -iter0 0 \
        -deltat_clock 0.0013888888888889 \
        -max_steps 72000 \
        -write_time_steps 7200 \
        -o po4out.petsc,dopout.petsc,oxyout.petsc,phyout.petsc,zooout.petsc,detout.petsc,no3out.petsc,dicout.petsc,alkout.petsc \
        -external_forcing \
        -use_profiles \
        -nzeuph 2 \
        -biogeochem_deltat 43200.0 -days_per_year 360.0 \
        -burial_sum_steps 720 \
        -pco2atm 280.0 \
        -use_virtual_flux \
        -periodic_matrix \
        -matrix_cycle_period 1.0 -matrix_num_per_period 12 \
        -periodic_biogeochem_forcing \
        -periodic_biogeochem_cycle_period 1.0 -periodic_biogeochem_num_per_period 12 \
        -num_biogeochem_steps_per_ocean_step 8 \
        -separate_biogeochem_time_stepping \
        -time_avg -avg_start_time_step 71281 -avg_time_steps 60 \
        -avg_files po4avg.petsc,dopavg.petsc,oxyavg.petsc,phyavg.petsc,zooavg.petsc,detavg.petsc,no3avg.petsc,dicavg.petsc,alkavg.petsc \
        -bgc_params_file biogem_params.txt \
        -num_bgc_params 8 \
        -calc_diagnostics -diag_start_time_step 71281 -diag_time_steps 60 \
        -diag_files fbgc1.petsc,fbgc2.petsc,fbgc3.petsc,fbgc4.petsc,fbgc5.petsc,fbgc6.petsc,fbgc7.petsc,fbgc8.petsc \
        > log_28_mops
