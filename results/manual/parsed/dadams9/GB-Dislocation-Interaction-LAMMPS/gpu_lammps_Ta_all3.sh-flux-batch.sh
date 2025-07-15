#!/bin/bash
#FLUX: --job-name=gloopy-poodle-5846
#FLUX: -n=24
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda/6.5.14
echo "Begin 5 0 5 origin - Tantalum 3"
 #	-var notchshape 2\			
 #	-var notchshape 7\			
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta3_550_Shear_DA_N13.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
	-var dumpname3sh "zzzFinedump.Ta3_550_Shear_N13_*.out"\
	-var dumpname3sbox1 "zzFinedump.Ta3_550_N13_StressVolumePress1L_*.out"\
	-var dumpname3sbox2 "zzFinedump.Ta3_550_N13_StressVolumePress2R_*.out"\
	-var dumpname3sbox3 "zzFinedump.Ta3_550_N13_StressVolumePress3M_*.out"\
	-var dumpname4sh "zdump.Ta4_550_Shear_N13_*.out"\
	-var dumpname5sh "zdump.Ta5_550_Shear_N13_*.out"\
	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N13_*.out"\
	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N13_*.out"\
	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N13_*.out"\
	-var restartname3eq "Ta3_550_Eq_N13.restart"\
	-var restartname4eq "Ta4_550_Eq_N13.restart"\
	-var restartname5eq "Ta5_550_Eq_N13.restart"\
	-var restartname3sh "Ta3_550_Sh_N13.restart"\
	-var restartname4sh "Ta4_550_Sh_N13.restart"\
	-var restartname5sh "Ta5_550_Sh_N13.restart"\
	-var Ta 3\
	-var a 0.5\
	-var b 0.5\
	-var c 0.0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4
echo "End 5 0 5 origin- Tantalum 3"
