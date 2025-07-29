#!/bin/bash
#FLUX: --job-name=PerfHydroS
#FLUX: -n=20
#FLUX: --exclusive
#FLUX: -t=2400
#FLUX: --urgency=16

set -e
sfemfp32=1
case_folder=/scratch/zulian/xdns/fe_hydros/sfem/tests/compare/mesh-multi-outlet-better
laplsoldir=/scratch/diegor/zu/laplsol/
sfemdir=/scratch/zulian/xdns/fe_hydros/sfem/
utopiadir=./
module purge
module load petsc/3.13.5_gcc-10.1.0
module load git
module load cmake
module load boost
module list
PATH=$sfemdir:$PATH
PATH=$sfemdir/python:$PATH
PATH=$laplsoldir:$PATH
PATH=$utopiadir:$PATH
patdir=`mktemp -d`
patdircond=$patdir/condensed
mkdir $patdircond
pat32dir=$patdir/fp32
mkdir $pat32dir
diegodir=`mktemp -d`
diego64dir=$diegodir/fp64
mkdir $diego64dir
cp $case_folder/x.raw $diegodir/x.raw
cp $case_folder/y.raw $diegodir/y.raw
cp $case_folder/z.raw $diegodir/z.raw
cp $case_folder/i0.raw $diegodir/i0.raw
cp $case_folder/i1.raw $diegodir/i1.raw
cp $case_folder/i2.raw $diegodir/i2.raw
cp $case_folder/i3.raw $diegodir/i3.raw
cp $case_folder/on.raw $diegodir/on.raw
cp $case_folder/zd.raw $diegodir/zd.raw
echo "software: SFEM"
mpirun -np 1 assemble $case_folder $patdir
mpirun -np 1 condense_matrix $patdir 	      $case_folder/zd.raw $patdircond
mpirun -np 1 condense_vector $patdir/rhs.raw  $case_folder/zd.raw $patdircond/rhs.raw
fp_convert.py $patdircond/rhs.raw 	  $pat32dir/rhs.fp32.raw 		float64 float32
fp_convert.py $patdircond/values.raw  $pat32dir/values.fp32.raw  	float64 float32
if [ "$sfemfp32" -eq "1" ]; then
	fp_convert.py  $pat32dir/rhs.fp32.raw 	 $patdircond/rhs.raw 		float32 float64
	fp_convert.py  $pat32dir/values.fp32.raw $patdircond/values.raw  	float32 float64
fi
usolve.sh $patdircond/rowptr.raw $patdircond/rhs.raw $patdircond/sol.raw
mpirun -np 1 remap_vector $patdircond/sol.raw $case_folder/zd.raw $patdir/sol.raw
fp_convert.py $patdircond/sol.raw     $pat32dir/sol.fp32.raw 		float64 float32
fp_convert.py $patdir/sol.raw     	  $pat32dir/full_sol.fp32.raw 	float64 float32
echo "software: LAPLSOL"
laplsol-bc $diegodir
laplsol-asm $diegodir
mpirun laplsol-solve $diegodir $diegodir/rhs.raw $diegodir/sol.raw
laplsol-post $diegodir $diegodir/sol.raw
fp_convert.py $diegodir/lhs.value.raw  $diego64dir/values.raw float32 float64
fp_convert.py $diegodir/rhs.raw   	   $diego64dir/rhs.raw 	  float32 float64
cp $diegodir/lhs.rowindex.raw $diego64dir/rowptr.raw
cp $diegodir/lhs.colindex.raw $diego64dir/colidx.raw
usolve.sh $diego64dir/rowptr.raw  $diego64dir/rhs.raw $diego64dir/sol.raw
mpirun -np 1 remap_vector $diego64dir/sol.raw $case_folder/zd.raw $diego64dir/sol.full.raw
fp_convert.py $diego64dir/sol.full.raw $diegodir/sol.amg.f32.raw float64 float32
echo "COMPARE"
echo "SFEM files"
ls -la $pat32dir/
echo "LAPLSOL files"
ls -la $diegodir
fdiff.py $patdircond/rowptr.raw $diegodir/lhs.rowindex.raw 	int32 int32 1 ./rowptr_pat_vs_diego_rhs.png
fdiff.py $patdircond/colidx.raw $diegodir/lhs.colindex.raw 	int32 int32 1 ./colidx_pat_vs_diego_rhs.png
fdiff.py $pat32dir/values.fp32.raw 	 $diegodir/lhs.value.raw 		float32 float32 1 ./lhs_pat_vs_diego_rhs.png
fdiff.py $pat32dir/rhs.fp32.raw 	 $diegodir/rhs.raw 				float32 float32 1 ./rhs_pat_vs_diego_rhs.png
fdiff.py $pat32dir/sol.fp32.raw 	 $diegodir/sol.raw 				float32 float32 1 ./sol_pat_vs_diego_sol.png
fdiff.py $pat32dir/full_sol.fp32.raw $diegodir/p.raw				float32 float32 1 ./full_sol_pat_vs_diego_sol.png
diffsol.py $diegodir/p.raw $pat32dir/full_sol.fp32.raw ./diff.fp32.raw
diffsol.py $diegodir/p.raw $diegodir/sol.amg.f32.raw   ./diff.amg.fp32.raw
rm -rf $patdir
rm -rf $patdircond
rm -rf $pat32dir
rm -rf $diegodir
