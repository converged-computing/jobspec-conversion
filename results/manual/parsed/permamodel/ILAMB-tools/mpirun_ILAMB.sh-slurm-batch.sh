#!/bin/bash
#SBATCH --output=ilamb_%j.log
#SBATCH --mail-user=kawa6889@colorado.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=96GB
#SBATCH --qos=blanca-csdms

export ILAMB_ROOT='$PWD'
export PYTHONPATH='$PYTHONPATH:$PWD'

module purge
module load intel
module load impi
module load loadbalance
source activate ilamb_base
cd /rc_scratch/kawa6889/ILAMB
export ILAMB_ROOT=$PWD
export PYTHONPATH=/projects/kawa6889/miniconda3/envs/ilamb_base/
export PYTHONPATH=$PYTHONPATH:$PWD
rm -rf _build
mpirun -n 8 ilamb-run --config test.cfg --model_root $ILAMB_ROOT/MODELS/ --regions global --clean
tar -zcvf ilamb.tar.gz _build
