#!/bin/bash
#FLUX: --job-name=pusheena-dog-3644
#FLUX: --urgency=16

export KMP_STACKSIZE='24M   # p=6'
export KMP_INIT_AT_FORK='FALSE'

module list
pwd
date
nthreads=14
export KMP_STACKSIZE=24M   # p=6
export KMP_INIT_AT_FORK=FALSE
alpha=1.0d-4
envelope=true
envelope_config=3
if [ "$envelope_config" = 1 ] ; then
   wavenum_signal=85.0d0 
fi
if [ "$envelope_config" = 2 ] ; then
   wavenum_signal=85.5119d0 
fi
if [ "$envelope_config" = 3 ] ; then
   wavenum_signal=85.5976d0 
fi
if [ "$envelope_config" = 1 ] ; then
   # 1 NODE
   #  76_8 (1024 wavelengths), 5 refs (16*  32 elems), 8000 nodes
   #zl=76.8d0; pmlfrac=0.5d0; imax=5; maxnods=8000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_76_8'
   # 2 NODES
   #  153_6 (2048 wavelengths), 6 refs (16*  64 elems), 16000 nodes
   #zl=153.6d0; pmlfrac=0.25d0; imax=6; maxnods=16000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_153_6'
   # 4 NODES
   #  307_2 (4096 wavelengths), 7 refs (16*  128 elems), 32000 nodes
   #zl=307.2d0; pmlfrac=0.125d0; imax=7; maxnods=32000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_307_2'
   #
   # 8 NODES
   #  650_0 (6.0mm = 8160 wavelengths), 8 refs (16*  256 elems), 63000 nodes
   #zl=650.0d0; pmlfrac=0.0625d0; imax=8; maxnods=63000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_650'
   #
   # 16 NODES
   #  1300_0 (1.25cm = 17,000 wavelengths), 9 refs (16*  512 elems), 126000 nodes
   #zl=1300.0d0; pmlfrac=0.03125d0; imax=9; maxnods=126000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_1300'
   #
   # 32 NODES
   #  2600_0 (2.5cm = 34,000 wavelengths), 10 refs (16*  1024 elems), 251000 nodes
   zl=2600.0d0; pmlfrac=0.015625d0; imax=10; maxnods=251000
   file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_2600'
   #
   # 64 NODES
   #  5100_0 (5.0cm = 68,000 wavelengths), 11 refs (16*  2048 elems), 501000 nodes
   #zl=5100.0d0; pmlfrac=7.8125d-3; imax=11; maxnods=501000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_5100'
   #
   # 128 NODES
   #  10100_0 (10.0cm = 136000 wavelengths), 12 refs (16*  4096 elems), 1001000 nodes
   #zl=10100.0d0; pmlfrac=3.90625d-3; imax=12; maxnods=1001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_10100'
   #
   # 256 NODES
   #  20100_0 (20.0cm = 272000 wavelengths), 13 refs (16*  8192 elems), 2001000 nodes
   #zl=20100.0d0; pmlfrac=1.953125d-3; imax=13; maxnods=2001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_20100'
   #
   # 512 NODES
   #  40100_0 (40.0cm = 544000 wavelengths), 14 refs (16*  16384 elems), 4001000 nodes
   #zl=40100.0d0; pmlfrac=9.765625d-4; imax=14; maxnods=4001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_40100'
fi
if [ "$envelope_config" = 2 ] ; then
   # 1 NODE
   #  L=400 (2.0 mm = 2720 wavelengths), 5 refs (16*  32 elems), 8000 nodes
   #zl=400.d0; pmlfrac=0.5d0; imax=5; maxnods=8000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_400'
   #
   # 2 NODES
   #  L=800 (6.0 mm = 8160 wavelengths), 6 refs (16*  64 elems), 16000 nodes
   #zl=800.0d0; pmlfrac=0.25d0; imax=6; maxnods=16000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_800'
   #
   # 4 NODES
   #  L=1500 (1.25 cm = 17,000 wavelengths), 7 refs (16*  128 elems), 32000 nodes
   #zl=1500.0d0; pmlfrac=0.125d0; imax=7; maxnods=32000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_1500'
   #
   # 8 NODES
   #  L=2750 (2.5 cm = 34,000 wavelengths), 8 refs (16*  256 elems), 63000 nodes
   #zl=2750.0d0; pmlfrac=0.0625d0; imax=8; maxnods=63000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_2750'
   #
   # 16 NODES
   #  L=5250 (5 cm = 68,000 wavelengths), 9 refs (16*  512 elems), 126000 nodes
   #zl=5250.0d0; pmlfrac=0.03125d0; imax=9; maxnods=126000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_5250'
   #
   # 32 NODES
   #  L=10250 (10 cm = 136,000 wavelengths), 10 refs (16*  1024 elems), 251000 nodes
   #zl=10250.0d0; pmlfrac=0.015625d0; imax=10; maxnods=251000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_10250'
   #
   # 64 NODES
   #  L=20250 (20 cm = 272,000 wavelengths), 11 refs (16*  2048 elems), 501000 nodes
   zl=20250.0d0; pmlfrac=7.8125d-3; imax=11; maxnods=501000
   file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_20250'
   #
   # 128 NODES
   #  L=40250 (40 cm = 544,000 wavelengths), 12 refs (16*  4096 elems), 1001000 nodes
   #zl=40250.0d0; pmlfrac=3.90625d-3; imax=12; maxnods=1001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_40250'
   #
   # 256 NODES
   #  L=80250 (80 cm = 1,088,000 wavelengths), 13 refs (16*  8192 elems), 2001000 nodes
   #zl=80250.0d0; pmlfrac=1.953125d-3; imax=13; maxnods=2001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_80250'
   #
   # 512 NODES
   #  L=160250 (160 cm = 2,176,000 wavelengths), 14 refs (16*  16384 elems), 4001000 nodes
   #zl=160250.0d0; pmlfrac=9.765625d-4; imax=14; maxnods=4001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_160250'
fi
if [ "$envelope_config" = 3 ] ; then
   # 4 NODES
   #  L=3000 (2 cm = 27,000 wavelengths), 7 refs (16*  128 elems), 32000 nodes
   #zl=3000.0d0; pmlfrac=0.25d0; imax=7; maxnods=32000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_3000'
   #
   # 8 NODES
   #  L=6000 (5 cm = 68,000 wavelengths), 8 refs (16*  256 elems), 63000 nodes
   #zl=6000.0d0; pmlfrac=0.125d0; imax=8; maxnods=63000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_6000'
   #
   # 16 NODES
   #  L=11000 (10 cm = 136,000 wavelengths), 9 refs (16*  512 elems), 126000 nodes
   zl=11000.0d0; pmlfrac=0.0625d0; imax=9; maxnods=126000
   file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_11000'
   #
   # 32 NODES p=666 | 64 NODES p=777
   #  L=21000 (20 cm = 272,000 wavelengths), 10 refs (16*  1024 elems), 251000 nodes
   #zl=21000.0d0; pmlfrac=0.03125d0; imax=10; maxnods=251000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_21000'
   #
   # 64 NODES p=666 | 128 NODES p=777
   #  L=41000 (40 cm = 544,000 wavelengths), 11 refs (16*  2048 elems), 501000 nodes
   #zl=41000.0d0; pmlfrac=0.015625d0; imax=11; maxnods=501000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_41000'
   #
   # 128 NODES p=666 | 256 NODES p=777
   #  L=81000 (80 cm = 1,088,000 wavelengths), 12 refs (16*  4096 elems), 1001000 nodes
   #zl=81000.0d0; pmlfrac=7.8125d-3; imax=12; maxnods=1001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_81000'
   #
   # 256 NODES p=666 | 512 NODES p=777
   #  L=161000 (160 cm = 2,176,000 wavelengths), 13 refs (16*  8192 elems), 2001000 nodes
   #zl=161000.0d0; pmlfrac=3.90625d-3; imax=13; maxnods=2001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_161000'
   #
   # 512 NODES p=666 | 1024 NODES p=777
   #  L=321000 (320 cm = 4,352,000 wavelengths), 14 refs (16*  16384 elems), 4001000 nodes
   #zl=321000.0d0; pmlfrac=1.953125d-3; imax=14; maxnods=4001000
   #file_geometry='../GEOMETRIES/fiber/fiber_prism/fiber_prism_321000'
fi
job=1
jmax=1
px=6; py=6; pz=6
dp=1
ref_core=1.4512d0
ref_clad=1.4500d0
ibc=0
usepml=true
nlflag=1
heat=1
plane_pump=2
plane_pump_power=1.0d3
copump=1
gain=1.0d0
raman=0.d0
aniso_heat=0
aniso_ref_index=0
art_grating=0
nsteps=10
dt=0.1d0
gamma=1.0d0
ctrl='../COMMON_FILES/control_0'
mkdir ${SLURM_JOB_ID}
cd ${SLURM_JOB_ID}
mkdir outputs
cd outputs
mkdir paraview
mkdir power
mkdir temp
cd ../..
dir_output="${SLURM_JOB_ID}/outputs/"
vis_level=2
args=" -geom 5 -isol 17 -alpha ${alpha} -gamma ${gamma} -comp 1"
args+=" -ref_core ${ref_core} -ref_clad ${ref_clad}"
args+=" -aniso_ref_index ${aniso_ref_index}"
args+=" -art_grating ${art_grating}"
args+=" -job ${job} -imax ${imax} -jmax ${jmax}"
args+=" -ibc ${ibc}"
args+=" -px ${px} -py ${py} -pz ${pz} -dp ${dp}"
args+=" -copump ${copump} -nlflag ${nlflag} -gain ${gain} -raman ${raman}"
args+=" -plane_pump ${plane_pump} -plane_pump_power ${plane_pump_power}"
args+=" -heat ${heat} -aniso_heat ${aniso_heat} -nsteps ${nsteps} -dt ${dt}"
args+=" -dir_output ${dir_output} -vis_level ${vis_level}"
args+=" -file_geometry ${file_geometry} -zl ${zl}"
args+=" -file_control ${ctrl}"
args+=" -maxnods ${maxnods}"
args+=" -nthreads ${nthreads}"
if [ "$usepml" = true ] ; then
   args+=" -usepml -pmlfrac ${pmlfrac}"
fi
if [ "$envelope" = true ] ; then
   args+=" -envelope"
   args+=" -wavenum_signal ${wavenum_signal} -wavenum_pump 92.7d0"
fi
ibrun ./uwLaserThermal ${args}
date
