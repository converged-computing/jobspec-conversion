#!/bin/bash
#FLUX: --job-name="BzBone00"
#FLUX: -n=4
#FLUX: --queue=cpu-3g
#FLUX: -t=86400
#FLUX: --priority=16

echo
echo "============================ Messages from Goddess ============================"
echo " * Job starting from: "date
echo " * Job ID           : "$SLURM_JOBID
echo " * Job name         : "$SLURM_JOB_NAME
echo " * Job partition    : "$SLURM_JOB_PARTITION
echo " * Nodes            : "$SLURM_JOB_NUM_NODES
echo " * Cores            : "$SLURM_NTASKS
echo " * Working directory: "${SLURM_SUBMIT_DIR/$HOME/"~"}
echo "==============================================================================="
echo
module load opt gcc mpi lammps/mpi
module load python/3.9.13-cpu
source ~/Bone/BzBone/bin/activate
SUBMIT_DIR="${SLURM_SUBMIT_DIR}"
IO_DIR="${SUBMIT_DIR}/io"
SRC_DIR="${SUBMIT_DIR}/src"
PYTHON_EXEC="python3"
SLC2CUBE_EXEC="${SRC_DIR}/Img2Off/IMG2OFF.py"
OFF2Particle_EXEC="${SRC_DIR}/OFF2Particle/run_off2particle.sh"
PTC2DATA_EXEC="${SRC_DIR}/Particle2Cube/ptc2data.py"
sed -i "s|mn_dir = .*|mn_dir = \"${SUBMIT_DIR}\"|g" ${SLC2CUBE_EXEC}
sed -i "s|mn_dir = .*|mn_dir = \"${SUBMIT_DIR}\"|g" ${PTC2DATA_EXEC}
sed -i "s|mn_dir=".*"|mn_dir=\"${SUBMIT_DIR}\"|g" ${OFF2Particle_EXEC}
$PYTHON_EXEC $SLC2CUBE_EXEC
sh $OFF2Particle_EXEC
$PYTHON_EXEC $PTC2DATA_EXEC
echo
echo "============================ Messages from Goddess ============================"
echo " * Job ended at     : "date
echo "==============================================================================="
echo
