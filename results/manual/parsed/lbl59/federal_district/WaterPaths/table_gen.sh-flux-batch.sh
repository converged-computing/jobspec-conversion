#!/bin/bash
#FLUX: --job-name=callgrind
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='16                       # tell the cube to use all 16 core within the node to run this'

module load valgrind
export OMP_NUM_THREADS=16                       # tell the cube to use all 16 core within the node to run this
cd $SLURM_SUBMIT_DIR
valgrind --tool=memcheck --leak-check=full --track-origins=yes --log-file=valgrind_memcheck.out ./triangleSimulation\
	-T 16\
        -t 2080\
        -r 1\
        -d /scratch/spec1058/WaterPaths/\
        -C 1\
	-m 0\
	-s sample_solutions.csv\
        -O rof_tables_valgrind/\
        -e 0\
        -U TestFiles/utilities_rdm.csv\
        -W TestFiles/water_sources_rdm.csv\
        -P TestFiles/policies_rdm.csv\
	-p false
