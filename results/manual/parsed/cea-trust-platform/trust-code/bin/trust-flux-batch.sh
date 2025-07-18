#!/bin/bash
#FLUX: --job-name=blue-underoos-8493
#FLUX: --urgency=16

export NB_PROCS='1 '

if [ -f ld_env.sh ]
then
   . ./ld_env.sh
fi
qsub_interactif()
{   
   # Provisoire qsub ne marche pas donc on lance direct:
   id=`cat $sub_file | qsub | $TRUST_Awk -F . '{print $1}'`
   # Attente de la fin du job
   while [ "`qstat -a | grep $id`" != "" ]
   do
      sleep 3
   done
}
bsub_interactif()
{
   # Provisoire bsub -I desactive sur argent donc on lance direct:
   id=`cat $sub_file | bsub | $TRUST_Awk '{gsub("<","",$2);gsub(">","",$2);print $2}'`
   # Attente de la fin du job
   while [ "`qstat -a | grep $id`" != "" ]
   do
      sleep 3
   done
}
sbatch_interactif()
{
   # Submit the job and returns the id:
   err=1
   while [ "$err" = 1 ]
   do
      id=`sbatch $sub_file 2>&1`
      err=$?
      # Wait if several jobs launched
      if [ $err = 1 ]
      then
         if [ "`echo $id | grep 'Job violates accounting'`" != "" ]
         then
	    echo "Waiting, cause several jobs submitted:"
	    squeue -u $me -p $queue
	    sleep 60
	 else
	    # Unknown error
            echo $id && exit -1 
	 fi
      fi     
   done
   id=`echo $id | $TRUST_Awk '/Submitted batch/ {print $NF}'`
   echo "Job $id submitted."
   echo "Waiting the end of the job $id..."
   while [ "`squeue -h -j $id 2>/dev/null`" != "" ]
   do
      sleep 3
   done
}
ccc_msub_interactif()
{
   # Submit the job and returns the id:
   err=1
   while [ "$err" = 1 ]
   do
      id=`ccc_msub $sub_file 2>&1`
      err=$?
      # Wait if several jobs launched
      if [ $err = 1 ]
      then
         if [ "`echo $id | grep 'Job violates accounting'`" != "" ]
         then
	    echo "Waiting, cause several jobs submitted:"
	    #qstat -u $me $queue
	    #ccc_mpstat -u $me $queue
	    squeue -u $me -p $queue
	    sleep 60
	 else
	    # Unknown error
            echo $id && exit -1 
	 fi
      fi     
   done
   id=`echo $id | $TRUST_Awk '/Session/ {print $4}'`
   echo "Job $id submitted."
   echo "Waiting the end of the job $id..."
   #while [ "`qstat -u $me | grep $id`" != "" ]
   #while [ "`ccc_mpstat -u $me | grep $id`" != "" ]
   while [ "`squeue -h -j $id 2>/dev/null`" != "" ]
   do
      sleep 3
   done
}
help()
{
   echo "Usage: `basename $0` [option] datafile [nb_cpus] [1>file.out] [2>file.err]"
   echo "Where option may be:"
   echo "-help|-h                      : List options."
   echo "-baltik [baltik_name]         : Instanciate an empty Baltik project."
   echo "-index                        : Access to the TRUST ressource index."
   echo "-doc                          : Access to the TRUST manual (Generic Guide)."
   echo "-html                         : Access to the doxygen documentation."
   echo "-config nedit|vim|emacs|gedit : Configure nedit or vim or emacs or gedit with TRUST keywords."
   echo "-edit                         : Edit datafile."
   echo "-xcheck                       : Check the datafile's keywords with xdata."
   echo "-xdata                        : Check and run the datafile's keywords with xdata."
   echo "-partition                    : Partition the mesh to prepare a parallel calculation (Creation of the .Zones files)."
   echo "-mesh                         : Visualize the mesh(es) contained in the data file."
   echo "-eclipse-trust                : Generate Eclipse configuration files to import TRUST sources."
   echo "-eclipse-baltik               : Generate Eclipse configuration files to import BALTIK sources (TRUST project should have been configured under Eclipse)."
   echo "-probes                       : Monitor the TRUST calculation only."
   echo "-evol                         : Monitor the TRUST calculation (GUI)."
   echo "-prm                          : Write a prm file (deprecated)."
   echo "-jupyter                      : Create basic jupyter notebook file."
   echo "-clean                        : Clean the current directory from all the generated files by TRUST."
   echo "-search keywords              : Know the list of test cases from the data bases which contain keywords."
   echo "-copy                         : Copy the test case datafile from the TRUST database under the present directory."
   echo "-check all|testcase|list            : Check the non regression of all the test cases or a single test case or a list of tests cases specified in a file."
   echo "-check function|class|class::method : Check the non regression of a list of tests cases covering a function, a class or a class method."
   echo "-ctest all|testcase|list            : ctest the non regression of all the test cases or a single test case or a list of tests cases specified in a file."
   echo "-ctest function|class|class::method : ctest the non regression of a list of tests cases covering a function, a class or a class method."
   echo "-gdb                          : Run under gdb debugger."
   echo "-valgrind                     : Run under valgrind."
   echo "-valgrind_strict              : Run under valgrind with no suppressions."
   echo "-callgrind                    : Run callgrind tool (profiling) from valgrind."
   echo "-massif                       : Run massif tool (heap profile) from valgrind." 
   echo "-heaptrack                    : Run heaptrack (heap profile). Better than massif."
   echo "-advisor                      : Run advisor tool (vectorization)."
   echo "-vtune                        : Run vtune tool (profiling). Best profiler tool."
   echo "-perf                         : Run perf tool (profiling)."
   echo "-trace                        : Run traceanalyzer tool (MPI profiling)."
   [ "`nsys --version 1>/dev/null 2>&1;echo $?`" = 0 ] && echo "-nsys                         : Run Nsight system tool (GPU profiling)."
   [ "`ncu --version 1>/dev/null 2>&1;echo $?`" = 0 ] && echo "-ncu                         : Run Nsight compute tool (GPU Kernel profiling)."
   [ "`compute-sanitizer --version 1>/dev/null 2>&1;echo $?`" = 0 ] && echo "-cs memcheck|racecheck|initcheck|synccheck : Run compute sanitizer tool (GPU debugging)."
   echo "-create_sub_file              : Create a submission file only."
   echo "-prod                         : Create a submission file and submit the job on the main production class with exclusive resource."
   echo "-bigmem                       : Create a submission file and submit the job on the big memory production class."
   echo "-queue queue                  : Create a submission file with the specified queue and submit the job."
   echo "-c ncpus                      : Use ncpus CPUs allocated per task for a parallel calculation."
[ "$TRUST_USE_CUDA" = 1 ] && echo "-gpu                    : Create a submission file and submit the job on production class with GPU cards."
   echo "datafile -help_trust          : Print options of TRUST_EXECUTABLE [CASE[.data]] [options]."
   echo "-convert_data datafile        : Convert a data file to the new 1.9.1 syntax (milieu, interfaces, read_med and champ_fonc_med)."
   exit 0
}
binary=$exec
ici=`pwd`   
me=`whoami`
edit=""
xedit=""
xcheck=""
xdata=""
partition=""
mesh=""
monitor=""
probes=""
prm=""
copy=""
gdb=""
taches=""
cpus_per_task=""
gpus_per_node=""
hintnomultithread=""
[ "$prod" = "" ] && prod=0
[ "$bigmem" = "" ] && bigmem=0
[ "$gpu" = "" ] && gpu=0
[ "$node" = "" ] && node=0
USE_MPIRUN=0 # Variable interne, plus modifiable par l'utilisateur
supported_option=1
while [ "$supported_option" = 1 ]
do
   if [ "$1" = "" ] || [ "$1" = -help ] || [ "$1" = -h ]
   then
      help
      exit 0
   elif [ "$1" = "-config" ]
   then
      shift
      if [ "$1" = nedit ]
      then
         # Configure nedit
	 Language_mode_TRUST.sh #-no_verbose
	 exit 0
      elif [ "$1" = vim ]
      then
         # Configure vim
	 configure_vim.sh && exit 0
      elif [ "$1" = emacs ]
      then
         # Configure emacs
	 configure_emacs.sh && exit 0
      elif [ "$1" = gedit ]
      then
         # Configure gedit
	 configure_gedit.sh && exit 0
      else
         help
      fi
   elif [ "$1" = "-doc" ]
   then
      doc=$TRUST_ROOT/doc/TRUST/TRUST_Generic_documentation.pdf
      if [ -f $doc ]
      then
         for app in xpdf evince kpdf okular
         do
            $app $doc 1>/dev/null 2>&1 && exit 0
         done
         echo "No PDF reader found!"
         exit -1
      else
	 echo "$doc not found!" 
	 exit -1
      fi
   elif [ "$1" = "-html" ]
   then
      if [ "$project_directory" != "" ]
      then
         doc=$project_directory/build/html/index.html
         [ ! -f $doc ] && doc=$TRUST_ROOT/doc/html/index.html
      else
         doc=$TRUST_ROOT/doc/html/index.html
      fi
      if [ -f $doc ]
      then
         ($TRUST_WEBBROWSER $doc &) && exit 0
      else
        echo "$doc not found!"
        exit -1
      fi
   elif [ "$1" = "-baltik" ]
   then
      [ -f bin/trust ] && echo "Can't be run at $TRUST_ROOT" && exit -1 
      shift
      if [ "$1" != "" ] 
      then
         baltik_name=$1
         mkdir -p $baltik_name
         cd $baltik_name
      fi
      echo "Creating an empty Baltik project under `pwd` ..."
      echo "Copying a template from \$TRUST_ROOT/bin/baltik/templates/basic ..."
      cp -r $TRUST_ROOT/bin/baltik/templates/basic/* .
      echo "Changing the project configuration file project.cfg ..."
      sed -i "1,$ s?TRUST?`whoami 2>/dev/null`?g" project.cfg
      project=`pwd` && project=`basename $project`
      sed -i "1,$ s?basic?$project?g" project.cfg
      # Update src/Version_kernel
      echo $TRUST_VERSION > src/Version_kernel
      echo "Suppressing Hello World examples from the project ..."
      rm -r -f src/Hello.* tests/Reference/New/Hello tests/Reference/New/new tests/Reference/Validation/Hello_world_jdd1 share/Validation/Rapports_automatiques/Hello_world
      echo "Running baltik_build_configure..."
      baltik_build_configure
      echo "Read the README.BALTIK file to know more about Baltik projects." 
      #./configure && make check_optim
      exit 0
   elif [ "$1" = "-index" ]
   then
      ($TRUST_WEBBROWSER $TRUST_ROOT/index.html &) && exit 0  
   elif [ "$1" = "-exec" ] ||  [ "$1" = "-exe" ]
   then
      shift
      binary=$1
   elif [ "$1" = "-copy" ]
   then
      copy=1
   elif [ "$1" = "-edit" ]
   then
      edit=1
   elif [ "$1" = "-xedit" ]
   then
      xedit=1
   elif [ "$1" = "-xcheck" ]
   then
      xcheck=1
   elif [ "$1" = "-xdata" ]
   then
      xdata=1
   elif [ "$1" = "-partition" ]
   then
      partition=1
   elif [ "$1" = "-mesh" ]
   then
      mesh=1
   elif [ "$1" = "-eclipse-trust" ]
   then
      [ -d eclipse-trust-config ] && echo "Error: eclipse-trust-config folder already available. Please rename or remove this folder before typing trust -eclipse-trust." && exit -1
      cp -r $TRUST_ROOT/Outils/eclipse/eclipse-trust eclipse-trust-config
      project_name="TRUST-$TRUST_VERSION"
      [ "`echo $TRUST_ROOT | grep tmptrust`" != "" ] || [ "`echo $TRUST_ROOT | grep trust_trio`" != "" ] && project_name=$project_name"_Network"
      eclipseconfigpath=`pwd`"/eclipse-trust-config"
      sed -i "s/TRUSTV/$project_name/; s?TRUSTROOT?$TRUST_ROOT?g" $eclipseconfigpath/.project
      sed -i "s/TRUSTV/$project_name/; s?TRUSTROOT?$TRUST_ROOT?g; s?eclipse-config?$eclipseconfigpath/..?g" $eclipseconfigpath/TRUST_debug_in_Eclipse.launch
      mv eclipse-trust-config/TRUST_debug_in_Eclipse.launch eclipse-trust-config/$project_name"_Debug.launch"
      sed -i "s?eclipse-config?$eclipseconfigpath?g; s?project_name?$project_name?g" $eclipseconfigpath/README
      echo "Eclipse project $project_name successfully configured (with CDT builder disabled) under $eclipseconfigpath"
      echo "You shoud run Eclipse and import this project."
      cat $eclipseconfigpath/README
      [ ! -d upwind ] && copie_cas_test upwind && sed -i "s/Format lml/Format lata/g" upwind/upwind.data
      echo "When this is done, the directory $eclipseconfigpath can be removed."
      if [ ! -f $exec_debug ]
      then
         echo "*************************************************************************************"
         echo "Warning : TRUST debug executable \$exec_debug not available. You can generate it by:"
         echo "cd $TRUST_ROOT"
         echo "make debug"
         echo "*************************************************************************************"
      fi
      exit 0
   elif [ "$1" = "-eclipse-baltik" ]
   then
      if [ "$project_directory" = "" ]
      then
         echo "Error: You should load the env_BALTIK.sh of your baltik project"
         exit -1
      elif [ "`pwd`" != "$project_directory" ]
      then
         echo "You loaded the wrong baltik project or you are trying to configure eclipse for the wrong project"
         echo "Loaded project is under $project_directory"
         echo "Your current directory is `pwd`"
         exit -1
      elif [ -f $project_directory/src/.project ] || [ -f $project_directory/src/.cproject ]
      then
         echo "Error: Your project is already configured with eclipse."
         echo "If you want to reconfigure it, delete $project_directory/src/.project and $project_directory/src/.cproject"
         echo "than re-run: trust -eclipse-baltik."
         exit -1
      fi
      trust_project_name="TRUST-$TRUST_VERSION"
      baltik_project_name=`grep "^name" $project_directory/project.cfg | cut -f 2 -d':' | sed 's/ *//g' | head -1`
      [ "$baltik_project_name" = "" ] && echo "Fatal error, your baltik project has no name ? " && exit -1
      [ "`echo $TRUST_ROOT | grep trust_trio`" != "" ] && trust_project_name=$trust_project_name"_Network"
      eclipseconfigpath=$TRUST_ROOT/Outils/eclipse/eclipse-baltik
      sed "s/TRUSTName/$trust_project_name/; s?BaltikName?$baltik_project_name?g" $eclipseconfigpath/.project > $project_directory/src/.project
      sed "s?BaltikName?$baltik_project_name?g; s?BaltikDirectory?$project_directory?g" $eclipseconfigpath/.cproject > $project_directory/src/.cproject
      sed "s?BaltikName?$baltik_project_name?g; s?BaltikDirectory?$project_directory?g ; s?BaltikExecDebug?$exec_debug?g ; s?TRUSTROOT?$TRUST_ROOT?g" $eclipseconfigpath/Baltik_Debug.launch > $project_directory/src/$baltik_project_name"_Debug.launch"
      sed "s?BaltikDirectory?$project_directory?g; s?project_name?$baltik_project_name?g" $eclipseconfigpath/README > $project_directory/README_BALTIK_ECLIPSE
      echo "Eclipse project $baltik_project_name successfully configured (with CDT builder enabled) under $project_directory/src"
      echo "You shoud run Eclipse and import this project."
      cat $project_directory/README_BALTIK_ECLIPSE
      if [ ! -d $project_directory/build/upwind ]
      then
         cp -r $TRUST_ROOT/tests/Reference/upwind $project_directory/build/
         sed -i "s/Format lml/Format lata/g" $project_directory/build/upwind/upwind.data
      fi
      if [ ! -f $exec_debug ]
      then
         echo "*************************************************************************************"
         echo "Warning : Your project's debug executable \$exec_debug not available. You can generate it by:"
         echo "cd $project_directory"
         echo "make debug"
         echo "or from eclipse once your project configured"
         echo "*************************************************************************************"
      fi
      exit 0
   elif [ "$1" = "-c" ]
   then
      shift && cpus_per_task=$1
   elif [ "$1" = "-gpus_per_node" ]
   then
      shift && gpus_per_node=$1
   elif [ "$1" = "-monitor" ]
   then
      monitor=1
   elif [ "$1" = "-probes" ]
   then
      probes=1
   elif [ "$1" = "-evol" ]
   then
      probes=2
   elif [ "$1" = "-create_sub_file" ]
   then
      create_sub_file=1 && prod=1 #&& node=1
   elif [ "$1" = "-queue" ]
   then
      shift && queue_choisie=$1
   elif [ "$1" = "-prod" ]
   then
      prod=1 && node=1
   elif [ "$1" = "-gpu" ]
   then
      gpu=1 && soumission=1
   elif [ "$1" = "-bigmem" ]
   then
      bigmem=1
   elif [ "$1" = "-ipm" ]
   then
      ipm=1
   elif [ "$1" = "-valgrind" ]
   then 
      VALGRIND=1
   elif [ "$1" = "-valgrind_strict" ]
   then
      VALGRIND_STRICT=1
   elif [ "$1" = "-callgrind" ]
   then 
      CALLGRIND=1
   elif [ "$1" = "-massif" ]
   then 
      MASSIF=1
   elif [ "$1" = "-heaptrack" ]
   then
      HEAPTRACK=1
   elif [ "$1" = "-advisor" ]
   then 
      ADVISOR=1
      [ "`advisor --help 2>/dev/null`" = "" ] && echo "advisor is not available." && exit
   elif [ "$1" = "-vtune" ]
   then 
      VTUNE=1
      vtune=`ls /opt/intel/oneapi/vtune/latest/bin64/vtune 2>/dev/null`
      [ "$vtune" != "" ] && export PATH=`dirname $vtune`:$PATH
      [ "`vtune --help 2>/dev/null`" = "" ] && echo "vtune is not available." && exit
   elif [ "$1" = "-perf" ]
   then 
      PERF=1
      rm -f perf.data
      [ ! -f /usr/bin/perf ] && echo "/usr/bin/perf doesn't exist." && exit
   elif [ "$1" = "-trace" ]
   then 
      export VT_PCTRACE=15
      [ "`type traceanalyzer 2>/dev/null`" = "" ] && echo "traceanalyzer doesn't exist." && exit
   elif [ "$1" = "-nsys" ]
   then
      NSYS=1
   elif [ "$1" = "-ncu" ]
   then
      NCU=1
   elif [ "$1" = "-cs" ]
   then
      CS=1;shift;CS_OPTION=$1
   elif [ "$1" = "-gdb" ]
   then
      gdb=gdb.sh && mpirun_options="-gdb"
   elif [ "$1" = "-convert_data" ]
   then
      conv_scr=$TRUST_ROOT/Outils/convert_data/convert.sh
      $conv_scr $2
      exit $?
   elif [ "$1" = "-prm" ]
   then
      prm=1 
   elif [ "$1" = "-jupyter" ]
   then
      shift
      echo "Usage:"
      echo "You should run trust -jupyter inside a folder, ex. MyValidationForm"
      echo " > cd MyValidationForm"
      echo " > ls       # you should have src folder which contains at least a datafile"
      echo " > trust -jupyter   # will create a jupyter's sample notebook"
      [ "`ls *.ipynb 2>/dev/null`" != "" ] && echo "" && echo "Fatal error: you already have .ipynb file inside `pwd`" && exit 255
      if [ "$1" != "" ]
      then
      	 jy=$1
      else
      	 if [ "`basename $ici`" = src ]
      	 then
      	    jy=`cd ..;basename $PWD`
      	 else
      	    jy=`basename $PWD`
      	 fi
      fi
      create_basic_jupyter_notebook.sh $jy
      exit $?
   elif [ "$1" = "-search" ]
   then
      shift
      option=""
      while [ "$1" != "" ]
      do
	 option=$option" "$1
         shift
      done
      cherche.ksh $option
      exit $?
   elif [ "$1" = "-check" ] || [ "$1" = "-ctest" ]
   then
      CTEST=0 && [ "$1" = "-ctest" ] && CTEST=1
      shift
      if [ "$1" = "" ]
      then
	 help
      elif [ "$1" = all ]
      then
	 # All test cases
	 option=0 
      # elif [ "`ls $TRUST_TESTS/*/$1/$1.lml.gz 2>/dev/null`" != "" ]
      elif [ "`find $TRUST_TESTS/ -follow -name $1.lml.gz -print 2>/dev/null | sort`" != "" ]
      then
	 # Single test case
	 option=$1   
      elif [ -f $1 ]
      then
	 # List of test cases in a file
	 option=$1
      else
	 # Test cases covering a method::class
	 Qui $1 || exit -1
	 option=liste_cas
      fi
      # Lorsque lance depuis ctest on desactive l'envoi de mail
      # sinon si 1000 cas tests -> 1000 mails (1 par cas test)
      nomail="" && [ "$CTEST_INTERACTIVE_DEBUG_MODE" != "" ] && nomail="-nomail"
      if [ "$CTEST" = 1 ]
      then
         # Lancement parallele avec ctest:
         liste_ctest=`mktemp_`
         tests=$option && [ -f $option ] && tests=`cat $option 2>/dev/null`
         if [ "$project_directory" = "" ]
         then # TRUST
            OPT=`basename $exec` && OPT=${OPT#TRUST} && cd $TRUST_ROOT/MonoDir$OPT/src || exit -1
         else # Baltik
            name=`$TRUST_Awk '/^executable / && /:/ {print $3}' $project_directory/project.cfg`
            OPT=`basename $exec` && OPT=${OPT#$name} && cd $project_directory/build/src/exec$OPT || exit -1
         fi
         ctest -N | sed "1,$ s/[#:]//g" > $liste_ctest
         for test in $tests
         do
            # Format ctest assez particulier: 4,4,,5,6
            n=`awk -v test=$test '($3==test) {print $2}' $liste_ctest`
            if [ "$n" != "" ]
            then
               if [ "$I" = "" ]
               then
                  I="-I "$n","$n","
               else
                  I=$I","$n
               fi
            fi
         done
         rm -f $liste_ctest
         ctest -j$TRUST_NB_PHYSICAL_CORES $I --output-on-failure
         exit $?
      else
         # Lancement sequentiel classique:
         echo $option | lance_test $nomail -no_timeout $binary
         exit $?
      fi
   elif [ "$1" = "-clean" ]
   then
      for ext in list lata sons son out lml dt_ev TU log stop err xyz sauv dump face out_err plan progress
      do 
	 echo "rm *.$ext files."
	 rm -f *.$ext
      done
      # echo "rm *.lata.* core.* err.* out.*"
      # rm -f *.lata.* core.* err.* out.*
	  # A priori c est un peu fort : err.* out.* ne sont pas crees au run. 
      echo "rm *.lata.* / *.lata_single / core.* / convert_jdd files."
      rm -f *.lata_single core.* convert_jdd
      find . -maxdepth 1 -name '*.lata.*' -exec  rm  {} \;
      echo "rm *_Channel_Flow_Rate_* / *_Pressure_Gradient_* files."
      rm -f *_Channel_Flow_Rate_* *_Pressure_Gradient_*
      echo "rm Moyennes_spatiales_* / reynolds_tau.dat / tauw.dat / u_tau.dat files."
      rm -f Moyennes_spatiales_* reynolds_tau.dat tauw.dat u_tau.dat
      echo "rm *.evol_glob files."
      rm -f *.evol_glob
      echo "rm iter.dat / sauvegarde_tble_* / tble_mesh.dat files."
      rm -f iter.dat sauvegarde_tble_* tble_mesh.dat
      echo "rm DEBOG / .out / faces / seq files."
      rm -f DEBOG .out faces seq
      exit 0
   else
      # Unknown option
      supported_option=0
   fi 
   # Option is known, jump to next
   [ "$supported_option" = 1 ] && shift
done
[ "$exec" = "" ] && echo "Error: the variable \$exec containing TRUST binary path is undefined." && exit -1
[ ! -f $exec ] && echo "Error: the binary pointed by the variable \$exec=$exec does NOT exist." && exit -1  
NOM=`basename $ici` && [ ${#1} != 0 ] && NOM=$1 && NOM=${NOM%.data} && shift
[ "${NOM:0:1}" = "-" ] && echo "Error: option not included" && help && exit 0
export NB_PROCS=1 
[ $1 -eq 0 ] 2>/dev/null
code_retour=$?
if [ $code_retour -eq 0 -o $code_retour -eq 1 ]
then 
  [ ${#1} != 0 ] && [ ${1#-} = $1 ] && export NB_PROCS=$1 && USE_MPIRUN=1 && shift
fi
[ "$TRUST_DISABLE_MPI" = 1 ] && [ "$USE_MPIRUN" = 1 ] && export USE_MPIRUN=0
[ ${HOST#orcus} != $HOST ] && USE_MPIRUN=1
if [ $NB_PROCS -gt 1 ] && [ "$TRUST_USE_GPU_AWARE_MPI" = 1 ] # On n'active pas par defaut car pas fiable encore sur plusieurs noeuds...
then
   if [ "$TRUST_USE_ROCM" = 1 ] && [ "`ldd $binary 2>/dev/null | grep gtl_hsa`" != "" ]
   then
      # OK sur adastra, performances ameliorees
      export MPICH_GPU_SUPPORT_ENABLED=1
      echo "Enabling GPU support for MPI (MPICH_GPU_SUPPORT_ENABLED=1) ..."
   elif [ "$TRUST_USE_CUDA" = 1 ]
   then
      # OK sur topaze, performances ameliorees
      echo "Enabling CUDA support for MPI ..."
   fi
fi
[ "$PETSC_OPTIONS" = "" ] && PETSC_OPTIONS=$*
if [ "`echo $PETSC_OPTIONS | grep -i cusp`" != "" ]
then
   gpu=1 # Activate also GPU option if some gpu option is passed through the command line option:
fi
[ "$TRUST_USE_CUDA" = 1 ] && [ "`grep -i cuda $MPI_ROOT/lib/* 2>/dev/null`" = "" ] && PETSC_OPTIONS=$PETSC_OPTIONS" -use_gpu_aware_mpi 0"
if [ "$monitor" = 1 ]
then
   Run_sonde $binary $NOM
   exit $?
fi
if [ "$probes" = 1 ]
then
   Run_sonde $NOM
   exit $?
fi
if [ "$probes" = 2 ]
then 
   DIR=`dirname $NOM`
   DIR=`(cd $DIR;pwd)`
   cd $DIR
   dt_ev=$DIR/`basename $NOM`.dt_ev
   #[ ! -f $dt_ev ] && echo "# temps          dt              facsec          residu=max|Ri| dt_stab i1 I2" >$dt_ev && echo 0 1 1 1 1  1 1>> dt_ev
   let i=1
   while [ $i -le 0 ]
   do
      let i=i+1
     # break
      [ -f $dt_ev ] && break
      echo "waiting for $dt_ev"
     sleep 0.1
   done
   #[ ! -f $dt_ev ] && exit 1
   bash  $TRUST_ROOT/exec/TRUST_PLOT2D/Plot2d.sh $DIR/`basename $NOM`.data "residu=max|Ri|"
   err=$?
   exit $err
fi
if [ "$edit" = 1 ]
then
   editor=$TRUST_EDITOR
   [ "$editor" = "" ] && editor="xemacs"
   $editor $NOM".data" &
   exit $?
fi
if [ "$xedit" = 1 ]
then
   $TRUST_ROOT/bin/EditData $NOM".data"
   exit $?
fi
if [ "$xcheck" = 1 ]
then
   $TRUST_ROOT/bin/VerifData $NOM".data"
   ret=$?
   [ $ret != 0 ] && echo "Error!" || echo "All OK!"
   exit $ret
fi
if [ "$xdata" = 1 ]
then
   if [ "$project_directory" != "" ]
   then
      # Pour Baltik:
      cd $project_directory/build/xdata
   else
      # Pour TRUST:
      cd $TRUST_ROOT/Outils/TRIOXDATA
   fi
   source ./XDATA.sh && cd test_complet && echo $NOM | ./lance_test_modif
   exit $?
fi
if [ "$partition" = 1 ]
then
   if [ $NB_PROCS -eq 1 ]
   then
      make_PAR.data $NOM
   else
      make_PAR.data $NOM $NB_PROCS
   fi
   exit $?
fi
if [ "$mesh" = 1 ]
then
   Check_maillage.ksh $NOM
   exit $?
fi
if [ "$prm" = 1 ]
then
   create_basic_prm_from_lata.sh $NOM
   exit $?
fi
if [ "$copy" = 1 ]
then
   echo "Try to extract $NOM test case from $TRUST_TESTS database..."
   copie_cas_test $NOM
   err=$?
   if [ "$err" = 0 ]
   then
      echo "Directory `pwd`/$NOM created with files inside:" && ls $NOM
   else
      echo "ERROR: Directory `pwd`/$NOM NOT created !!!"
      fold="`pwd`/$NOM"
      [ -f $fold/prepare.log ] && cp -f $fold/prepare.log `pwd` && echo "" && echo "See `pwd`/prepare.log for further details."
      [ -d $fold ] && rm -r $fold
   fi
   exit $err
fi
val=`which valgrind 2>/dev/null`
if [ "$VALGRIND" = "1" ] || [ "$VALGRIND_STRICT" = "1" ] || [ "$VALGRIND_GDB" = "1" ]
then    
    suppressions=""
    if [ "$VALGRIND_STRICT" != "1" ]
    then
        suppressions="--gen-suppressions=all"
	    suppressions=$suppressions" --suppressions=$TRUST_ROOT/Outils/valgrind/suppressions"
    fi
    if [ "$gdb" != "" ] || [ "$VALGRIND_GDB" = "1" ]
    then
       gdb.sh -valgrind $exec
       exit
    fi
    if [ "$VALGRIND_LOG_FILE" = 1 ]
    then
       # Call from testval:
       log_file="--log-file=tmp_log%p" 
    else
       # Too slow in testval:
       # Disable if extern library cause big jump in RAM and time:
       if [ "`grep -i -e petsc -e 'polymac ' -e amgx $NOM.data`" = "" ]
       then
          more_info_but_slower="--track-origins=yes"
       else
          echo "=================================================================="
          echo "Warning: --track-origins option is disabled for Valgrind analysis."
          echo "=================================================================="
       fi
    fi
    #  more_info_but_slower=""      # --track-origins=yes"
    # GF sinon on a des erreurs au demarrage de mpi
    [ $NB_PROCS -ge 2 ] && log_file="--log-file=tmp_log%p" 
    #  log_file="--log-file=tmp_log%p" 
    # Still reachable only checked for OpenMPI 1.2.9: 
    if [ "`$Mpirun --version | grep 1.2.9`" != "" ]
    then
       reachable=yes
    else
       reachable=yes
       # Cause MPI_irecv, a table is allocated but not freed, see 4.8.6 in https://wiki.uiowa.edu/download/attachments/109785161/Valgrind-Quick-Start.pdf?version=1&modificationDate=1385057441990&api=v2
    fi
    exec="$XTERM $val --error-exitcode=1 --leak-check=full --show-leak-kinds=all --errors-for-leak-kinds=all   --show-reachable=$reachable --num-callers=15 $log_file $more_info_but_slower $suppressions $ATTACH $binary"
fi
if [ "$CALLGRIND" = "1" ]
then
   echo $binary
   exec="$val --tool=callgrind --dump-instr=yes --trace-jump=yes --callgrind-out-file=$NOM.callgrind $binary"
elif [ "$MASSIF" = 1 ]
then
   exec="$val --tool=massif --massif-out-file=$NOM.massif.%p --detailed-freq=1 --time-unit=ms $binary"
elif [ "$HEAPTRACK" = 1 ]
then
   [ "`heaptrack -v 1>/dev/null 2>&1;echo $?`" != 0 ] && echo "Install heaptrack tool first." && exit -1
   exec="heaptrack $binary"
elif [ "$ADVISOR" = 1 ]
then
   exec="advisor --collect=survey $binary"
elif [ "$VTUNE" = 1 ]
then
   # -r directory is mandatory for MPI run:
   vtune_result=`pwd`/vtune_result
   rm -r -f $vtune_result $vtune_result.*
   exec="vtune -collect hotspots -r $vtune_result $binary"
elif [ "$PERF" = 1 ]
then
   exec="perf record --call-graph dwarf -o $NOM.perf $binary" # Plus complet 
elif [ "$NSYS" = 1 ]
then
   rm -f $NOM.qdrep
   export NVCOMPILER_ACC_TIME=1 # Tres utile pour sortie bilan des copies sur device
   #export NVCOMPILER_ACC_NOTIFY=3
   # Detect nsys location: Under /opt/nvidia/nsight-systems/ more recent version else under $CUDA_ROOT
   nsys=`ls /opt/nvidia/nsight-systems/*/bin/nsys $CUDA_ROOT/*/bin/nsys $CUDA_ROOT/bin/nsys 2>/dev/null | tail -1`
   export PATH=`dirname $nsys`:$PATH
   trace="--trace=cuda" && [ $NB_PROCS -gt 1 ] && trace=$trace",mpi --mpi-impl=`basename $MPI_ROOT`"
   # Droit elevation disponible:
   sudo ls 1>/dev/null
   if [ $? = 0 ]
   then
      sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
      # metriques GPU en plus mais necessite d'etre sudo
      trace=$trace" --gpu-metrics-device all"
      # nsight="sudo " # Mais attention fichiers ecrits root !
   else
      nsight=""
   fi
   nsight=$nsight"nsys profile $trace --force-overwrite true -o $NOM.qdrep"
elif [ "$NCU" = 1 ]
then
   rm -f $NOM.qdrep.ncu-rep
   # Detect ncu location: Under /opt/nvidia/nsight-systems/ more recent version else under $CUDA_ROOT
   ncu=`ls /opt/nvidia/nsight-systems/*/bin/ncu $CUDA_ROOT/*/bin/ncu $CUDA_ROOT/bin/ncu 2>/dev/null | tail -1`
   export PATH=`dirname $ncu`:$PATH
   nsight="ncu --target-processes all -o $NOM.qdrep.ncu-rep"
elif [ "$CS" = 1 ]
then
   exec="compute-sanitizer --tool $CS_OPTION $binary"
elif [ "$VT_PCTRACE" != "" ]
then
   exec="-trace $binary"
fi
USE_PETSC=0
if [ -f $NOM.data ]
then 
   # To avoid dos problems:
   dos2unix_ $NOM.data
   USE_PETSC=`sed "s/\t/ /g" $NOM.data | $TRUST_Awk 'BEGIN {IGNORECASE=1;use_petsc=0} \
                            // {n=split($0,a,"#")-1;if (n>0) dieses+=n} \
                            /^fin/ && (dieses%2==0) && (NF==1) {exit} \
                            / petsc / || / petsc_gpu / || / optimal / || / resoudremultiassemblage / || / resoudre / {use_petsc=1;exit}
	                    END {print use_petsc}'`
fi
if [ "$TRUST_USE_CUDA" = 1 ] || [ "$TRUST_USE_ROCM" = 1 ]
then
   gpu=1
fi
soumission=999
sub="" 
queue=""
qos=""
cpu=""
ram=""
noeuds=""
export espacedir
export project
export prod
export bigmem
export node
export gpu
if [ "$TRUST_WITHOUT_HOST" = 0 ]
then
   source $TRUST_ROOT/env/HOST_$HOST_BUILD.sh
else
   source $TRUST_ROOT/env/HOST_default.sh
fi
define_soumission_batch
shortbin=${binary##*/}
if [ $soumission != 999 ] && [ ${shortbin#TRUST} != $shortbin ] && [ "`VerifData 1>/dev/null 2>&1;echo $?`" = 0 ] && [ $NB_PROCS -gt 1 ]
then
   if [ ! -f $TRUST_ROOT/Outils/TRIOXDATA/IHMTRIO.sh ]
   then
        echo $ECHO_OPTS "Warning no Check of the syntax of the $NOM.data file before submitting the job !!!! "
   else
        echo $ECHO_OPTS "Checking the syntax of the $NOM.data file before submitting the job...\c"
        VerifData $NOM.data 1>/dev/null 2>&1
        if [ $? != 0 ]
        then
            echo KO
            echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            echo "Check your data file. Syntax error detected:"
            echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            VerifData $NOM.data
            echo "Error: Check your $NOM.data file."
            #exit -1
            else
            echo OK
        fi
   fi
fi
if  [ $NB_PROCS = 1 ] && [ $USE_MPIRUN = 0 ]
then
   petsc_for_kernel=$PETSC_ROOT/$TRUST_ARCH/include/petsc_for_kernel.h
   if [ ! -f $petsc_for_kernel ] || [ "`grep 'define MPI_INIT_NEEDS_MPIRUN' $petsc_for_kernel 2>/dev/null`" != "" ]
   then
      if [ -f $NOM.data ]
      then
	 USE_MPIRUN=$USE_PETSC
      else
	 USE_MPIRUN=1
      fi
   fi
fi
[ "$prod" = 1 ] && [ $soumission != 999 ] && [ $NB_PROCS = 1 ] && [ $USE_MPIRUN = 1 ] && soumission=1
[ -f $MPI_ROOT/sbin/cleanipcs ] && [ "`ps -fl -U $me | grep 'mpirun ' | grep TRUST_mpich | grep -v grep | grep -v $$`" = "" ] && $MPI_ROOT/sbin/cleanipcs
[ "$queue_choisie" != "" ] && queue=$queue_choisie 
[ "$queue" != "" ] && echo "Partition $queue selected (soumission=$soumission ; NB_PROCS=$NB_PROCS ; USE_MPIRUN=$USE_MPIRUN)."
sub_file=.sub_file_$NOM
if [ "$create_sub_file" ]
then
   sub_file=sub_file && [ -f sub_file ] && mv -f sub_file sub_file.old
   echo "***************************************************"
   echo "Submission file $sub_file created but not submitted."
   echo "You can modify it, then submit the job with the command:"
fi
rm -f $sub_file
if [ $NB_PROCS -ge $soumission ]
then
   ###########################################
   # En test du sub_file selon le gestionnaire 
   ###########################################
   case $sub in
   	SLURM)
		# http://www.idris.fr/media/su/idrischeatsheet.pdf
		echo "#!/bin/bash"					>> $sub_file	# Shell
		echo "#SBATCH -J $NOM" 					>> $sub_file	# Job name
		[ "$queue" != "" ] && echo "#SBATCH -p $queue"		>> $sub_file	# Partition
		[ "$constraint" != "" ] && echo "#SBATCH -C $constraint">> $sub_file	# Constraint
		[ "$qos" != "" ] && echo "#SBATCH --qos=$qos"		>> $sub_file	# Quality of service
		echo "#SBATCH -t $cpu"					>> $sub_file	# Time in minutes
		echo "#SBATCH -o myjob.%j.o"				>> $sub_file	# Output log
		echo "#SBATCH -e myjob.%j.e"				>> $sub_file	# Error log
		[ "$project" != "" ] && echo "#SBATCH -A $project"	>> $sub_file	# Account
		echo "#SBATCH -n $NB_PROCS"				>> $sub_file	# Number of tasks
		[ "$noeuds" != "" ] && echo "#SBATCH -N $noeuds"        >> $sub_file    # Number of nodes
		[ "$cpus_per_task" != "" ] && echo "#SBATCH -c $cpus_per_task"			>> $sub_file	# Number of cores per task
		[ "$gpus_per_node" != "" ] && echo "#SBATCH --gres=gpu:$gpus_per_node"		>> $sub_file	# Number of GPUs per node
    # Deux options importantes for jean-zay/IDRIS sinon crashes possibles avec MPI-Cuda-Aware:
		[ "$hintnomultithread" != "" ] && echo "#SBATCH --hint=nomultithread"		>> $sub_file
		#[ "$hintnomultithread" != "" ] && echo "#SBATCH --ntasks-per-node=$ntasks"	>> $sub_file
		[ "$node" = 1 ] && echo "#SBATCH --exclusive"		>> $sub_file	# Exclusive use of nodes during production run	
		[ "$ram" != "" ] && echo "#SBATCH --mem=$ram"           >> $sub_file    # Real memory required per node in MegaBytes
		echo "##SBATCH --mail-user=email"			>> $sub_file
		echo "##SBATCH --mail-type=BEGIN,END"			>> $sub_file
		echo "set -x"				 		>> $sub_file
		echo "cd \$SLURM_SUBMIT_DIR" 				>> $sub_file    # Submit directory for reprise_auto script
		;;
   	POE)
		echo "#!/bin/bash" 					>> $sub_file
		echo "#@ job_name=$NOM"					>> $sub_file
		[ "$queue" != "" ] && echo "#@ class=$queue"		>> $sub_file
		echo "#@ wall_clock_limit=$cpu"				>> $sub_file
		echo "#@ output=myjob.\$(jobid).o"			>> $sub_file
		echo "#@ error=myjob.\$(jobid).e"			>> $sub_file
		#echo "#@ job_type=parallel"				>> $sub_file
		#echo "#@ network.MPI=sn_all,,us"			>> $sub_file
		#echo "#@ node_topology=island"				>> $sub_file
		#echo "#@ island_count=`echo "1+($NB_PROCS-1)/8192" | bc`" >> $sub_file # ceil($NB_PROCS/8192)
		#echo "#@ energy_policy_tag=NONE"			>> $sub_file
		#echo "#@ queue"					>> $sub_file
		echo "#@ total_tasks=$NB_PROCS"				>> $sub_file
		#echo "#@ node=`echo "1+($NB_PROCS-1)/16" | bc`" 	>> $sub_file # ceil($NB_PROCS/16)
		[ "$noeuds" != "" ] && echo "#@ node=$noeuds"		>> $sub_file 
		[ "$node" = 1 ] && echo "#@ node_usage=not_shared"	>> $sub_file
		[ "$ram" != "" ] && echo "#@ requirements=(Memory >= $ram)" >> $sub_file
		[ "$cpus_per_task" != "" ] && echo "Number of core per task option not supported yet on $HOST. Contact TRUST support" && exit -1
		#echo "#@ initialdir=$ici"				>> $sub_file
		echo "cd \$LOADL_STEP_INITDIR" 				>> $sub_file
		;;		
   	LSF)
	 	echo "#BSUB -J $NOM"				>> $sub_file
      		[ "$queue" != "" ] && echo "#BSUB -q $queue" 	>> $sub_file
      		echo "#BSUB -W $cpu" 				>> $sub_file 
		echo "#BSUB -o myjob.%J.o" 			>> $sub_file
		echo "#BSUB -e myjob.%J.e" 			>> $sub_file 
		echo "#BSUB -n $NB_PROCS"			>> $sub_file
		[ "$node" = 1 ] && echo "#BSUB -x"		>> $sub_file
      		[ "$ram" != "" ] && echo "#BSUB -M $ram" 	>> $sub_file
		[ "$cpus_per_task" != "" ] && echo "Number of core per task option not supported yet on $HOST. Contact TRUST support" && exit -1
		echo "cd \$LS_SUBCWD" 				>> $sub_file
 		;;
	CCC)
		echo "#!/bin/bash" 						>> $sub_file 
		echo "#MSUB -r $NOM" 						>> $sub_file 
		[ "$queue" != "" ] && echo "#MSUB -q $queue"			>> $sub_file 
		[ "$qos" != "" ] && echo "#MSUB -Q $qos"			>> $sub_file 
		[ "`echo $cpu | grep :`" != "" ] && echo "#BSUB -W $cpu" 	>> $sub_file # Exprime en HH:MM:SS !!! BSUB !!!
		[ "`echo $cpu | grep :`" = "" ] && echo "#MSUB -T $cpu" 	>> $sub_file # Exprime en SSSSS      	
		echo "#MSUB -o myjob.%J.o"					>> $sub_file
		echo "#MSUB -e myjob.%J.e" 					>> $sub_file
		[ "$project" != "" ] && echo "#MSUB -A $project" 		>> $sub_file 
		echo "#MSUB -E \"--no-requeue\""            			>> $sub_file # Prevent from restart
		echo "#MSUB -n $NB_PROCS" 					>> $sub_file 
		[ "$noeuds" != "" ] && echo "#MSUB -N $noeuds" 			>> $sub_file 
		[ "$cpus_per_task" != "" ] && echo "#MSUB -c $cpus_per_task"	>> $sub_file
		[ "$node" = 1 ] && echo "#MSUB -x"				>> $sub_file # Exclusive use of nodes during production run
		[ "$ram" != "" ] && echo "#MSUB -M $ram" 			>> $sub_file 
		[ "$espacedir" != "" ] && echo "#MSUB -m $espacedir"		>> $sub_file
		echo "##MSUB -@ email:begin,end"				>> $sub_file
		echo "set -x"				 			>> $sub_file 
		echo "cd \$BRIDGE_MSUB_PWD" 					>> $sub_file
 		;;
	SGE)
	 	echo "#$ -N $NOM"				>> $sub_file
      		[ "$queue" != "" ] && echo "#$ -q $queue" 	>> $sub_file
		echo "#$ -l h_rt=$cpu"                          >> $sub_file
		echo "#$ -o myjob.%J.o"                         >> $sub_file
		echo "#$ -e myjob.%J.e"                         >> $sub_file
		#echo "#$ -cwd" 				>> $sub_file
		#echo "#$ -S /bin/bash"				>> $sub_file
		#[ "$balise" != "" ]	&& echo $balise		>> $sub_file
		[ "$taches" != "" ] && echo "#$ -pe $taches"	>> $sub_file
		[ "$node" = 1 ] && echo "#$ -l exclusive"	>> $sub_file
		[ "$ram" != "" ] && echo "#$ -l mem_free=$ram"  >> $sub_file
		[ "$cpus_per_task" != "" ] && echo "Number of core per task option not supported yet on $HOST. Contact TRUST support" && exit -1
		echo "cd \$SGE_O_WORKDIR" 			>> $sub_file
		;;	
	NQS)
	 	echo "#QSUB -r $NOM"		>> $sub_file
		echo "#QSUB -lt $cpu"		>> $sub_file
		echo "#QSUB -n $NB_PROCS" 	>> $sub_file
		[ "$cpus_per_task" != "" ] && echo "Number of core per task option not supported yet on $HOST. Contact TRUST support" && exit -1
                echo "cd $ici" 			>> $sub_file
		;;
	PBS)
		echo "#!/bin/bash"                                      >> $sub_file    # Shell (sh ou bash)
		echo "#PBS -N `echo $NOM | cut -c 1-15`"                >> $sub_file    # Job name
		[ "$queue" != "" ] && echo "#PBS -q $queue"             >> $sub_file    # Partition
		[ "$qos" != "" ] && echo "#PBS -l qos=$qos"             >> $sub_file    # Quality of service
		echo "#PBS -l walltime=$cpu"                            >> $sub_file    # Time in minutes
		echo "#PBS -o myjob.%J.o"                               >> $sub_file    # Output log
		echo "#PBS -e myjob.%J.e"                               >> $sub_file    # Error log
		echo "#PBS -l nodes=$noeuds:ppn=$taches"                >> $sub_file    # Number of nodes and tasks
		#echo "#PBS -l ppn=$taches"      		        >> $sub_file    # Number of tasks
		#echo "#PBS -l nodes=$noeuds"           		>> $sub_file    # Number of nodes	
		#[ "$node" = 1 ] && echo "#PBS -l naccesspolicy=singlejob" >> $sub_file	# Exclusive use of nodes during production run	
		[ "$ram" != "" ] && echo "#PBS -l mem=$ram"             >> $sub_file    # Real memory required per node in MegaBytes
		[ "$cpus_per_task" != "" ] && echo "Number of core per task option not supported yet on $HOST. Contact TRUST support" && exit -1
		echo "cd \$PBS_O_WORKDIR" 				>> $sub_file
		;;
	*) echo "sub=$sub not planned." && exit -1
		;;
   esac	   
   #######
   # IPM #
   #######
   if [ "$ipm" = 1 ]
   then
      echo "module load ipm" 				>> $sub_file
      echo "export LD_PRELOAD=\$IPM_ROOT/lib/libipm.so" >> $sub_file
   fi
   ##########
   # VAMPIR #
   ##########
   if [ "$VAMPIRTRACE_ROOT" != "" ]
   then
      echo "export VT_IOTRACE=yes" 	>> $sub_file
      echo "export VT_MAX_FLUSHES=0" 	>> $sub_file
   fi
   ######################
   # Commandes de calculs
   ######################
   [ -f ld_env.sh ] && echo "[ -f ld_env.sh ] && . ./ld_env.sh # To load an environment file if necessary" >> $sub_file
   echo "source $TRUST_ROOT/env_TRUST.sh" >> $sub_file
   echo "export exec=$exec" >> $sub_file
   [ "${HOST#irene}" != "$HOST" ] && [ "$queue" = "knl" ] && echo "module sw feature/openmpi/net/auto" >> $sub_file
   if [ "$create_sub_file" = 1 ]
   then
      OUTPUT=$NOM
   else
      # En interactif OUTPUT=.$NOM et non OUTPUT=$NOM car sinon conflit avec lance_test (trust NOM 1>$NOM.out 2>$NOM.err)
      # et blocage possible sur castor avec Baltik par exemple !!!
      OUTPUT=.$NOM   
   fi
   if [ $NB_PROCS = 1 ] && [ $USE_MPIRUN = 0 ]
   then
      echo "\$exec $NOM $PETSC_OPTIONS 1>$OUTPUT.out 2>$OUTPUT.err" >> $sub_file
   else
      if [ "$mpirun" != "" ]
      then
         if [ "$sub" = "SLURM" ]
         then
            echo "$mpirun \$exec $NOM \$SLURM_NTASKS $PETSC_OPTIONS 1>$OUTPUT.out 2>$OUTPUT.err" >> $sub_file
         elif [ "$sub" = "CCC" ]
	       then
            echo "$mpirun \$exec $NOM \$BRIDGE_MSUB_NPROC $PETSC_OPTIONS 1>$OUTPUT.out 2>$OUTPUT.err" >> $sub_file
	       else
            echo "$mpirun \$exec $NOM $NB_PROCS $PETSC_OPTIONS 1>$OUTPUT.out 2>$OUTPUT.err" >> $sub_file
	       fi
      else
         echo "$TRUST_ROOT/bin/mpirun.sh -np $NB_PROCS \$exec $NOM $NB_PROCS $PETSC_OPTIONS 1>$OUTPUT.out 2>$OUTPUT.err" >> $sub_file
      fi
   fi   
   #######
   # IPM #
   #######
   if [ "$ipm" = 1 ]
   then
      echo "report=\`ls -rt triou.*.*.0 | tail -1\`" >> $sub_file
      echo "ipm_parse -full \$report 1>>$OUTPUT.out 2>>$OUTPUT.err" >> $sub_file
      echo "ipm_parse -html \$report" >> $sub_file
   fi   
   if [ "$create_sub_file" ]
   then
      case $sub in
        SLURM) echo "sbatch $sub_file";;
      	POE) echo "llsubmit $sub_file";;
        LSF) echo "bsub < $sub_file";;
        CCC) echo "ccc_msub $sub_file";;
        SGE) echo "qsub $sub_file";;
        NQS) echo "qsub $sub_file";;
        PBS) echo "qsub $sub_file";;
      esac
      echo "***************************************************"
      exit
   fi
   if [ "`type qstat 1>/dev/null 2>&1;echo $?`" != 0 ]
   then
      # Commande qstat non trouvee, elle est necessaire pour la suite
      echo "No command qstat found for listing jobs..."
      qstat
      exit -1
   fi   
   ##############################################
   # Soumission du sub_file selon le gestionnaire 
   ##############################################
   case $sub in
   	SLURM)	sbatch_interactif;;
   	POE) 	llsubmit -s $sub_file;;
   	LSF) 	cat $sub_file | bsub -I;;
    CCC) 	ccc_msub_interactif;;
    SGE) 	qsub -S /bin/bash -sync yes $sub_file;;
    NQS) 	qsub -I $sub_file;;
    PBS) 	qsub_interactif;;
   esac	
   err=$?   
   if [ "$VALGRIND" = "1" ] || [ "$VALGRIND_STRICT" = "1" ] || [ "$VALGRIND_GDB" = "1" ]
   then
     if [ "`awk '/ERROR SUMMARY/ {errs+=$4} END {print errs}' $OUTPUT.err $OUTPUT.out tmp_log*`" != "0" ]
     then
        exit -1
     else
        exit 0
     fi
   fi
   #[ $err = 0 ] && rm -f $sub_file # On garde desormais la trace du fichier de soumission...
   # On envoit $OUTPUT.out et $OUTPUT.err vers les bonnes sorties afin que "trust jdd 1>jdd.out 2>jdd.err" envoie ce qu'il faut dans jdd.out et jdd.err
   # A cause de platine (permission denied), on utilise plutot les chemins pointes /proc/self/fd/1 et 2
   [ -f $OUTPUT.out ] && cat $OUTPUT.out >> "/proc/self/fd/1" #cat $OUTPUT.out > "/dev/stdout"
   [ -f $OUTPUT.err ] && cat $OUTPUT.err >> "/proc/self/fd/2" #cat $OUTPUT.err > "/dev/stderr"
   # Check for TRUST calculation only (cause coupled MC2 calculation DO NOT produce this message for example):
   if [ "`grep 'Executable: ' $OUTPUT.err 2>/dev/null`" != "" ] && [ "`grep 'Arret des processes.' $OUTPUT.err`" = "" ]
   then
      err=1
   fi
   # Try to detect crashes (if it is not a TRUST binary, example PETSc test case)
   if [ "`grep 'invalid device function' $OUTPUT.err`" != "" ] || [ "`grep 'Signal: Aborted' $OUTPUT.err`" != "" ]
   then
      err=1
   fi
   ccc_myproject -P $queue 2>/dev/null # Sur CCRT heures de calcul
   exit $err
else
   # Pas de gestionnaire, example PC:
   [ "$cpus_per_task" != "" ] 	&& [ "$HOST" != "jean-zay" ] && echo "Number of core per task option not supported yet on $HOST. Contact TRUST support" && exit -1
   if [ $NB_PROCS = 1 ] && [ $USE_MPIRUN = 0 ]
   then
      run="$nsight $gdb $exec $NOM $PETSC_OPTIONS"
   else
      run="$nsight $TRUST_ROOT/bin/mpirun.sh `[ "$gdb" != "" ] && echo -gdb` -np $NB_PROCS $exec $NOM $NB_PROCS $PETSC_OPTIONS"
   fi
   if [ "$create_sub_file" ]
   then
      echo $run > $sub_file
      chmod +x $sub_file
      echo "./$sub_file"  
      echo "***************************************************"
      exit
   fi
   # MPS and Sserver running, submit jobs with Sserver:
   [ "$TRUST_USE_CUDA" = 1 ] && [ "`ps aux | grep nvidia-cuda-mps-control | grep -v grep`" != "" ] && [ "`ps fux | grep Sserver | grep -v grep`" != "" ] && TRUST_USE_Sjob=1
   # Use Sserver:
   if [ "$TRUST_USE_Sjob" = "1" ] && [ "$nsight" = "" ]
   then
      # export PATH=$PATH:$TRUST_ROOT/bin/Sjob
      sub_file=s${NB_PROCS}_$NOM
      sub_file=`echo $sub_file | sed "s/\//_/g"`
      echo "#!/bin/bash" > $sub_file
      echo $run >> $sub_file
      chmod +x $sub_file
      $TRUST_ROOT/bin/Sjob/Salloc -n $NB_PROCS $PWD/$sub_file
      err=$?
      [ $err -eq 0 ] && rm -f $sub_file
   else
      eval $run
      err=$?
   fi
fi
[ "$log_file" != "" ] && sleep 1 && cat $(ls -rt tmp_log* | tail -$NB_PROCS)
if [ "$CALLGRIND" = 1 ]
then
   echo "Callgrind log $NOM.callgrind is created."
   echo "You could try now: kcachegrind $NOM.callgrind" && [ ! -f /usr/bin/kcachegrind ] && echo "But kcachegrind is not installed."
   echo "To see source code, you need a binary built with -g -O0, eg: \$exec_gcov"
   echo "You can build it with: make gcov"
elif [ "$MASSIF" = 1 ]
then
   echo "Massif log $NOM.massif.* are created."
   echo "You could try now: massif-visualizer $NOM.massif.*" && [ ! -f /usr/bin/massif-visualizer ] && echo "But massif-visualizer is not installed."
elif [ "$HEAPTRACK" = 1 ]
then
   echo "Heaptrack log ?.* are created."
   heaptrack --analyze `find . -newer $NOM.log -name heaptrack.'*'.*st*`
elif [ "$VTUNE" = 1 ]
then
   vtune-gui $vtune_result*/*.vtune
elif [ "$ADVISOR" = 1 ]
then
   advisor-gui `ls -art | grep e0 | tail -1`
elif [ "$PERF" = 1 ] && [ -f $NOM.perf ]
then
   if [ -f /usr/bin/hotspot ]
   then
      hotspot $NOM.perf
   else
      perf report -i $NOM.perf
   fi
elif [ "$VT_PCTRACE" != "" ] && [ -f `basename $binary`.stf ]
then
   echo "Use -g flag or $exec_gcov binary for source code..." && traceanalyzer `basename $binary`.stf
elif [ "$NSYS" = 1 ]
then
   # Pas clair encore ces differentes versions de Nsys:
   [ -f $NOM.qdrep ]    && nsys-ui $NOM.qdrep    # petra
   [ -f $NOM.nsys-rep ] && nsys-ui $NOM.nsys-rep # a6000
   #nm -D /lib64/libk5crypto.so.3 2>/dev/null | grep 'U EVP_KDF_ctrl' >/dev/null
   #if [[ ${PIPESTATUS[1]} -eq 0 ]]; then
   #   echo "libk5crypto.so.3 requires EVP_KDF_ctrl. Switching to system OpenSSL libraries" >&2
   #   LD_PRELOAD=/lib64/libcrypto.so.1.1:/lib64/libssl.so.1.1 nsight-sys 
   #else
   #   echo "Sorry, can't run nsight-sys GUI for GPU profiling..."
   #fi
elif [ "$NCU" = 1 ]
then
   # Marche pas encore:
   [ -f $NOM.qdrep.ncu-rep ] && ncu-ui $NOM.qdrep.ncu-rep
fi
exit $err
