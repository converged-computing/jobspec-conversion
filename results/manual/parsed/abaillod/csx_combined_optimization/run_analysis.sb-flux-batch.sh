#!/bin/bash
#FLUX: --job-name=simsopt
#FLUX: -t=60
#FLUX: --urgency=16

source ~/.bashrc
module load gcc/10.2.0
module load openmpi/gcc/64/4.1.5a1
module load netcdf-fortran/4.5.3
module load hdf5/1.10.1
module load intel-parallel-studio/2020
module load netcdf/gcc/64/gcc/64/4.7.4
conda activate simsopt
srun --mpi=pmix_v3 python run_analysis.py --path $1
echo "'#'
'#'
'#'
boozmn.nc           ! Boozer output file to utilize in calculation, e.g. boozmn_template.nc
neo.output          ! NEO output file name
 9                  ! Number of surfaces on which to conduct calculation
 2 12 22 32 41 62 72 81 91 101! Surfaces on which calculation is to be conducted (number must match above number)
 200                ! Number of points in theta (>100)
 200                ! Number of points in zeta (>100)
 0                  ! Maximum poloidal mode number
 0                  ! Maximum toroidal mode number
 50                 ! Number of test particles for J_perp integration (>50)
 1                  ! Maximum number of trapped particles (1: singly trapped, 2: doubly trapped....n-trapped)
 0.01               ! Required accuracy for each integration along field line (~0.01 is good)
 100                ! Number of bins in poloidal direction to be filled on a toroidal cut (~100)
 50                 ! Number of integration steps per field period (>50)
 500                ! Minimum number of field periods to traverse (>=500)
 20000              ! (raised to help NaN) Maximum number of field periods to traverse (>=2000)
 0                  ! CALC_NSTEP_MAX
 1                  ! Output control (1: basic, 2: detailed, 10: simple)
 0                  ! Lab specific switch (0: PPPL)
 0                  ! Input format swtich (0: BOOZ_XFORM)
 2                  ! Reference |B| value for eps_eff (1: inner flux surface, 2: max on flux surface)
 1                  ! WRITE_PROGRESS
 0                  ! Controls additional output (0: none, 1: theta/phi dump)
 0                  ! Spline routine testing (0: none, 1: along given phi, 2: along given theta, 3: diagonal)
 1                  ! Write integration quantities (conver.dat)
 1                  ! Write diagnostic quantities (diagnostic.dat and diagnostic_add.dat)
'#'
'#'
'#'
 0                  ! CALC_CUR
neo_cur.ext         ! CUR_FILE
0                 ! NPART_CUR
0                   ! ALPHA_CUR
0                   ! WRITE_CUR_INTE" >> $1/neo.input
srun --mpi=pmix_v3 /burg/home/ejp2170/STELLOPT/bin/xneo $1/neo.input
