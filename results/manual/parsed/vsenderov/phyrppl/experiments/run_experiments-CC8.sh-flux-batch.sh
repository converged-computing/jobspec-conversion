#!/bin/bash
#FLUX: --job-name=fat-chip-4809
#FLUX: --urgency=16

export OMP_STACKSIZE=' 32G" '
export RPPL_FLAGS=' --target omp -j $NCORES"    # OMP'

ulimit -s unlimited
export OMP_STACKSIZE=" 32G" 
MODEL=CombineDS   # CombineDS is the version that uses recursion, i.e. _not_ CUDA optimized
TREE=CC8
AGE=29.98
RHO=0.66
L0EST0=0.32
L0EST2=0.40
NCORES=28
PART=20000
ITER=100
LSH=1.0
LSC=1.0
MSH=1.0
MSC=0.5
NSH=1.0
NSC=1.0                # Base rate, will rescale
C1=0.0
C2=1.0
C3=3.0
C4=2.0                 # Base rate, will rescale
G1=0.0
G2=1.0
G3=3.0
G4=2.0                 # Base rate, will rescale 
STEP=0.1
GUA=`echo "scale = 2; 2.0 / $STEP" | bc`              # Base rate, will rescale
export RPPL_FLAGS=" --target omp -j $NCORES"    # OMP
cd ..
NSCN=`echo "scale = 2; $NSC / $AGE" | bc`
GUAN=`echo "$GUA*$AGE" | bc | awk '{print int($1+0.5)}'`
G4N=`echo "scale = 2; $G4/$AGE" | bc`
C4N0=`echo "scale = 2; $C4 / $AGE / $L0EST0" | bc`
C4N2=`echo "scale = 2; $C4 / $AGE / $L0EST2" | bc`
./runppl.sh $MODEL $TREE $RHO $LSH $LSC $MSH $MSC $NSH $NSCN $C1 $C2 $C3 $C4N0 $G1 $G2 $G3 $G4N true 0 0 9999 $GUAN true $PART $ITER $NCORES 1 clads0 
./runppl.sh $MODEL $TREE $RHO $LSH $LSC $MSH $MSC $NSH $NSCN $C1 $C2 $C3 $C4N2 $G1 $G2 $G3 $G4N true 2 0 9999 $GUAN true $PART $ITER $NCORES 1 clads2 
echo ./runppl.sh $MODEL $TREE $RHO $LSH $LSC $MSH $MSC $NSH $NSCN $C1 $C2 $C3 $C4N0 $G1 $G2 $G3 $G4N true 0 0 9999 $GUAN true $PART $ITER $NCORES 1 clads0 
echo ./runppl.sh $MODEL $TREE $RHO $LSH $LSC $MSH $MSC $NSH $NSCN $C1 $C2 $C3 $C4N2 $G1 $G2 $G3 $G4N true 2 0 9999 $GUAN true $PART $ITER $NCORES 1 clads2 
