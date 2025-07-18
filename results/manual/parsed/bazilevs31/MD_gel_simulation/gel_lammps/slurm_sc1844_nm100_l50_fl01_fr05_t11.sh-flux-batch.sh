#!/bin/bash
#FLUX: --job-name=blank-poodle-0145
#FLUX: -n=121
#FLUX: -t=24600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'

export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK:-1}"
module load intel/2016.4 openmpi/2.1.1
module load lammps-user-intel/20170331
 srun  lmp_intel_cpu_openmpi -in 1_equil_lj.lammps -var infile sc1844_nm100_l50_fl01_fr05 -var Temp 1.1 -var kspring 30  -var name t11_ljeq1 -var nsteps 10000 -echo both
 srun  lmp_intel_cpu_openmpi -in 2_equil_coul.lammps -var infile sc1844_nm100_l50_fl01_fr05_t11_ljeq1 -var Temp 1.1 -var kspring 30  -var name coul_eq  -var nsteps 10000 -echo both
 srun  lmp_intel_cpu_openmpi -in new_coul_run.lammps -var infile sc1844_nm100_l50_fl01_fr05_t11_ljeq1_coul_eq -var Temp 1.1 -var kspring 30  -var name coulsim -var nsteps 10000  -echo both
 srun lmp_intel_cpu_openmpi -in pressure_profile.lammps -var infile sc1844_nm100_l50_fl01_fr05_t11_ljeq1_coul_eq_coulsim -var Temp 1.1 -var kspring 30  -var name press -echo both
