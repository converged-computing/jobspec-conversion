#!/bin/bash
#FLUX: --job-name=faux-snack-2882
#FLUX: -N=2
#FLUX: --queue=small
#FLUX: -t=28800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load intel
module load impi/intel
module load cmake
mpiexec -np 48 ./tmmmobi \
   -numtracers 31 \
   -i dicini.petsc,dic13ini.petsc,c14ini.petsc,alkini.petsc,o2ini.petsc,po4ini.petsc,phytini.petsc,zoopini.petsc,detrini.petsc,coccini.petsc,caco3ini.petsc,dopini.petsc,no3ini.petsc,donini.petsc,diazini.petsc,din15ini.petsc,don15ini.petsc,phytn15ini.petsc,coccn15ini.petsc,zoopn15ini.petsc,detrn15ini.petsc,diazn15ini.petsc,dfeini.petsc,detrfeini.petsc,phytc13ini.petsc,coccc13ini.petsc,caco3c13ini.petsc,zoopc13ini.petsc,detrc13ini.petsc,doc13ini.petsc,diazc13ini.petsc \
   -me Ae -mi Ai \
   -t0 0.0 -iter0 0 \
   -deltat_clock 0.0009132420091324 \
   -max_steps 1095000 \
   -write_time_steps 109500 \
   -o dic.petsc,dic13.petsc,c14.petsc,alk.petsc,o2.petsc,po4.petsc,phyt.petsc,zoop.petsc,detr.petsc,cocc.petsc,caco3.petsc,dop.petsc,no3.petsc,don.petsc,diaz.petsc,din15.petsc,don15.petsc,phytn15.petsc,coccn15.petsc,zoopn15.petsc,detrn15.petsc,diazn15.petsc,dfe.petsc,detrfe.petsc,phytc13.petsc,coccc13.petsc,caco3c13.petsc,zoopc13.petsc,detrc13.petsc,doc13.petsc,diazc13.petsc \
   -pickup_out pickup.petsc \
   -time_file output_time.txt \
   -external_forcing \
   -use_profiles \
   -biogeochem_deltat 28800.0 \
   -days_per_year 365.0 \
   -periodic_matrix \
   -matrix_cycle_period 1.0 -matrix_num_per_period 12 -matrix_periodic_times_file periodic_times_365d.bin \
   -periodic_biogeochem_forcing \
   -periodic_biogeochem_cycle_period 1.0 -periodic_biogeochem_num_per_period 12 -periodic_biogeochem_periodic_times_file periodic_times_365d.bin \
   -time_avg -avg_start_time_step 1093906 -avg_time_steps 93,84,93,90,93,90,93,93,90,93,90,93 \
   -avg_files dicmmavg.petsc,dic13mmavg.petsc,c14mmavg.petsc,alkmmavg.petsc,o2mmavg.petsc,po4mmavg.petsc,phytmmavg.petsc,zoopmmavg.petsc,detrmmavg.petsc,coccmmavg.petsc,caco3mmavg.petsc,dopmmavg.petsc,no3mmavg.petsc,donmmavg.petsc,diazmmavg.petsc,din15mmavg.petsc,don15mmavg.petsc,phytn15mmavg.petsc,coccn15mmavg.petsc,zoopn15mmavg.petsc,detrn15mmavg.petsc,diazn15mmavg.petsc,dfemmavg.petsc,detrfemmavg.petsc,phytc13mmavg.petsc,coccc13mmavg.petsc,caco3c13mmavg.petsc,zoopc13mmavg.petsc,detrc13mmavg.petsc,doc13mmavg.petsc,diazc13mmavg.petsc \
   -calc_diagnostics -diag_start_time_step 1093906 -diag_time_steps 93,84,93,90,93,90,93,93,90,93,90,93 \
   > log
