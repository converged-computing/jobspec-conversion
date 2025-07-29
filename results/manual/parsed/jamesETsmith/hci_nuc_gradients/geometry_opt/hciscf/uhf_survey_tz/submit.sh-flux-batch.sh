#!/bin/bash
#FLUX: --job-name=${USER_JOB_NAME}
#FLUX: --exclusive
#FLUX: --queue=${USER_PARTITION}
#FLUX: --urgency=16

export OMP_NUM_THREADS='${USER_OMP_NUM_THREADS}'
export TMP='${USER_TMP}'
export TEMP='${USER_TMP}'
export TMPDIR='${USER_TMP}'

PARAM=$1
MULT=$2
SPECIES=$3
USER_NODES=1
USER_TIME="72:00:00"
SPACK_ENV="amd-rome"
USER_JOB_NAME="${PARAM}_${MULT}_${SPECIES}"
USER_OMP_NUM_THREADS=96
USER_VERBOSE=true
USER_OUTPUT="slurm.out"
USER_TMP="/scratch"
USER_PARTITION="ccq" # Other options: "genx", "ccq", "mem", "bnl", "bnlx", "gpu"
if ${USER_VERBOSE}
then
echo "General Settings"
echo "================"
echo "Activating Spack Env = ${SPACK_ENV}"
echo "Wall time limit = ${USER_TIME}"
echo "Job Name = ${USER_JOB_NAME}"
echo "Partition = ${USER_PARTITION}"
echo "Using tmp directory = ${USER_TMP}"
echo "Number of node(s) = ${USER_NODES}"
echo "Setting OMP_NUM_THREADS = ${USER_OMP_NUM_THREADS}"
echo "Slurm output file = ${USER_OUTPUT}"
echo ""
fi
echo "#!/bin/bash
echo "Processor Info"
echo "=============="
lscpu
cat /sys/devices/cpu/caps/pmu_name
echo ""
echo "Memory Info"
echo "==========="
head -n 2 /proc/meminfo
echo ""
source ~/apps/spack/share/spack/setup-env.sh
spack env activate ${SPACK_ENV}
source ~/apps/amd-rome/pyscf/pyscf_env.sh
echo ""
echo ""
../../run_pyscf.sh ${MULT} ${SPECIES}
" > _slurm_batch.sh
sbatch _slurm_batch.sh
rm _slurm_batch.sh # Comment out to see record of slurm job
