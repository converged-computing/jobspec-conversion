#!/bin/bash
#FLUX: --job-name="BzBone00"
#FLUX: --queue=trans
#FLUX: -t=259200
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
module purge
module load gcc/11.4.0
module load miniconda3/24.1.2
module load lammps
conda activate BzBone
JOB_NUM="001"
WORK_DIR="/work/u9132064"
SUBMIT_DIR="${SLURM_SUBMIT_DIR}"
IO_DIR="${WORK_DIR}/io${JOB_NUM}"
SRC_DIR="${SUBMIT_DIR}/src"
PYTHON_EXEC="python3"
SLC2CUBE_EXEC="${SRC_DIR}/Img2Off/B_IMG2OFF.py"
OFF2Particle_EXEC="${SRC_DIR}/OFF2Particle/run_off2particle.sh"
PTC2DATA_EXEC="${SRC_DIR}/Particle2Cube/B_ptc2data.py"
sed -i "s|mn_dir = .*|mn_dir = \"${SUBMIT_DIR}\"|g" ${SLC2CUBE_EXEC}
sed -i "s|mn_dir = .*|mn_dir = \"${SUBMIT_DIR}\"|g" ${PTC2DATA_EXEC}
sed -i "s|mn_dir=".*"|mn_dir=\"${SUBMIT_DIR}\"|g" ${OFF2Particle_EXEC}
N_SLC2CUBE_EXEC="${SLC2CUBE_EXEC%.*}${JOB_NUM}${SLC2CUBE_EXEC##*.}" 
N_OFF2Particle_EXEC="${OFF2Particle_EXEC%.*}${JOB_NUM}${OFF2Particle_EXEC##*.}"
N_PTC2DATA_EXEC="${PTC2DATA_EXEC%.*}${JOB_NUM}${PTC2DATA_EXEC##*.}"
sed "s|io_dir = .*|io_dir = \"${IO_DIR}\"|g" ${SLC2CUBE_EXEC} > ${N_SLC2CUBE_EXEC}
$PYTHON_EXEC $N_SLC2CUBE_EXEC
rm $N_SLC2CUBE_EXEC
sed "s|IO_DIR=.*|IO_DIR=\"${IO_DIR}\"|g" ${OFF2Particle_EXEC} > ${N_OFF2Particle_EXEC}
sh $N_OFF2Particle_EXEC
rm $N_OFF2Particle_EXEC
sed "s|io_dir = .*|io_dir = \"${IO_DIR}\"|g" ${PTC2DATA_EXEC} > ${N_PTC2DATA_EXEC}
$PYTHON_EXEC $N_PTC2DATA_EXEC
rm $N_PTC2DATA_EXEC
echo
echo "============================ Messages from Goddess ============================"
echo " * Job ended at     : "date
echo "==============================================================================="
echo
