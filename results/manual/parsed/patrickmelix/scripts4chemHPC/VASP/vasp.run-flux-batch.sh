#!/bin/bash
#FLUX: --job-name=GO
#FLUX: -N=12
#FLUX: --exclusive
#FLUX: --queue=short
#FLUX: -t=14400
#FLUX: --urgency=16

ISTART_RESTART=1 #https://www.vasp.at/wiki/index.php/ISTART
module load vasp/6.2.0-vtst-openmpi-4.0.5-intel-19.0.5.281-cuda-11.2.1 #Quest
THREADSperCORE=$(lscpu | grep 'Thread(s) per core' | awk '{print $4}') #possiblity 1
echo "THREADSperCORE $THREADSperCORE" #works
echo "SLURM_CPUS_ON_NODE  $SLURM_CPUS_ON_NODE" #works
TOTALcpu=$(( SLURM_JOB_NUM_NODES * SLURM_CPUS_ON_NODE ))
echo "TOTALcpu $TOTALcpu"
NMPITASKS=$(( TOTALcpu / THREADSperCORE ))
echo "NMPITAKS $NMPITASKS"
MPIBIN="mpirun -n $NMPITASKS" #quest
VASPBIN="vasp_gam" # change vasp_std to vasp_gam for gamma only
MAXRUNS=4 # Maximum number of runs
RUNSCRIPT="vasp.run" # name of this file, $(basename $0) does not work, it is overwritten by SLURM sometimes...
ignore=("KPOINTS" "POTCAR" "$RUNSCRIPT" "INCAR") # files that stay where they are during restart
INTERRUPTFILE="EXIT" # create this file to prevent auto restart manually
NELDML="-1" # When using a WAVECAR to restart, change the value of NELDML to this one. Comment out or leave empty to disable.
set -e
function set_incar_option()
{
   #$1: keyword, $2 value
   echo "Processing INCAR for key $1"
   if grep -i "[[:space:]]*$1[[:space:]]*=[[:space:]]*$2" INCAR | grep -qv "[[:space:]]*#[[:space:]]*$1[[:space:]]*=[[:space:]]*"
   then
      echo "- $1=$2 already set"
   else
      echo -n "- Setting $1=$2"
      if grep -iq "$1" INCAR
      then
         echo " by changing value"
         sed -i "s/[[:space:]]*$1[[:space:]]*=[[:space:]]*[0-9]/$1=$2/I" INCAR
      else
         echo " by appending to INCAR"
         echo "$1=$2" >> INCAR
      fi
   fi
}
function set_wavecar_chgcar()
{
   echo "Copying WAVECAR+CHGCAR+INCAR and setting options..."
   cp ./${1}/WAVECAR .
   cp ./${1}/CHGCAR .
   cp INCAR ./${1}/
   set_incar_option ISTART $ISTART_RESTART
   set_incar_option ICHARG 1
   echo "... Done!"
}
function set_wavecar()
{
   echo "Copying WAVECAR+INCAR and setting options..."
   cp ./${1}/WAVECAR .
   cp INCAR ./${1}/
   set_incar_option ISTART $ISTART_RESTART
   set_incar_option ICHARG 0
   echo "... Done!"
}
function set_chgcar()
{
   echo "Copying CHGCAR+INCAR and setting options..."
   cp ./${1}/CHGCAR .
   cp INCAR ./${1}/
   set_incar_option ISTART 0
   set_incar_option ICHARG 1
   echo "... Done!"
}
function restart_neb()
{
   echo -n "Checking if Job finished while waiting..."
   if grep -iq "aborting loop because hard stop was set" 01/OUTCAR
   then
      echo " not the case, continuing with restart"
   else
      echo " seems like it. Or there might be another problem. Not restarting."
      exit 0
   fi
   #find highest numeric subfolder with -NEB
   n="$(find . -regextype posix-extended -maxdepth 1 -regex ".\/[0-9]+-NEB" -type d | sort -Vr | head -1 | sed 's/.\///' | sed 's/-NEB//')"
   n=$((n+1))
   if [ "$n" -ge "$MAXRUNS" ]; then
      echo "Maximum number of runs reached, exiting!"
      exit 1
   fi
   #find number of images
   nImages="$(find . -regextype posix-extended -maxdepth 1 -regex ".\/[0-9]+" -type d | sort -Vr | head -1 | sed 's/.\///')"
   echo "Found $((nImages-1)) images."
   echo -n "Moving files to subdir ${n}-NEB, "
   mkdir ${n}-NEB || { echo 'mkdir failed' ; exit 1; }
   #move all files to subfolder n-NEB, except these:
   #also need to add 00 and last folder in case they are symlinks
   ignore+=("$(printf "%02d" $nImages)")
   ignore+=("00")
   echo -n "ignoring these files: ${ignore[*]}, moving all others..."
   find . -maxdepth 1 -type f -not -name "${ignore[0]}" $(printf -- '-not -name %s ' "${ignore[@]:1}") -exec mv -t ./${n}-NEB/ {} + || { echo 'moving files failed' ; exit 1; }
   #not sure why joint f l does not work, so have to run second time for symlinks
   find . -maxdepth 1 -type l -not -name "${ignore[0]}" $(printf -- '-not -name %s ' "${ignore[@]:1}") -exec mv -t ./${n}-NEB/ {} + || { echo 'moving symlinks failed' ; exit 1; }
   #create symlinks to 00 and last folder, makes analysis easier
   ln -s ../00 ./${n}-NEB/00
   ln -s ../"$(printf "%02d" $nImages)" ./${n}-NEB/"$(printf "%02d" $nImages)"
   echo -n " Processing $((nImages-1)) images: "
   for (( i=1; i<$nImages; i++  ))
   do
      pi=$(printf "%02d" $i)
      echo -n " ${pi},"
      mv $pi ${n}-NEB/
      mkdir $pi
      cd $pi
      #save space by creating symlinks
      ln -s ../${n}-NEB/$pi/CONTCAR POSCAR
      cd ..
   done
   echo " Done!"
}
function restart_normal()
{
   echo -n "Checking if Job finished while waiting..."
   if grep -iq "aborting loop because hard stop was set" OUTCAR
   then
      echo " not the case, continuing with restart"
   else
      echo " seems like it. Or there might be another problem. Not restarting."
      exit 0
   fi
   #find highest numeric subfolder
   n="$(find . -regextype posix-extended -maxdepth 1 -regex ".\/[0-9]+" -type d | sort -Vr | head -1 | sed 's/.\///')"
   n=$((n+1))
   if [ "$n" -ge "$MAXRUNS" ]; then
      echo "Maximum number of runs reached, exiting!"
      exit 1
   fi
   echo -n "Moving files to subdir ${n}, "
   mkdir ${n} || { echo 'mkdir failed' ; exit 1; }
   #move all files to subfolder n, except these:
   #not sure why joint f l does not work, so have to run second time for symlinks
   echo -n "Ignoring these files: ${ignore[*]}, moving all others..."
   find . -maxdepth 1 -type f -not -name "${ignore[0]}" $(printf -- '-not -name %s ' "${ignore[@]:1}") -exec mv -t ./${n}/ {} + || { echo 'moving files failed' ; exit 1; }
   find . -maxdepth 1 -type l -not -name "${ignore[0]}" $(printf -- '-not -name %s ' "${ignore[@]:1}") -exec mv -t ./${n}/ {} + || { echo 'moving symlinks failed' ; exit 1; }
   echo "... Done!"
   #save space by creating symlinks
   echo -n "Create symlinks..."
   if grep -i "[[:space:]]*ICHAIN[[:space:]]*\=[[:space:]]*2" INCAR | grep -qv "[[:space:]]*#[[:space:]]*ICHAIN[[:space:]]*\=[[:space:]]*2"
   then
      echo -n "DIMER run detected!"
      ln -s ./${n}/CENTCAR POSCAR
      ln -s ./${n}/NEWMODECAR MODECAR
   else
      ln -s ./${n}/CONTCAR POSCAR
   fi
   echo "... Done!"
   if [[ -s ./${n}/WAVECAR ]] && [[ -s ./${n}/CHGCAR ]]; then #WAVECAR and CHGCAR restart
      set_wavecar_chgcar $n
   elif [[ -s ./${n}/WAVECAR ]]; then #WAVECAR restart
      set_wavecar $n
      if [[ ! -z ${NELDML} ]]; then #set NELDML
         set_incar_option NELDML ${NELDML}
      fi
   elif [[ -s ./${n}/CHGCAR ]]; then #CHGCAR restart
      set_chgcar $n
   else
      echo "Neither WAVECAR or CHGCAR exist to restart from, exiting"
      exit 1
   fi
}
function restart()
{
   #check for interruptfile at beginning and end
   if [ -e "$INTERRUPTFILE" ];
   then
      echo "Interruptfile found, exiting."
      exit 1
   fi
   if [ -e "STOPCAR" ];
   then
      echo "STOPCAR found, this should have been deleted by VASP. Aborting restart."
      exit 1
   fi
   echo "Preparing restart..."
   #NEB runs need another restart function
   if grep -i "[[:space:]]*ICHAIN[[:space:]]*\=[[:space:]]*0" INCAR | grep -qv "[[:space:]]*#[[:space:]]*ICHAIN[[:space:]]*\=[[:space:]]*0"
   then
      echo "NEB run detected!"
      restart_neb
   else
      restart_normal
   fi
   #check for interruptfile
   if [ -e "$INTERRUPTFILE" ];
   then
      echo "Interruptfile found, exiting."
      exit 1
   else
      echo "Resubmitting now"
      sbatch "${RUNSCRIPT}"
   fi
}
function terminate()
{
   echo "Caught SLURM signal, writing STOPCAR"
   echo "LABORT = .True." > STOPCAR
}
trap 'terminate; wait; restart; exit 0' 12 #15 and 18 are getting sent before killing by slurm on quest
$MPIBIN $VASPBIN &
wait
echo "VASP terminated normally, exiting."
exit 0
