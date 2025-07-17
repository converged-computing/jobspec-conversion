#!/bin/bash
#FLUX: --job-name=stanky-parrot-7785
#FLUX: -n=24
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

module load cuda/6.5.14
echo "Begin 5 5 0 origin - Tantalum 5"
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta5_550_Equil_DA_N8.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
	-var dumpname3eq "zdump.Ta3_550_Equil_N8_*.out"\
	-var dumpname4eq "zdump.Ta4_550_Equil_N8_*.out"\
	-var dumpname5eq "zdump.Ta5_550_Equil_N8_*.out"\
	-var restartname3gb "Ta3_550_GB.restart"\
	-var restartname4gb "Ta4_550_GB.restart"\
	-var restartname5gb "Ta5_550_GB.restart"\
	-var restartname3eq "Ta3_550_Eq_N8.restart"\
	-var restartname4eq "Ta4_550_Eq_N8.restart"\
	-var restartname5eq "Ta5_550_Eq_N8.restart"\
	-var Ta 5\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var notchshape 8\			
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta5_550_Shear_DA_N8.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
	-var dumpname3sh "zdump.Ta3_550_Shear_N8_*.out"\
	-var dumpname4sh "zdump.Ta4_550_Shear_N8_*.out"\
	-var dumpname5sh "zdump.Ta5_550_Shear_N8_*.out"\
	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N8_*.out"\
	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N8_*.out"\
	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N8_*.out"\
	-var restartname3eq "Ta3_550_Eq_N8.restart"\
	-var restartname4eq "Ta4_550_Eq_N8.restart"\
	-var restartname5eq "Ta5_550_Eq_N8.restart"\
	-var restartname3sh "Ta3_550_Sh_N8.restart"\
	-var restartname4sh "Ta4_550_Sh_N8.restart"\
	-var restartname5sh "Ta5_550_Sh_N8.restart"\
	-var Ta 5\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta5_550_Equil_DA_N9.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
	-var dumpname3eq "zdump.Ta3_550_Equil_N9_*.out"\
	-var dumpname4eq "zdump.Ta4_550_Equil_N9_*.out"\
	-var dumpname5eq "zdump.Ta5_550_Equil_N9_*.out"\
	-var restartname3gb "Ta3_550_GB.restart"\
	-var restartname4gb "Ta4_550_GB.restart"\
	-var restartname5gb "Ta5_550_GB.restart"\
	-var restartname3eq "Ta3_550_Eq_N9.restart"\
	-var restartname4eq "Ta4_550_Eq_N9.restart"\
	-var restartname5eq "Ta5_550_Eq_N9.restart"\
	-var Ta 5\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var notchshape 9\			
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta5_550_Shear_DA_N9.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
	-var dumpname3sh "zdump.Ta3_550_Shear_N9_*.out"\
	-var dumpname4sh "zdump.Ta4_550_Shear_N9_*.out"\
	-var dumpname5sh "zdump.Ta5_550_Shear_N9_*.out"\
	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N9_*.out"\
	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N9_*.out"\
	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N9_*.out"\
	-var restartname3eq "Ta3_550_Eq_N9.restart"\
	-var restartname4eq "Ta4_550_Eq_N9.restart"\
	-var restartname5eq "Ta5_550_Eq_N9.restart"\
	-var restartname3sh "Ta3_550_Sh_N9.restart"\
	-var restartname4sh "Ta4_550_Sh_N9.restart"\
	-var restartname5sh "Ta5_550_Sh_N9.restart"\
	-var Ta 5\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4
echo "End 5 5 0 origin- Tantalum 5"
