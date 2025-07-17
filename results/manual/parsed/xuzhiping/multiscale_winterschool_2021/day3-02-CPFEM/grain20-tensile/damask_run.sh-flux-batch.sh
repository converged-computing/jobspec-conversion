#!/bin/bash
#FLUX: --job-name=damask
#FLUX: --queue=course
#FLUX: --urgency=16

export PETSC_DIR='/apps/src/petsc-3.6.4/'
export PETSC_ARCH='arch-linux2-c-opt'
export PATH='/apps/lib/anaconda/anaconda3/e5/bin:$PATH'
export DAMASK_NUM_THREADS='6'

source /apps/soft/DAMASK-v2.0.1/DAMASK_env.sh
export PETSC_DIR=/apps/src/petsc-3.6.4/
export PETSC_ARCH=arch-linux2-c-opt
export PATH=/apps/src/petsc-3.6.4/arch-linux2-c-opt/bin:$PATH
export PATH=/apps/lib/anaconda/anaconda3/e5/bin:$PATH
export DAMASK_NUM_THREADS=6
/apps/soft/DAMASK-v2.0.1/code/DAMASK_spectral.exe --load tensionX.load --geom Myself.geom
module load lib/anaconda/anaconda2/config
postResults Myself_tensionX.spectralOut --increments --range 0 200 50 --separation x,y,z --split --cr texture,f,p,orientation,grainrotation
cd postProc/
addStrainTensors Myself_tensionX_inc000.txt --left --logarithmic;
addCauchy Myself_tensionX_inc000.txt;
vtk_rectilinearGrid Myself_tensionX_inc000.txt;
vtk_addRectilinearGridData -s 1_Cauchy,2_Cauchy,3_Cauchy,4_Cauchy,5_Cauchy,6_Cauchy,1_orientation,2_orientation,3_orientation,1_grainrotation,2_grainrotation,3_grainrotation Myself_tensionX_inc000.txt --vtk Myself_tensionX_inc000_pos\(cell\).vtr;
addStrainTensors Myself_tensionX_inc050.txt --left --logarithmic;
addCauchy Myself_tensionX_inc050.txt;
vtk_rectilinearGrid Myself_tensionX_inc050.txt;
vtk_addRectilinearGridData -s 1_Cauchy,2_Cauchy,3_Cauchy,4_Cauchy,5_Cauchy,6_Cauchy,1_orientation,2_orientation,3_orientation,1_grainrotation,2_grainrotation,3_grainrotation Myself_tensionX_inc050.txt --vtk Myself_tensionX_inc050_pos\(cell\).vtr;
addStrainTensors Myself_tensionX_inc100.txt --left --logarithmic;
addCauchy Myself_tensionX_inc100.txt;
vtk_rectilinearGrid Myself_tensionX_inc100.txt;
vtk_addRectilinearGridData -s 1_Cauchy,2_Cauchy,3_Cauchy,4_Cauchy,5_Cauchy,6_Cauchy,1_orientation,2_orientation,3_orientation,1_grainrotation,2_grainrotation,3_grainrotation Myself_tensionX_inc100.txt --vtk Myself_tensionX_inc100_pos\(cell\).vtr;
addStrainTensors Myself_tensionX_inc200.txt --left --logarithmic;
addCauchy Myself_tensionX_inc200.txt;
vtk_rectilinearGrid Myself_tensionX_inc200.txt;
vtk_addRectilinearGridData -s 1_Cauchy,2_Cauchy,3_Cauchy,4_Cauchy,5_Cauchy,6_Cauchy,1_orientation,2_orientation,3_orientation,1_grainrotation,2_grainrotation,3_grainrotation Myself_tensionX_inc200.txt --vtk Myself_tensionX_inc200_pos\(cell\).vtr;
cd ..
mv postProc FieldData
postResults Myself_tensionX.spectralOut --cr f,p --co edge_density --co dipole_density --co twin_fraction
cd postProc
addStrainTensors Myself_tensionX.txt --left --logarithmic
addCauchy Myself_tensionX.txt
addMises -e 'ln(V)' -s Cauchy Myself_tensionX.txt
cd ..
mv postProc HistoryData
