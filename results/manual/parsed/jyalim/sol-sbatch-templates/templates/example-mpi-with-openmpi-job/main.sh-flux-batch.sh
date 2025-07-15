#!/bin/bash
#FLUX: --job-name=ornery-omelette-5483
#FLUX: --priority=16

echo NODELIST: $SLURM_NODELIST
echo TASKS-PER-NODE: $SLURM_TASKS_PER_NODE
echo CORES-PER-TASK: ${SLURM_CPUS_PER_TASK:-1}
module load openmpi/4.1.5 # This is synonymous with hpcx/2.13.1
echo "Running linux program \`hostname\` on each compute node"
srun --export=ALL --mpi=pmix "hostname"
echo "Running networking benchmark \`osu_bibw\` between alloc. nodes"
srun --export=ALL --mpi=pmix "$HPCX_OSU_DIR/osu_bibw"
echo "Compiling a simple test C program"
mpicc $HPCX_MPI_TESTS_DIR/examples/hello_c.c -o hello
echo "Executing simple test C program"
srun --export=ALL --mpi=pmix "./hello"
