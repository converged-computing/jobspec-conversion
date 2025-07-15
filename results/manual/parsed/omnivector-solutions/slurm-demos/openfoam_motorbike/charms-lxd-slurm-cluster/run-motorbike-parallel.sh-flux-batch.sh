#!/bin/bash
#FLUX: --job-name=expensive-signal-1138
#FLUX: -n=6
#FLUX: --urgency=16

OPENFOAM_DIR=/nfs/OpenFOAM-10
if [[ ! -d $OPENFOAM_DIR ]]
then
    echo "Cloning OpenFOAM-10"
    cd /nfs
    git clone https://github.com/OpenFOAM/OpenFOAM-10.git
else
    echo "Skipping clone process...we already have the OpenFOAM-10 source code"
fi
SINGULARITY_IMAGE=/nfs/openfoam10.sif
SINGULARITY_SANDBOX=openfoam10-sandbox
SINGULARITY_SANDBOX_PATH=/nfs/$SINGULARITY_SANDBOX
if [[ ! -d $SINGULARITY_SANDBOX_PATH ]]
then    
    cd /nfs
    # download the openfoam v10 singularity image if it is not available yet
    if [[ ! -f $SINGULARITY_IMAGE ]]
    then
        echo "Fetching the singularity image for OpenFOAM-10"
        curl -o $SINGULARITY_IMAGE --location "https://omnivector-public-assets.s3.us-west-2.amazonaws.com/singularity/openfoam10.sif"        
    else
        echo "Skipping the image fetch process...we already have the singularity image"
    fi
    # build the singularity sandbox
    echo "Building OpenFOAM-10 singularity sandbox"
    singularity build --sandbox $SINGULARITY_SANDBOX $SINGULARITY_IMAGE
else
    echo "Skipping the sandbox building process...we already have the singularity sandbox"
fi
WORK_DIR=/nfs/$SLURM_JOB_NAME-Job-$SLURM_JOB_ID
mkdir -p $WORK_DIR
cd $WORK_DIR
cp -r $OPENFOAM_DIR/tutorials/incompressible/simpleFoam/motorBike .
cd motorBike
singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH ./Allclean
cp $OPENFOAM_DIR/tutorials/resources/geometry/motorBike.obj.gz constant/geometry/
singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH surfaceFeatures
singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH blockMesh
singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH decomposePar -copyZero
srun --mpi=pmi2 singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH snappyHexMesh -overwrite -parallel
srun --mpi=pmi2 singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH patchSummary -parallel
srun --mpi=pmi2 singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH potentialFoam -parallel
srun --mpi=pmi2 singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH simpleFoam -parallel
singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH reconstructParMesh -constant
singularity exec --bind $PWD:$HOME $SINGULARITY_SANDBOX_PATH reconstructPar -latestTime
touch motorbike.foam
