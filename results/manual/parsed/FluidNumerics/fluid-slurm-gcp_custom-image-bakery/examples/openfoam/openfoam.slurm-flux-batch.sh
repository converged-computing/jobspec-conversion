#!/bin/bash
#FLUX: --job-name=joyous-peanut-3065
#FLUX: -n=8
#FLUX: --queue=openfoam
#FLUX: --urgency=16

source /etc/profile.d/openmpi.sh
source /etc/profile.d/openfoam.sh
gcc --version
cp -r ${FOAM_TUTORIALS}/compressible/rhoSimpleFoam/aerofoilNACA0012 ./
cd aerofoilNACA0012
cat > ./system/decomposeParDict <<EOL
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    object      decomposeParDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
numberOfSubdomains ${SLURM_NTASKS};
method          scotch;
EOL
. $WM_PROJECT_DIR/bin/tools/RunFunctions
cp $FOAM_TUTORIALS/resources/geometry/NACA0012.obj.gz constant/geometry/
runApplication blockMesh
runApplication transformPoints -scale "(1 0 1)"
runApplication extrudeMesh
decomposePar
mpirun -np ${SLURM_NTASKS} rhoSimpleFoam -parallel
reconstructPar
touch naca0012.foam
