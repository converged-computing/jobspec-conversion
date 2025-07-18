#!/bin/bash
#FLUX: --job-name=hairy-bike-5945
#FLUX: -n=24
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda/6.5.14
echo "Begin 5 5 0 origin - Tantalum 4"
 #	-var notchshape 6\			
 #	-var notchshape 7\			
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N10.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
	-var dumpname3sh "zdump.Ta3_550_Shear_N10_*.out"\
	-var dumpname4sh "zzzFinedump.Ta4_550_Shear_N10_*.out"\
	-var dumpname4sbox1 "zzFinedump.Ta4_550_N10_StressVolumePress1L_*.out"\
	-var dumpname4sbox2 "zzFinedump.Ta4_550_N10_StressVolumePress2R_*.out"\
	-var dumpname4sbox3 "zzFinedump.Ta4_550_N10_StressVolumePress3M_*.out"\
	-var dumpname5sh "zdump.Ta5_550_Shear_N10_*.out"\
	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N10_*.out"\
	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N10_*.out"\
	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N10_*.out"\
	-var restartname3eq "Ta3_550_Eq_N10.restart"\
	-var restartname4eq "Ta4_550_Eq_N10.restart"\
	-var restartname5eq "Ta5_550_Eq_N10.restart"\
	-var restartname3sh "Ta3_550_Sh_N10.restart"\
	-var restartname4sh "Ta4_550_Sh_N10.restart"\
	-var restartname5sh "Ta5_550_Sh_N10.restart"\
	-var Ta 4\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N12.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
	-var dumpname3sh "zdump.Ta3_550_Shear_N12_*.out"\
	-var dumpname4sh "zzzFinedump.Ta4_550_Shear_N12_*.out"\
	-var dumpname4sbox1 "zzFinedump.Ta4_550_N12_StressVolumePress1L_*.out"\
	-var dumpname4sbox2 "zzFinedump.Ta4_550_N12_StressVolumePress2R_*.out"\
	-var dumpname4sbox3 "zzFinedump.Ta4_550_N12_StressVolumePress3M_*.out"\
	-var dumpname5sh "zdump.Ta5_550_Shear_N12_*.out"\
	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N12_*.out"\
	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N12_*.out"\
	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N12_*.out"\
	-var restartname3eq "Ta3_550_Eq_N12.restart"\
	-var restartname4eq "Ta4_550_Eq_N12.restart"\
	-var restartname5eq "Ta5_550_Eq_N12.restart"\
	-var restartname3sh "Ta3_550_Sh_N12.restart"\
	-var restartname4sh "Ta4_550_Sh_N12.restart"\
	-var restartname5sh "Ta5_550_Sh_N12.restart"\
	-var Ta 4\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4
echo "End 5 5 0 origin- Tantalum 4"
