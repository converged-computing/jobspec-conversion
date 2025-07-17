#!/bin/bash
#FLUX: --job-name=iPic3D
#FLUX: --queue=boost_usr_prod
#FLUX: -t=1200
#FLUX: --urgency=16

source ${HOME}/modules_files/iPic3D_mod
DIR="${HOME}/programming/iPic3D/"
cd $DIR
branch="coils"
scorep_check="n"
if [ ${branch} = "master" ]; then
	if [ ${scorep_check} = "n" ]; then
		## normal compilation
		mkdir -p build/
		cd build/
		mkdir -p data/
		cmake .. > cmakeout_prova 2>&1
		time make -j -B > makeout_prova 2>&1
		mpirun -np 4 ./iPic3D ${DIR}/inputfiles/GEM.inp
	elif [ ${scorep_check} = "y" ]; then
		## compile iPic with scorep
		source ${HOME}/my_programs/ON_spack_scorep
		mkdir -p build_scorep/
		cd build_scorep/
		mkdir -p data/
		SCOREP_WRAPPER=off cmake .. -DCMAKE_CXX_COMPILER=scorep-g++ > cmakeout_prova 2>&1
		#export SCOREP_ENABLE_TRACING=true
		export SCOREP_TOTAL_MEMORY=4G
		time make -j -B > makeout_prova 2>&1
		scan mpirun -np 4 ./iPic3D ${DIR}/inputfiles/GEM.inp
		square -s scorep_*
	fi
elif [ ${branch} = "coils" ]; then
	if [ ${scorep_check} = "n" ]; then
		## normal compilation
		mkdir -p build_coils/
		cd build_coils/
		mkdir -p data/
		cmake .. -DIPIC_PETSC_SOLVER=ON > cmakeout_prova 2>&1
		time make -j -B > makeout_prova 2>&1
		mpirun -np 4 ./iPic3D ${DIR}/inputfiles/GEM_forCoils.inp
	elif [ ${scorep_check} = "y" ]; then
		## compile iPic with scorep
		source ${HOME}/my_programs/ON_spack_scorep
		mkdir -p build_coils_scorep/
		cd build_coils_scorep/
		mkdir -p data/
		SCOREP_WRAPPER=off cmake .. -DCMAKE_CXX_COMPILER=scorep-g++ -DIPIC_PETSC_SOLVER=ON > cmakeout_prova 2>&1
		#export SCOREP_ENABLE_TRACING=true
		export SCOREP_TOTAL_MEMORY=4G
		time make -j -B > makeout_prova 2>&1
		scan mpirun -np 4 ./iPic3D ${DIR}/inputfiles/GEM_forCoils.inp
		square -s scorep_*
	fi	
elif [ ${branch} = "EB" ]; then
	if [ ${scorep_check} = "n" ]; then
		## normal compilation
		mkdir -p build_EB/
		cd build_EB/
		mkdir -p data/
		cmake .. > cmakeout_prova 2>&1
		time make -j -B > makeout_prova 2>&1
		mpirun -np 4 ./iPic3D ${DIR}/inputfiles/GEM.inp
	elif [ ${scorep_check} = "y" ]; then
		## compile iPic with scorep
		source ${HOME}/my_programs/ON_spack_scorep
		mkdir -p build_EB_scorep/
		cd build_EB_scorep/
		mkdir -p data/
		SCOREP_WRAPPER=off cmake .. -DCMAKE_CXX_COMPILER=scorep-g++ > cmakeout_prova 2>&1
		#export SCOREP_ENABLE_TRACING=true
		export SCOREP_TOTAL_MEMORY=4G
		time make -j -B > makeout_prova 2>&1
		scan mpirun -np 4 ./iPic3D ${DIR}/inputfiles/GEM.inp
		square -s scorep_*
fi
