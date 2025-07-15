#!/bin/bash
#FLUX: --job-name=frigid-platanos-1794
#FLUX: --urgency=16

spack env deactivate
spack env activate -d /opt/spack-pkg-env
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
