#!/bin/bash
#FLUX: --job-name=phat-house-9720
#FLUX: --queue=${MY_SC_PARTITION}
#FLUX: --urgency=16

export homebrewDependencies='()'
export caskDependencies='()'
export gemDependencies='()'

VERSION="v1.3.2"                                                                       #
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UTILS_LOCATION="${SCRIPT_PATH}/../lib/utils.sh" # Update this path to find the utilities.
if [[ -f "${UTILS_LOCATION}" ]]; then
source "${UTILS_LOCATION}"
else
echo "Please find the file util.sh and add a reference to it in this script. Exiting..."
exit 1
fi
FUNCS_LOCATION="${SCRIPT_PATH}/../lib/sharedFunctions.sh" # Update this path to find the shared functions.
VARS_LOCATION="${SCRIPT_PATH}/../lib/sharedVariables.sh" # Update this path to find the shared variables.
if [[ -f "${FUNCS_LOCATION}" ]] && [[ -f "${VARS_LOCATION}" ]]; then
source "${FUNCS_LOCATION}" ;
source "${VARS_LOCATION}" ;
else
echo "Please find the files sharedFunctions.sh and sharedVariables.sh and add references to them in this script. Exiting... "
exit 1
fi
CONFIG_FILE_LOCATION="${SCRIPT_PATH}/../etc/snapp_runner.cfg" # Update this path to find the snapp_runner.cfg file.
trapCleanup () {
echo ""
if is_dir "${tmpDir}"; then
rm -r "${tmpDir}"
fi
die "Exit trapped. In function: '${FUNCNAME[*]}'"
}
safeExit () {
if is_dir "${tmpDir}"; then
rm -r "${tmpDir}"
fi
trap - INT TERM EXIT
exit
}
quiet=false
printLog=false
verbose=false
force=false
strict=false
debug=false
args=()
tmpDir="/tmp/${SCRIPT_NAME}.$RANDOM.$RANDOM.$RANDOM.$$"
(umask 077 && mkdir "${tmpDir}") || {
die "Could not create temporary directory! Exiting."
}
logFile="$HOME/Library/Logs/${SCRIPT_BASENAME}.log"
calcAlignmentPIS () {
echo "INFO      | $(date) |----------------------------------------------------------------"
echo "INFO      | $(date) | SNAPPRunner, v1.3.2 December 2020                              "
echo "INFO      | $(date) | Copyright (c) 2017-2020 Justin C. Bagley. All rights reserved. "
echo "INFO      | $(date) |----------------------------------------------------------------"
echo "INFO      | $(date) | Starting SNAPPRunner pipeline... "
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | # Step #1: Set up workspace, and check machine type. " # | tee -a "$MY_OUTPUT_FILE_SWITCH"
echo "INFO      | $(date) | ----------------------------------- "
echoCDWorkingDir
checkMachineType
if [[ "$MY_DEBUG_MODE_SWITCH" != "0" ]]; then set -xv; fi
echo "INFO      | $(date) | Checking for 'snapp_runner.cfg' configuration file... "
if [[ -f ./snapp_runner.cfg ]]; then
echo "INFO      | $(date) | Configuration file check passed. Moving forward with .cfg file in current directory... "
elif [[ ! -f ./snapp_runner.cfg ]]; then
echo "WARNING   | $(date) | Configuration file check FAILED. Copying default .cfg file into current directory... "
cp "$CONFIG_FILE_LOCATION" . ;
echo "INFO      | $(date) | Please edit the default 'snapp_runner.cfg' configuration file just added so that"
echo "INFO      | $(date) | it includes all pertinent information (first 3 variables) before rerunning SNAPPRunner from this directory. "
echo "INFO      | $(date) | Quitting... "
safeExit ;
fi
echo "INFO      | $(date) | Setting up variables, including those specified in the .cfg file..."
MY_XML_FILES=./*.xml ;
MY_NUM_XML="$(ls . | grep "\.xml$" | wc -l)";
echo "INFO      | $(date) | Number of XML files read: $MY_NUM_XML"	# Check number of input files read into program.
MY_SSH_ACCOUNT="$(grep -n "ssh_account" ./snapp_runner.cfg | awk -F"=" '{print $NF}')";
MY_SC_BIN="$(grep -n "bin_path" ./snapp_runner.cfg | awk -F"=" '{print $NF}' | sed 's/\ //g')";
MY_EMAIL_ACCOUNT="$(grep -n "email_account" ./snapp_runner.cfg | awk -F"=" '{print $NF}')";
MY_SC_DESTINATION="$(grep -n "destination_path" ./snapp_runner.cfg | awk -F"=" '{print $NF}' | sed 's/\ //g')";	 # This pulls out the correct destination path on the supercomputer from the "snapp_runner.cfg" configuration file in the working directory (generated/modified by user prior to running SNAPPRunner).
MY_BEAST_PATH="$(grep -n "beast_jar_path" ./snapp_runner.cfg | awk -F"=" '{print $NF}')";
MY_SC_PBS_WKDIR_CODE="$(grep -n "pbs_wkdir_code" ./snapp_runner.cfg | awk -F"=" '{print $NF}')";
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | # Step #2: Make $(calc $MY_NUM_INDEP_RUNS - 1) copies per input XML file, for a total of $MY_NUM_INDEP_RUNS runs of each model/XML in SNAPP with different random seeds. " # | tee -a "$MY_OUTPUT_FILE_SWITCH"
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | Looping through original .xml's and making $(calc $MY_NUM_INDEP_RUNS - 1) copies per file, renaming \
each copy with an extension of '_#.xml'"
echo "INFO      | $(date) | where # ranges from 2 - $MY_NUM_INDEP_RUNS. *** IMPORTANT ***: The starting .xml files MUST \
end in 'run.xml'."
(
for (( i=2; i<="$MY_NUM_INDEP_RUNS"; i++ )); do
find . -type f -name '*run.xml' | while read FILE ; do
newfile="$(echo ${FILE} | sed -e 's/\.xml/\_'$i'\.xml/')" ;
cp "${FILE}" "${newfile}" ;
done
done
)
(
find . -type f -name '*run.xml' | while read FILE ; do
newfile="$(echo ${FILE} |sed -e 's/run\.xml/run_1\.xml/')" ;
cp "${FILE}" "${newfile}" ;
done
)
rm ./*run.xml ;      # Remove the original "run.xml" input files so that only XML files
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | # Step #3: Make directories for runs and generate shell scripts unique to each input file for directing each run. " # | tee -a "$MY_OUTPUT_FILE_SWITCH"
echo "INFO      | $(date) | ----------------------------------- "
if [[ "$MY_SC_PARTITION" = "NULL" ]] && [[ "$MY_STARTING_SEED" = "NULL" ]]; then
(
for i in $MY_XML_FILES; do
mkdir "$(ls -1 "$i" | sed 's/\.xml$//g')" ;
echo "#!/bin/bash
module purge
module load beagle/2.1.2
module load jdk/1.8.0-60
java -Xmx${JAVA_MEM_ALLOC} -jar ${MY_BEAST_PATH} -beagle_sse -seed $(python -c "import random; print random.randint(10000,100000000000)") -beagle_GPU ${i} > ${i}.out
$MY_SC_PBS_WKDIR_CODE
exit 0" > snapp_sbatch.sh ;
chmod +x snapp_sbatch.sh ;
mv ./snapp_sbatch.sh ./"$(ls -1 "$i" | sed 's/.xml$//g')" ;
cp "$i" ./"$(ls -1 "$i" | sed 's/\.xml$//g')" ;
done
)
elif [[ "$MY_SC_PARTITION" = "NULL" ]] && [[ "$MY_STARTING_SEED" != "NULL" ]]; then
(
for i in $MY_XML_FILES; do
mkdir "$(ls -1 "$i" | sed 's/\.xml$//g')";
echo "#!/bin/bash
module purge
module load beagle/2.1.2
module load jdk/1.8.0-60
java -Xmx${JAVA_MEM_ALLOC} -jar ${MY_BEAST_PATH} -beagle_sse -seed ${$MY_STARTING_SEED} -beagle_GPU ${i} > ${i}.out
$MY_SC_PBS_WKDIR_CODE
exit 0" > ./snapp_sbatch.sh ;
chmod +x ./snapp_sbatch.sh ;
mv ./snapp_sbatch.sh ./"$(ls -1 "$i" | sed 's/.xml$//g')" ;
cp "$i" ./"$(ls -1 "$i" | sed 's/\.xml$//g')" ;
done
)
elif [[ "$MY_SC_PARTITION" != "NULL" ]] && [[ "$MY_STARTING_SEED" = "NULL" ]]; then
(
for i in $MY_XML_FILES; do
mkdir "$(ls -1 "$i" | sed 's/\.xml$//g')" ;
echo "#!/bin/bash
module purge
module load beagle/2.1.2
module load jdk/1.8.0-60
java -Xmx${JAVA_MEM_ALLOC} -jar ${MY_BEAST_PATH} -beagle_sse -seed $(python -c "import random; print random.randint(10000,100000000000)") -beagle_GPU ${i} > ${i}.out
$MY_SC_PBS_WKDIR_CODE
exit 0" > ./snapp_sbatch.sh ;
chmod +x ./snapp_sbatch.sh ;
mv ./snapp_sbatch.sh ./"$(ls -1 "$i" | sed 's/.xml$//g')" ;
cp "$i" ./"$(ls -1 "$i" | sed 's/\.xml$//g')" ;
done
)
elif [[ "$MY_SC_PARTITION" != "NULL" ]] && [[ "$MY_STARTING_SEED" != "NULL" ]]; then
(
for i in $MY_XML_FILES; do
mkdir "$(ls -1 "$i" | sed 's/\.xml$//g')" ;
echo "#!/bin/bash
module purge
module load beagle/2.1.2
module load jdk/1.8.0-60
java -Xmx${JAVA_MEM_ALLOC} -jar ${MY_BEAST_PATH} -beagle_sse -seed ${MY_STARTING_SEED} -beagle_GPU ${i} > ${i}.out
$MY_SC_PBS_WKDIR_CODE
exit 0" > ./snapp_sbatch.sh ;
chmod +x ./snapp_sbatch.sh ;
mv ./snapp_sbatch.sh ./"$(ls -1 "$i" | sed 's/.xml$//g')" ;
cp "$i" ./"$(ls "$i" | sed 's/\.xml$//g')" ;
done
)
fi
echo "INFO      | $(date) | Setup and run check on the number of run folders created by the program..."
MY_DIRCOUNT="$(find . -type d | wc -l)";
MY_NUM_RUN_FOLDERS="$(calc "$MY_DIRCOUNT" - 1)";
echo "INFO      | $(date) | Number of run folders created: ${MY_NUM_RUN_FOLDERS} "
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | # Step #4: Create batch submission file, move all run folders created in previous step and submission file to supercomputer. " # | tee -a "$MY_OUTPUT_FILE_SWITCH"
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | Copying run folders to working dir on supercomputer..."
echo "#!/bin/bash
" > ./qsub_top.txt ;
(
for j in ./*/; do
FOLDERNAME="$(echo $j | sed 's/\.\///g')" ;
scp -r $j $MY_SSH_ACCOUNT:$MY_SC_DESTINATION ;	## Safe copy to remote machine.
echo "cd $MY_SC_DESTINATION$FOLDERNAME
sbatch snapp_sbatch.sh
done
)
echo "
$MY_SC_PBS_WKDIR_CODE
exit 0
" > ./qsub_bottom.txt ;
cat ./qsub_top.txt ./cd_and_qsub_commands.txt ./qsub_bottom.txt > ./SNAPPRunner_batch_qsub.sh ;
if [ -f ./SNAPPRunner_batch_qsub.sh ]; then
echo "INFO      | $(date) | Batch queue submission file ('SNAPPRunner_batch_qsub.sh') successfully created. "
else
echo "WARNING   | $(date) | Something went wrong. Batch queue submission file ('SNAPPRunner_batch_qsub.sh') not created. Exiting... "
safeExit ;
fi
echo "INFO      | $(date) | Also copying configuration file to supercomputer..."
scp ./snapp_runner.cfg "$MY_SSH_ACCOUNT":"$MY_SC_DESTINATION" ;
echo "INFO      | $(date) | Also copying sbatch_file to supercomputer..."
scp ./SNAPPRunner_batch_qsub.sh "$MY_SSH_ACCOUNT":"$MY_SC_DESTINATION" ;
echo "INFO      | $(date) | Step #5: Submit all SNAPP jobs to the queue on the supercomputer. "
ssh $MY_SSH_ACCOUNT << HERE
cd $MY_SC_DESTINATION
pwd
chmod u+x ./SNAPPRunner_batch_qsub.sh
./SNAPPRunner_batch_qsub.sh
exit
HERE
echo "INFO      | $(date) | Finished copying run folders to supercomputer and submitting SNAPP jobs to queue!!"
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | # Step #5: Clean up temporary files generated during SNAPPRunner run to this point. " # | tee -a "$MY_OUTPUT_FILE_SWITCH"
echo "INFO      | $(date) | ----------------------------------- "
echo "INFO      | $(date) | Removing temporary files from local machine..."
for (( i=1; i<=MY_NUM_INDEP_RUNS; i++ )); do rm ./*_"$i".xml; done ;
if [[ -s ./qsub_top.txt ]]; then rm ./qsub_top.txt ; fi ;
if [[ -s ./cd_and_qsub_commands.txt ]]; then rm ./cd_and_qsub_commands.txt ; fi ;
if [[ -s ./qsub_bottom.txt ]]; then rm ./qsub_bottom.txt ; fi ;
if [[ -s ./SNAPPRunner_batch_qsub.sh ]]; then rm ./SNAPPRunner_batch_qsub.sh ; fi ;
echo "INFO      | $(date) | Done."
echo "----------------------------------------------------------------------------------------------------------"
echo ""
if [[ "$MY_DEBUG_MODE_SWITCH" != "0" ]]; then set +xv; fi
}
MY_NUM_INDEP_RUNS=5
MY_SC_WALLTIME=71:30:00
JAVA_MEM_ALLOC=5120M
MY_SC_PARTITION=NULL
MY_STARTING_SEED=NULL
MY_DEBUG_MODE_SWITCH=0
USAGE="Usage: $(basename "$0") [OPTION]...
${bold}Options:${reset}
-n   nRuns (def: $MY_NUM_INDEP_RUNS) number of independent SNAPP runs per model (.xml file)
-w   walltime (def: $MY_SC_WALLTIME) run time (hours:minutes:seconds) passed to supercomputer
-m   javaMem (def: $JAVA_MEM_ALLOC) memory, i.e. RAM, allocation for Java. Must be an
appropriate value for the node, with units in M=megabytes or G=gigabytes.
-p   partition (def: NULL) name of supercomputer partition (i.e. group of nodes, or job
queue controlling a specific group of nodes) to use
-s   seed (def: NULL) value of random number seed to start BEAST with
-h   help text (also: -help) echo this help text and exit
-H   verbose help text (also: -Help) echo verbose help text and exit
-V   version (also: --version) echo version of this script and exit
-d   debug (def: 0, off; 1, on also: --debug) run function in Bash debug mode
${bold}OVERVIEW${reset}
THIS SCRIPT automates conducting multiple runs of SNAPP (Bryant et al. 2012; part of BEAST2,
Drummond et al. 2012; Bouckaert et al. 2014) XML input files on a remote supercomputing cluster
that uses SLURM resource management with PBS wrappers, or a PBS resource management system.
The code starts from the current working directory on the user's machine, which contains
one or multiple XML input files with extension '*run.xml' (where * is any set of alphanumeric
characters separated possibly by underscores but no spaces). These files are identified and
run through the SNAPPRunner pipeline, which involves five steps, as follows: (1) set up the
workspace; (2) copy each XML file n times to create n+1 separate run XML files; (3) make
directories for 1 run per XML, <nRuns>, and create shell script with the name 'snapp_sbatch.sh'
that is specific to the input and can be used to submit job to supercomputer and move this
PBS shell script into the corresponding folder; (4) create a batch submission file (PBS
format) and move it and all run folders to the desired working directory on the supercomputer;
and (5) execute the batch submission file on the supercomputer so that all jobs are submitted
to the supercomputer queue.
Like other functions of PIrANHA that automate running software on external machines, some
information used by SNAPPRunner is extracted from an external configuration file named
'snapp_runner.cfg'. There are six entries that users can supply in this file. However, three
of these are essential for running SNAPP with the SNAPPRunner function, including: ssh user
account information, the path to the parent directory for SNAPP runs on the supercomputer,
the user's email address, and the absolute path to the beast.jar file on the supercomputer
that you wish to use. Users must fill this information in and save a new version of the .cfg
file in the working directory on their local machine prior to calling the program. Only then
can the user call the program using PIrANHA (see usage examples below).
It is assumed that BEAST2 (e.g. 2.4.2++) is installed on the supercomputer, and that user
can provide absolute paths to the BEAST jar file in the cfg file. Last testing was conducted
using BEAST v2.4.5. Check for BEAST2 updates at BEAST2.org.
${bold}Usage examples:${reset}
Call the program using PIrANHA, as follows:
piranha -f SNAPPRunner                                 Run program with the defaults and parameters
extracted from the configuration file
piranha -f SNAPPRunner -n 10                           Pass argument that increases number of runs to 10
piranha -f SNAPPRunner -n 10 -w 24:00:00 -m 2048M      Also increase default walltime and memory (RAM) settings
piranha -f SNAPPRunner -h                              Show this help text and exit
${bold}CITATION${reset}
Bagley, J.C. 2020. PIrANHA v0.4a4. GitHub repository, Available at:
<https://github.com/justincbagley/PIrANHA>.
${bold}REFERENCES${reset}
Bouckaert, R., Heled, J., Künert, D., Vaughan, T.G., Wu, C.H., Xie, D., Suchard, M.A.,
Rambaut, A., Drummond, A.J. 2014. BEAST2: a software platform for Bayesian evolutionary
analysis. PLoS Computational Biology, 10, e1003537.
Bryant, D., Bouckaert, R., Felsenstein, J., Rosenberg, N.A., RoyChoudhury, A. 2012. Inferring
species trees directly from biallelic genetic markers: bypassing gene trees in a full
coalescent analysis. Molecular Biology and Evolution, 29, 1917–1932.
Drummond, A.J., Suchard, M.A., Xie, D., Rambaut, A. 2012. Bayesian phylogenetics with BEAUti
and the BEAST 1.7. Molecular Biology and Evolution, 29, 1969-1973.
Created by Justin Bagley on Thu, 11 May 2017 07:48:55 -0400.
Copyright (c) 2017-2020 Justin C. Bagley. All rights reserved.
"
VERBOSE_USAGE="Usage: $(basename "$0") [OPTION]...
${bold}Options:${reset}
-n   nRuns (def: $MY_NUM_INDEP_RUNS) number of independent SNAPP runs per model (.xml file)
-w   walltime (def: $MY_SC_WALLTIME) run time (hours:minutes:seconds) passed to supercomputer
-m   javaMem (def: $JAVA_MEM_ALLOC) memory, i.e. RAM, allocation for Java. Must be an
appropriate value for the node, with units in M=megabytes or G=gigabytes.
-p   partition (def: NULL) name of supercomputer partition (i.e. group of nodes, or job
queue controlling a specific group of nodes) to use
-s   seed (def: NULL) value of random number seed to start BEAST with
-h   help text (also: -help) echo this help text and exit
-H   verbose help text (also: -Help) echo verbose help text and exit
-V   version (also: --version) echo version of this script and exit
-d   debug (def: 0, off; 1, on also: --debug) run function in Bash debug mode
${bold}OVERVIEW${reset}
THIS SCRIPT automates conducting multiple runs of SNAPP (Bryant et al. 2012; part of BEAST2,
Drummond et al. 2012; Bouckaert et al. 2014) XML input files on a remote supercomputing cluster
that uses SLURM resource management with PBS wrappers, or a PBS resource management system.
The code starts from the current working directory on the user's machine, which contains
one or multiple XML input files with extension '*run.xml' (where * is any set of alphanumeric
characters separated possibly by underscores but no spaces). These files are identified and
run through the SNAPPRunner pipeline, which involves five steps, as follows: (1) set up the
workspace; (2) copy each XML file n times to create n+1 separate run XML files; (3) make
directories for 1 run per XML, <nRuns>, and create shell script with the name 'snapp_sbatch.sh'
that is specific to the input and can be used to submit job to supercomputer and move this
PBS shell script into the corresponding folder; (4) create a batch submission file (PBS
format) and move it and all run folders to the desired working directory on the supercomputer;
and (5) execute the batch submission file on the supercomputer so that all jobs are submitted
to the supercomputer queue.
Like other functions of PIrANHA that automate running software on external machines, some
information used by SNAPPRunner is extracted from an external configuration file named
'snapp_runner.cfg'. There are six entries that users can supply in this file. However, three
of these are essential for running SNAPP with the SNAPPRunner function, including: ssh user
account information, the path to the parent directory for SNAPP runs on the supercomputer,
the user's email address, and the absolute path to the beast.jar file on the supercomputer
that you wish to use. Users must fill this information in and save a new version of the .cfg
file in the working directory on their local machine prior to calling the program. Only then
can the user call the program using PIrANHA (see usage examples below).
It is assumed that BEAST2 (e.g. 2.4.2++) is installed on the supercomputer, and that user
can provide absolute paths to the BEAST jar file in the cfg file. Last testing was conducted
using BEAST v2.4.5. Check for BEAST2 updates at BEAST2.org.
${bold}DETAILS${reset}
The -n flag sets the number of independent SNAPP runs to be submitted to the supercomputer
for each model specified in a .xml file in the current working directory. The default is 5
runs.
The -w flag passes the expected amount of time for each SNAPP run to the supercomputer
management software, in hours:minutes:seconds (00:00:00) format. If your supercomputer does
not use this format, or does not have a walltime requirement, then you will need to modify
the shell scripts for each run and re-run them without specifying a walltime.
The -m flag passes the amount of RAM memory to be allocated to beast.jar/Java during each
SNAPP run. The default (5120 megabytes, or ~5 gigabytes) is around five times the typical
default value of 1024M (~1 GB). Suggested values in MB units: 1024M, 2048M, 3072M, 4096M,
or 5120M, or in terms of GB units: 1G, 2G, 3G, 4G, 5G.
${bold}Usage examples:${reset}
Call the program using PIrANHA, as follows:
piranha -f SNAPPRunner                                 Run program with the defaults and parameters
extracted from the configuration file
piranha -f SNAPPRunner -n 10                           Pass argument that increases number of runs to 10
piranha -f SNAPPRunner -n 10 -w 24:00:00 -m 2048M      Also increase default walltime and memory (RAM) settings
piranha -f SNAPPRunner -h                              Show this help text and exit
${bold}CITATION${reset}
Bagley, J.C. 2020. PIrANHA v0.4a4. GitHub repository, Available at:
<https://github.com/justincbagley/piranha>.
${bold}REFERENCES${reset}
Bouckaert, R., Heled, J., Künert, D., Vaughan, T.G., Wu, C.H., Xie, D., Suchard, M.A.,
Rambaut, A., Drummond, A.J. 2014. BEAST2: a software platform for Bayesian evolutionary
analysis. PLoS Computational Biology, 10, e1003537.
Bryant, D., Bouckaert, R., Felsenstein, J., Rosenberg, N.A., RoyChoudhury, A. 2012. Inferring
species trees directly from biallelic genetic markers: bypassing gene trees in a full
coalescent analysis. Molecular Biology and Evolution, 29, 1917–1932.
Drummond, A.J., Suchard, M.A., Xie, D., Rambaut, A. 2012. Bayesian phylogenetics with BEAUti
and the BEAST 1.7. Molecular Biology and Evolution, 29, 1969-1973.
Created by Justin Bagley on Thu, 11 May 2017 07:48:55 -0400.
Copyright (c) 2017-2020 Justin C. Bagley. All rights reserved.
"
if [[ "$1" == "-h" ]] || [[ "$1" == "-help" ]]; then
echo "$USAGE"
exit
fi
if [[ "$1" == "-H" ]] || [[ "$1" == "-Help" ]]; then
echo "$VERBOSE_USAGE"
exit
fi
if [[ "$1" == "-V" ]] || [[ "$1" == "--version" ]]; then
echo "$(basename "$0") $VERSION";
exit
fi
while getopts 'n:w:m:p:s:d:' opt ; do
case $opt in
n) MY_NUM_INDEP_RUNS=$OPTARG ;;
w) MY_SC_WALLTIME=$OPTARG ;;
m) JAVA_MEM_ALLOC=$OPTARG ;;
p) MY_SC_PARTITION=$OPTARG ;;
s) MY_STARTING_SEED=$OPTARG ;;
d) MY_DEBUG_MODE_SWITCH=$OPTARG ;;
:) printf "Missing argument for -%s\n" "$OPTARG" >&2
echo "$USAGE" >&2
exit 1 ;;
\?) printf "Illegal option: -%s\n" "$OPTARG" >&2
echo "$USAGE" >&2
exit 1 ;;
esac
done
trap trapCleanup EXIT INT TERM
IFS=$'\n\t'
set -o errexit
if ${debug}; then set -x ; fi
if ${strict}; then set -o nounset ; fi
set -o pipefail
SNAPPRunner
safeExit
