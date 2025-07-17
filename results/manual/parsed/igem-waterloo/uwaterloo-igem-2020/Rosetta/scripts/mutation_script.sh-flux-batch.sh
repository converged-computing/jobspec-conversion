#!/bin/bash
#FLUX: --job-name=expensive-cherry-3973
#FLUX: -t=7200
#FLUX: --urgency=16

ROSETTA3="/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/rosetta/3.10"
ROSETTA3_DB="/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/rosetta/3.10/database"
module load nixpkgs/16.09  gcc/7.3.0  openmpi/3.1.2 rosetta/3.10
relaxed_files=
backrub_files=
mutated_files=
python $ROSETTA3/tools/protein_tools/scripts/clean_pdb.py 5icu.pdb ignorechain
$ROSETTA3/bin/score_jd2.mpi.linuxiccrelease -in:file:s 5icu_HETATM.pdb -ignore_unrecognized_res -out:path:all $output_files -out:suffix _original
$ROSETTA3/bin/relax.mpi.linuxiccrelease -in:file:s 5icu_HETATM.pdb -out:path:all $relaxed_files -nstruct 10
$ROSETTA3/bin/pmut_scan_parallel.mpi.linuxiccrelease -in:file:s 5icu_HETATM_relaxed.pdb @pmut.flags
$ROSETTA3/bin/score_jd2.mpi.linuxiccrelease -in:file:l score_pdb.txt -ignore_unrecognized_res -out:path:all $mutated_files
