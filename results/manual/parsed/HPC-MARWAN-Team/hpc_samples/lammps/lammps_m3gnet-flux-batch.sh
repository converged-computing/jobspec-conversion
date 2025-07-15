#!/bin/bash
#FLUX: --job-name=quirky-pastry-2260
#FLUX: --queue=shortq
#FLUX: --urgency=16

export WORK_DIR='/scratch/users/$USER/workdir/LMP${SLURM_JOB_ID}'
export INPUT_DIR='$PWD/input_MD_M3GNET'
export LAMMPS_COEFF='$PWD   # chemin vers le dossier contenant le dossier MP-2021.2.8-EFS'
export PYTHONPATH='$LAMMPS_POTENTIALS/M3GNET:$LAMMPS_COEFF/:$PYTHONPATH'

module load M3GNet/0.2.4-foss-2022a
module load LAMMPS/2Aug2023_M3gnet
export WORK_DIR=/scratch/users/$USER/workdir/LMP${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input_MD_M3GNET
export LAMMPS_COEFF=$PWD   # chemin vers le dossier contenant le dossier MP-2021.2.8-EFS
export PYTHONPATH=$LAMMPS_POTENTIALS/M3GNET:$LAMMPS_COEFF/:$PYTHONPATH
[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR/
echo "Running Lammps  at : $WORK_DIR"
 lmp -in inp01.llto
echo "JOB Done"
