#!/bin/bash
#FLUX: --job-name=astute-bike-9305
#FLUX: --urgency=16

export MAX_JOBS_ENCHAINES='`$TRUST_Awk -F= '/MAX_JOBS_ENCHAINES=/ {print $2}' $sub_file` '
export ARCHIVAGE='`$TRUST_Awk -F= '/ARCHIVAGE=/ {print $2}' $sub_file` '

help()
{
echo "Script to run in a directory containing
a submission file, mandatory named sub_file.
Usage:`basename $0` [-help] [-test] [-long_test]
The script will first change slightly the submission file.
Then it will submit several jobs in order to reduce the
wait between different TRUST runs and will organize the
stop and restart of each run.
Several important files (results, saving files,...) will
be stored also locally or in a available storing disc 
(according to the cluster) after each run.
The -test option is useful to test the script on few
timesteps of your calculation with 2 runs separated
by a stop and retart.
The -long_test option is useful to test the script on
few timesteps of your calculation with 5 runs separated
by a stop and retart.
"
}
archivage()
{
   # Archivage sauf si specifie par l'utilisateur:
   if [ "$ARCHIVAGE" != "NO" ]
   then
      # On fait une sauvegarde sur $CCCSTOREDIR ou $STOREDIR si le repertoire existe et si l'utilisateur n'a pas specifie d'options d'archivage
      # sinon en local dans le repertoire d'etude
      if [ $sub = CCC ]
      then
         if [ "$CCCSTOREDIR" != "" ] && [ -d $CCCSTOREDIR ] && [ "$ARCHIVAGE" != "FAST_LOCAL" ]
         then
	    DIRSAUV=`pwd | $TRUST_Awk -F"/" -v p=$CCCSTOREDIR -v h=$HOME '{n=split(h,a,"/")+1;for (i=n;i<=NF;i++) p=p"/"$i;print p}'`"/SAUV-$temps"
	    ln -sf $DIRSAUV . 2>/dev/null
         else
	    DIRSAUV=`pwd`"/SAUV-$temps"
         fi
      else
         if [ "$STOREDIR" != "" ] && [ -d $STOREDIR ] && [ "$ARCHIVAGE" != "FAST_LOCAL" ]
         then
	    DIRSAUV=`pwd | $TRUST_Awk -F"/" -v p=$STOREDIR -v h=$HOME '{n=split(h,a,"/")+1;for (i=n;i<=NF;i++) p=p"/"$i;print p}'`"/SAUV-$temps"
	    ln -sf $DIRSAUV . 2>/dev/null
         else
	    DIRSAUV=`pwd`"/SAUV-$temps"
         fi
      fi
      mes=$mes"Saving files under $DIRSAUV (could take several minutes)...\n"
      message -i
      mkdir -p $DIRSAUV 2>/dev/null	 
      DIRSAUV=$DIRSAUV/.
      # On fait un fichier ASCII_files.tar.gz
      begin=`date +%s`
      ASCII_files=`ls *.data *.out *.err *.dat *Channel_Flow_Rate_repr_* *Pressure_Gradient_* *.son *.TU *.dt_ev 2>/dev/null`
      if [ "$ARCHIVAGE" = "FAST_LOCAL" ]
      then
         cp -f $ASCII_files $DIRSAUV/.
      else	
         if [ "$ARCHIVAGE" = "NOT_GZIP" ]
         then
	    tar cf $DIRSAUV/ASCII_files.tar $ASCII_files
         else
            tar cf - $ASCII_files | gzip --fast -f -c > $DIRSAUV/ASCII_files.tar.gz
         fi
      fi
      end=`date +%s`
      time_spent=`echo $end-$begin | bc 2>/dev/null`
      if [ "$ARCHIVAGE" = "FAST_LOCAL" ]
      then
         mes=$mes"ASCII_files copied in $time_spent seconds.\n"
      else	
         if [ "$ARCHIVAGE" = "NOT_GZIP" ]
         then
            mes=$mes"ASCII_files.tar created in $time_spent seconds.\n"
         else
            mes=$mes"ASCII_files.tar.gz created in $time_spent seconds.\n"
         fi
      fi
      # On fait un tar par format puis on efface (sauf fichiers de sauvegarde):
      formats="lml lata sauv xyz"
      for format in $formats
      do
	 files=`ls *.$format* 2>/dev/null` && [ $format = sauv ] && files=$sauv
	 # Verrue: Repertoire lata parfois cree par les utilisateurs du Front Tracking
	 [ -d lata ] && files=`ls *.$format* lata/*.$format* 2>/dev/null` 
	 if [ ${#files} != 0 ]
	 then
	    # tar cf et gzip (MACHINE-DEPENDANT)
	    # Pas de compression si binaire (car sinon 3* plus lent que le tar simple)
	    # ou on deplace si archivage rapide
	    begin=`date +%s`
	    if [ "$ARCHIVAGE" = "FAST_LOCAL" ]
	    then
	       cp -f $files $DIRSAUV/.
	    elif [ "`file -b $files | grep -i ascii`" != "" ] && [ "$ARCHIVAGE" != "NOT_GZIP" ]
	    then
	       tar cf - $files | gzip --fast -f -c > $DIRSAUV/$format.tar.gz
	    else
	       tar cf $DIRSAUV/$format.tar $files
	    fi
	    end=`date +%s`
	    time_spent=`echo $end-$begin | bc 2>/dev/null`
	    if [ "$ARCHIVAGE" = "FAST_LOCAL" ]
	    then
	       mes=$mes"$format files copied in $time_spent seconds.\n"
	    elif [ "`file -b $files | grep -i ascii`" != "" ] && [ "$ARCHIVAGE" != "NOT_GZIP" ]
	    then
	       mes=$mes"$format.tar.gz created in $time_spent seconds.\n"
	    else
	       mes=$mes"$format.tar created in $time_spent seconds.\n"
            fi
	    [ $format != sauv ] && [ $format != xyz ] && rm -f $files
	 fi
      done
   fi
}
message()
{
   [ "$1" != -i ] && mes=$mes"#################################################################"
   echo $ECHO_OPTS $mes | tee -a reprise_auto.log
   mes=""
}
resoumission()
{
if [ $test != 0 ]
then
   # Creation d'un repertoire de travail
   rep_tmp=test_reprise_auto
   rm -r -f $rep_tmp
   mkdir $rep_tmp 2>/dev/null
   cd $rep_tmp
   # Copie des donnees
   echo "Copy of the files in directory $rep_tmp..."
   cp ../* . 2>/dev/null
   # Changement des valeurs suivantes:
   job=RepriseAutoTest
   # Duree du cas test (MACHINE-DEPENDANT)  
   [ $sub = PBS ] && cpu=00:30:00
   [ $sub = SGE ] && cpu=00:30
   [ $sub = LSF ] && cpu=00:30
   if [ $sub = CCC ]
   then
      cpu=00:30
      MSUB=`grep "#BSUB -W" $sub_file`
      if [ "$MSUB" != "" ]
      then
         MSUB_NEW="#BSUB -W $cpu"
      else
         MSUB=`grep "#MSUB -T" $sub_file`
	 MSUB_NEW="#MSUB -T 1800"
      fi
   fi
   [ $sub = SLURM ] && cpu=00:30:00
   # Changement du sub_file pour le nom (MACHINE-DEPENDANT)  
   [ $sub = PBS ] && echo $ECHO_OPTS "1,$ s? -N .*? -N $job?g\nw" | ed $sub_file 1>/dev/null 2>&1
   [ $sub = SGE ] && echo $ECHO_OPTS "1,$ s? -N .*? -N $job?g\nw" | ed $sub_file 1>/dev/null 2>&1
   [ $sub = LSF ] && echo $ECHO_OPTS "1,$ s? -J .*? -J $job?g\nw" | ed $sub_file 1>/dev/null 2>&1   
   [ $sub = CCC ] && echo $ECHO_OPTS "1,$ s? -r .*? -r $job?g\nw" | ed $sub_file 1>/dev/null 2>&1   
   [ $sub = SLURM ] && echo $ECHO_OPTS "1,$ s? -J .*? -J $job?g\nw" | ed $sub_file 1>/dev/null 2>&1   
   # Changement du sub_file pour mettre en queue test (MACHINE-DEPENDANT)
   [ $sub = PBS ] && echo $ECHO_OPTS "1,$ s? -l walltime=.*? -l walltime=$cpu?g\nw" | ed $sub_file 1>/dev/null 2>&1
   [ $sub = SGE ] && echo $ECHO_OPTS "1,$ s? -q .*? -q test?g\nw" | ed $sub_file 1>/dev/null 2>&1
   [ $sub = LSF ] && echo $ECHO_OPTS "1,$ s? [0-9][0-9]:[0-9][0-9]? $cpu?g\nw" | ed $sub_file 1>/dev/null 2>&1  
   [ $sub = CCC ] && echo $ECHO_OPTS "1,$ s?$MSUB?$MSUB_NEW?g\nw" | ed $sub_file 1>/dev/null 2>&1 
   [ $sub = CCC ] && echo $ECHO_OPTS "1,$ s?#MSUB -Q normal?#MSUB -Q test?g\nw" | ed $sub_file 1>/dev/null 2>&1 
   [ $sub = SLURM ] && echo $ECHO_OPTS "1,$ s? -t .*? -t $cpu?g\nw" | ed $sub_file 1>/dev/null 2>&1
   # Changement du sub_file pour le chemin vers l'etude (MACHINE-DEPENDANT)
   [ $sub = PBS ] && echo $ECHO_OPTS "1,$ s?cd .*?cd \$PBS_O_WORKDIR?g\nw" | ed $sub_file 1>/dev/null 2>&1   
   [ $sub = SGE ] && echo $ECHO_OPTS "1,$ s?cd .*?cd \$SGE_CWD_PATH?g\nw" | ed $sub_file 1>/dev/null 2>&1   
   [ $sub = LSF ] && echo $ECHO_OPTS "1,$ s?cd .*?cd \$LS_SUBCWD?g\nw"    | ed $sub_file 1>/dev/null 2>&1   
   [ $sub = CCC ] && echo $ECHO_OPTS "1,$ s?cd .*?cd \$BRIDGE_MSUB_PWD?g\nw"    | ed $sub_file 1>/dev/null 2>&1 
   [ $sub = SLURM ] && echo $ECHO_OPTS "1,$ s?cd .*?cd \$SLURM_SUBMIT_DIR?g\nw"    | ed $sub_file 1>/dev/null 2>&1 
   # Changement du .data en cas de chemins relatifs
   for data in *.data
   do
      echo $ECHO_OPTS "1,$ s? \.\./? \.\./\.\./?g\nw" | ed $data 1>/dev/null 2>&1
   done
   echo "Several jobs are submitted now."
   echo "Check the file reprise_auto.log to monitor all the tasks done."
   echo "#################################################################"
fi
if [ "`waiting`" = 0 ]
then
   if [ "`running`" = 0 ]
   then
      # On vient de lancer le script en interactif donc on
      # soumet le job initial (MACHINE-DEPENDANT) 
      [ $sub = PBS ] && mes=$mes"Submission of the job $job now:\n`$qsub sub_file 2>&1`\n" 
      [ $sub = SGE ] && mes=$mes"Submission of the job $job now:\n`$qsub sub_file 2>&1`\n" 
      [ $sub = LSF ] && mes=$mes"Submission of the job $job now:\n`bsub < sub_file 2>&1`\n"
      [ $sub = CCC ] && mes=$mes"Submission of the job $job now:\n`ccc_msub sub_file 2>&1`\n"
      [ $sub = SLURM ] && mes=$mes"Submission of the job $job now:\n`sbatch sub_file 2>&1`\n"
   fi
   # On lance apres le job initial max jobs soit un total de max+1 jobs
   # sauf si un fichier .stop_soumission existe dans le repertoire
   [ $test = 2 ] && max=5 && touch .stop_soumission
   [ $test = 1 ] && max=1 && touch .stop_soumission
   [ $test = 0 ] && max=$MAX_JOBS_ENCHAINES && [ -f .stop_soumission ] && max=0
   restart=`date '+%m:%d:%H:%M'`
   # Calcul de la periode entre lancement de jobs
   # On relance tous les $cpu - 1 heure si HH>01 et $cpu - 25mn sinon
   periode=`echo $cpu | $TRUST_Awk -F: '{h=$1;m=$2;s=$3;if (h>1) h--;else if (m>25) m-=25;temps=h":"m;if (s!="") temps=temps":"s;print temps}'`
   let i=0   
   while [ $i -lt $max ]
   do
      let i=$i+1
      # On calcule le temps de restart 
      restart=`ajoute $restart:$periode`
      # On cree un sub_file_next copie du sub_file (MACHINE-DEPENDANT)
      shell='' && [ "`grep '#!/bin' $sub_file`" != "" ] && shell=`grep '#!/bin' $sub_file`'\n'
      sub_file_next=$sub_file"_next"
      [ $sub = PBS ] && echo $ECHO_OPTS "$shell#PBS -a `echo $restart | $TRUST_Awk '{gsub(":","",$0);print $0}'`" > $sub_file_next # Format restart MMDDHHMN
      [ $sub = SGE ] && echo $ECHO_OPTS "$shell#$ -a `echo $restart | $TRUST_Awk '{gsub(":","",$0);print $0}'`" > $sub_file_next # Format restart MMDDHHMN
      [ $sub = LSF ] && echo $ECHO_OPTS "$shell#BSUB -b $restart" > $sub_file_next # Format restart MM:DD:HH:MN
      if [ $sub = CCC ]
      then
         # Pas de balise possible pour CCRT pour un job en differe?
         if [ $HOST = cobalt ]
	 then
	    echo $ECHO_OPTS "$shell#MSUB -E '--begin `date '+%Y'-``echo $restart | $TRUST_Awk -F: '{print $1"-"$2"T"$3":"$4}'`'" > $sub_file_next
	 else
            echo $ECHO_OPTS "$shell#BSUB -b $restart" > $sub_file_next # Format restart MM:DD:HH:MN
	 fi
      fi
      [ $sub = SLURM ] && echo $ECHO_OPTS "$shell#SBATCH --begin `date '+%Y'-``echo $restart | $TRUST_Awk -F: '{print $1"-"$2"T"$3":"$4}'`" > $sub_file_next # Format restart MMDDHHMN
      # A noter que #MSUB -a ou #MSUB -S ne marche pas sur titane, le CCRT conseille #BSUB -b
      cat $sub_file >> $sub_file_next    
      # Soumission du job (MACHINE-DEPENDANT) 
      [ $sub = PBS ] && mes=$mes"Submission of the job $job delayed to MM:DD:HH:MN=$restart :\n`$qsub $sub_file_next 2>&1`\n" 
      [ $sub = SGE ] && mes=$mes"Submission of the job $job delayed to MM:DD:HH:MN=$restart :\n`$qsub $sub_file_next 2>&1`\n" 
      [ $sub = LSF ] && mes=$mes"Submission of the job $job delayed to MM:DD:HH:MN=$restart :\n`bsub < $sub_file_next 2>&1`\n"
      [ $sub = CCC ] && mes=$mes"Submission of the job $job delayed to MM:DD:HH:MN=$restart :\n`ccc_msub $sub_file_next 2>&1`\n"
      [ $sub = SLURM ] && mes=$mes"Submission of the job $job delayed to MM:DD:HH:MN=$restart :\n`sbatch $sub_file_next 2>&1`\n"
      # Pour tester plusieurs demarrages de JOBS en meme temps, decommenter:
      # mes=$mes"Soumission du job $job pour un demarrage souhaite a MM:JJ:DD:MN=$restart :\n`bsub < $sub_file_next 2>&1`\n"
      # mes=$mes"Soumission du job $job pour un demarrage souhaite a MM:JJ:DD:MN=$restart :\n`bsub < $sub_file_next 2>&1`\n"
   done
else
   mes=$mes
   #mes=$mes"`waiting` jobs deja en attente. On n'en relance pas d'autres.\n" 
fi
}
ajoute()
{
echo $1 | $TRUST_Awk -F: '{m=$1+0;j=$2+0;mn=$4+$6;h=$3+$5;
while (mn>59) {mn-=60;h++};
if (mn<10) {mn="0"mn};
while (h>23) {h-=24;j++};
if (h<10) {h="0"h};
while (j>31) {j-=31;m++};
if (j<10) {j="0"j};
while (m>12) {m-=12};
if (m<10) {m="0"m};
print m":"j":"h":"mn}'
}
check_err()
{
    # Verifier l'etat du calcul (erreur, converge, temps final atteint...)
    # Pour une erreur, on se base sur le message de Process::exit(int i)
   if [ "`grep 'TRUST has caused an error and will stop' $err`" != "" ] || [ "`grep 'TRUST error message' $err`" != "" ]
   then
      mes=$mes"Error detected in the previous TRUST calculation! See $ETUDE/$err".old".\n" && cp -f $err $err".old"
      archivage;message;exit -1
   fi
   if [ "`grep -i 'temps final' $err | grep atteint`" != "" ] || [ "`grep -i 'final time reached' $err`" != "" ]
   then
      mes=$mes"The $err file indicates the final time is reached for the calculation $job in the directory $ETUDE.\n"
      archivage;message;exit -1 
   fi
   if [ "`grep -i 'Le calcul est converge' $err`" != "" ] || [ "`grep -i 'a atteint un regime stationnaire' $err`" != "" ] || [ "`grep -i 'has reached the steady state' $err`" != "" ]
   then
      mes=$mes"The $err file indicates the calculation $job is converged in the directory $ETUDE.\n"
      archivage;message;exit -1
   fi
   if [ "`grep -i 'Le nombre maximum de pas de temps est atteint' $err`" != "" ] || [ "`grep -i 'nombre de pas de temps max atteint' $err`" != "" ] || [ "`grep -i 'maximum number of time steps reached' $err`" != "" ]
   then
      mes=$mes"The $err file indicates the maximal number of time steps is reached for the calculation $job in the directory $ETUDE.\n"
      archivage;message;exit -1
   fi
}
waiting()
{
   [ $sub = PBS ] && qstat    -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {wait=0} ($10!="R")      {wait++} END {print wait}'
   [ $sub = SGE ] && qstat    -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {wait=0} (NF==8)         {wait++} END {print wait}'
   [ $sub = LSF ] && qstat -a -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {wait=0} ($5=="WAITING") {wait++} END {print wait}'
   [ $sub = CCC ] && qstat -a -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {wait=0} ($5=="WAITING") {wait++} END {print wait}'
   [ $sub = SLURM ] && squeue -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {wait=0} ($5!="R")       {wait++} END {print wait}'
}
running()
{
   [ $sub = PBS ] && qstat    -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {run=0} ($10=="R")      {run++} END {print run}'
   [ $sub = SGE ] && qstat    -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {run=0} (NF==9)         {run++} END {print run}'
   [ $sub = LSF ] && qstat -a -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {run=0} ($5!="WAITING") {run++} END {print run}'
   [ $sub = CCC ] && qstat -a -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {run=0} ($5!="WAITING") {run++} END {print run}'
   [ $sub = SLURM ] && squeue -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk 'BEGIN {run=0} ($5=="R")       {run++} END {print run}'
}
check_max_jobs()
{
   IDS="1 2"
   while [ "`echo $IDS | wc -w`" -gt 1 ]
   do
      # Recherches des JOBS en cours
      [ $sub = PBS ] && IDS=`qstat    -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk '($10=="R")      {print $1}' | sort -n`
      [ $sub = SGE ] && IDS=`qstat    -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk '(NF==9)         {print $1}' | sort -n`
      [ $sub = LSF ] && IDS=`qstat -a -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk '($5!="WAITING") {print $3}' | sort -n` 
      [ $sub = CCC ] && IDS=`qstat -a -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk '($5!="WAITING") {print $3}' | sort -n`
      [ $sub = SLURM ] && IDS=`squeue -u $qui 2>/dev/null | grep " $job " | $TRUST_Awk '($5=="R")       {print $1}' | sort -n`
      # On doit avoir au plus UN JOB autre que le LAST_JOBID
      LAST_JOBID=`cat .LAST_JOBID 2>/dev/null` # ID du JOB en cours de calcul
      JOB=0
      NB_ID=`echo $IDS | wc -w`
      # On empeche le lancement de plusieurs reprise_auto
      if [ $NB_ID -ge 1 ] && [ "$Execution" = 0 ]
      then
	 echo "$NB_ID $job job(s) is(are) already running... Wait that it's finished or"
	 echo "stop reprise_auto, change the name of the job in the sub_file and rerun reprise_auto."	 
	 exit -1   
      fi
      CALCUL_RUNNING=0
      for ID in $IDS
      do
	 if [ "$ID" = "$LAST_JOBID" ]
	 then
	    # Un JOB (LAST_JOBID) est en train de faire du calcul
	    CALCUL_RUNNING=1
	 else
            let JOB=$JOB+1
	 fi
	 if [ $JOB = 1 ] && [ $CALCUL_RUNNING = 1 ]
	 then
	    # Le JOB suivant stoppe proprement le calcul du JOB_LASTID
	    # Recupere le temps CPU deja passe en minutes (MACHINE-DEPENDANT)
	    [ $sub = PBS ] && CPU_USED="`qstat -a -u $qui | $TRUST_Awk -v job=$job '($4==job) && ($(NF-1)=="R") {split($NF,a,":");print a[1]*60+a[2]}'`"
	    [ $sub = SGE ] && CPU_USED="" # Pas trouve la commande: qstat -ext sort un cpu qui semble faux. Voir qstat -F -ext
	    [ $sub = LSF ] && CPU_USED=`bjobs -l | $TRUST_Awk -v np=$np '/ CPU / {print $6/60/np}'`
	    [ $sub = CCC ] && CPU_USED=`ccc_mstat | $TRUST_Awk -v job=$job '($5==job) {print $9/60}'`
	    [ $sub = SLURM ] && CPU_USED="`squeue -u $qui | $TRUST_Awk -v job=$job '($3==job) && ($(NF-1)=="R") {split($NF,a,":");print a[1]*60+a[2]}'`"
	    [ "$CPU_USED" != "" ] && CPU_USED=" since $CPU_USED minutes"
            mes=$mes"Calculation $job ($LAST_JOBID) running on $HOST$CPU_USED will be stopped and restarted.\n"
            echo 1 > ${data%.data}.stop	  
	    sleep 60  	    
         elif [ $JOB -gt 1 ] && [ $ID = $JOB_ID ]
         then
            mes=$mes"The job $ID will be killed because it competes with other jobs.\n"
            message
	    qdel $ID
	    sleep 60
         fi
      done
   done
}
[ -f /opt/Sge/bin/lx24-amd64/qstat ] && export PATH=/opt/Sge/bin/lx24-amd64:$PATH # Sur castor, qstat n'etait pas trouve en batch
qstat 1>/dev/null 2>&1 
if [ $? != 0 ]
then
   echo "qstat command has not been found. Contact TRUST support."
   exit -1
fi
ETUDE=`pwd`
ECHO_OPTS="" && [ "`echo -e`" != "-e" ] && ECHO_OPTS="-e"
qui=`whoami`
mes=""
[ ${#TRUST_ROOT} = 0 ] && mes=$mes"You should be under TRUST environment\n to use this script $0.\n" && message && exit -1
echo "
02/12/16: CCRT cluster cobalt is supported (CCC)
20/07/16: It is possible to put 'export ARCHIVAGE=NOT_GZIP' in the submission file to not gzip the tar archives
13/05/15: CINES cluster occigen supported (SLURM)
13/05/15: \$CCCSTOREDIR is equivalent to \$STOREDIR on CCRT clusters and \$STOREDIR exists on CINES cluster
25/01/13: Messages translated in english
25/01/13: Option -meshtv is suppressed
04/09/12: CCRT cluster airain is supported (LSF-MOAB-CCC)
21/03/12: TGCC cluster curie is supported (LSF-MOAB-CCC)
06/12/11: Reduce the number of files stored under \$CCCSTOREDIR
06/12/11: Bug fixed for path to \$CCCSTOREDIR
24/11/11: Use of the CCCSTOREDIR environment variable instead of the DMFDIR variable on the CCRT clusters
11/10/11: Channel_Flow_Rate_repr_ and Pressure_Gradient_ files are now stored also
11/10/11: Bug fixed: Files .sauv et .son moved and not copied anymore to fast local storing (ARCHIVAGE=FAST_LOCAL)
23/09/11: It is possible to put 'export MAX_JOBS_ENCHAINES=N' in the submission file to specify the number of jobs submitted to N (2 or 5 by default according the clusters)
23/09/11: It is possible to put 'export ARCHIVAGE=NO' in the submission file to not store anything after each run
23/09/11: It is possible to put 'export ARCHIVAGE=FAST_LOCAL' in the submission file to do a fast (withou compression) local storing
07/07/11: On CCRT cluster titane, try to run a delayed command to stop properly the calculation 30mn before the end of the job
17/05/10: Passage possible d'options dans la ligne de commande de calcul TRUST du fichier de soumission 
16/03/10: Add a log file reprise_auto.log to check the different operations of the script
15/03/10: Add a test to avoid several jobs start in the same time
25/05/09: CCRT cluster titane supported (LSF-MOAB-CCC)
30/03/09: CINES cluster jade supported (PBS)
28/05/08: Faster storing (binary files are not compressed anymore and --fast option added to the gzip command)
15/01/08: Use of the DMFDIR environment variable on the CCRT clusters
21/12/07: Bug fixed: .son deleted, wrong relative path in the datafile with the -test option
21/12/07: The -sonde option is suppressed cause TRUST now appends into the .son files
22/11/07: The platine CCRT cluster is supported (LSF)
16/07/07: The lata directory is added to the storing if necessary
22/06/07: The -sonde option added to append .son probe files
05/06/07: The castor cluster is supported (SGE)
05/12/06: The -meshtv is added to help creating movies with VisIt
02/12/05: If \$DMFDIR is not found, the storing will be local in the directory
29/11/05: Now several files are stored under \$DMFDIR in one .tar.gz file to redure access time to \$DMFDIR
31/05/05: The nickel/chrome/tantale clusters are supported (LSF)
For more help, contact TRUST support at $TRUST_MAIL
Messages from the script $0:
[ ${#1} != 0 ] && [ $1 = -help ] && help && exit -1
test=0
[ ${#1} != 0 ] && [ $1 = -test ] && test=1
[ ${#1} != 0 ] && [ $1 = -long_test ] && test=2
if [ "$SGE_ROOT" != "" ]
then
   sub="SGE"
   export PATH=$SGE_BINARY_PATH:$PATH # SGE perd l'environnement...
   qsub="qsub -v TRUST_ROOT -v exec" # SGE perd l'environnement et on lui passe au moins TRUST_ROOT et exec
elif [ "`ls /*/pbs 2>/dev/null`" != "" ]
then
   sub="PBS"
   qsub=`find /*/pbs -name qsub | tail -1`
   export PATH=${qsub%/qsub}:$PATH
elif [ "`ccc_msub -help 1>/dev/null 2>&1;echo $?`" = 0 ]
then
   # Pas sur que #MSUB fonctionne, meme si ccc_msub existe
   sub="CCC"
elif [ "`squeue --help 1>/dev/null 2>&1;echo $?`" = 0 ]
then
   sub="SLURM"
else
   sub="LSF"
fi
if [ $HOST != occigen ] && [ $HOST != cobalt ] # Supported
then
   if [ $HOST = mars ] || [ $HOST = eris ]
   then
      mes=$mes"Cluster $HOST is not supported for $0 because it is useless: there is no CPU limit on $0.\nContact TRUST support for more information.\n" && message && exit -1
   elif [ $HOST = nickel ] && [ $HOST = chrome ] && [ $HOST = tantale ] && [ $HOST = castor ] && [ $HOST = platine ] && [ $HOST = jade ] && [ $HOST = titane ]
   then
      mes=$mes"Cluster $HOST is no longer tested for $0\nContact TRUST support.\n" && message && exit -1
   else
      mes=$mes"Cluster $HOST is not supported yet for $0\nContact TRUST support.\n" && message && exit -1
   fi
fi
sub_file=sub_file
[ ! -f $sub_file ] && mes=$mes"No $sub_file file in the directory $ETUDE\n
You could create a submission file with the trust command:\n
trust -create_sub_file datafile number_of_cpus\n\n
Then, you would run again: `basename $0`\n" && message && exit -1
if [ $sub = PBS ]
then
   job=`$TRUST_Awk '($2=="-N") {print substr($3,1,10)}' $sub_file` # 10 premiers caracteres
   [ ${#job} = 0 ] && mes=$mes"Directive -N not found in $ETUDE/$sub_file!\n" && message && exit -1  
elif [ $sub = SGE ]
then
   job=`$TRUST_Awk '($2=="-N") {print substr($3,1,10)}' $sub_file` # 10 premiers caracteres
   [ ${#job} = 0 ] && mes=$mes"Directive -N not found in $ETUDE/$sub_file!\n" && message && exit -1
elif [ $sub = LSF ]
then
   job=`$TRUST_Awk '($2=="-J") {print substr($3,1,12)}' $sub_file` # 12 premiers caracteres
   [ ${#job} = 0 ] && mes=$mes"Directive -J not found in $ETUDE/$sub_file!\n" && message && exit -1
elif [ $sub = CCC ]
then
   job=`$TRUST_Awk '($2=="-r") {print substr($3,1,12)}' $sub_file` # 12 premiers caracteres
   [ ${#job} = 0 ] && mes=$mes"Directive -r not found in $ETUDE/$sub_file!\n" && message && exit -1   
elif [ $sub = SLURM ]
then
   job=`$TRUST_Awk '($2=="-J") {print substr($3,1,8)}' $sub_file` # 12 premiers caracteres
   [ ${#job} = 0 ] && mes=$mes"Directive -J not found in $ETUDE/$sub_file!\n" && message && exit -1   
fi
if [ $sub = PBS ]
then
   np="inutile"
elif [ $sub = SGE ]
then
   np=`$TRUST_Awk '($2=="-pe") {print $NF}' $sub_file`
   [ ${#np} = 0 ] && mes=$mes"Directive -pe not found in $ETUDE/$sub_file!\n" && message && exit -1
elif [ $sub = LSF ]
then
   np=`$TRUST_Awk '($2=="-n") {print $3}' $sub_file`
   [ ${#np} = 0 ] && mes=$mes"Directive -n not found in $ETUDE/$sub_file!\n" && message && exit -1
elif [ $sub = CCC ]
then
   np=`$TRUST_Awk '($2=="-n") {print $3}' $sub_file`
   [ ${#np} = 0 ] && mes=$mes"Directive -n not found in $ETUDE/$sub_file!\n" && message && exit -1 
elif [ $sub = SLURM ]
then
   np=`$TRUST_Awk '($2=="-n") {print $3}' $sub_file`
   [ ${#np} = 0 ] && mes=$mes"Directive -n not found in $ETUDE/$sub_file!\n" && message && exit -1 
fi
export MAX_JOBS_ENCHAINES=`$TRUST_Awk -F= '/MAX_JOBS_ENCHAINES=/ {print $2}' $sub_file` 
export ARCHIVAGE=`$TRUST_Awk -F= '/ARCHIVAGE=/ {print $2}' $sub_file` 
if [ $sub = PBS ]
then
   cpu=`$TRUST_Awk -F'walltime=' '/walltime=/ {print $NF}' $sub_file`
   ici=`pwd` && [ "`basename $ici`" = "test_reprise_auto" ] && cpu="00:30:00"
   [ "$MAX_JOBS_ENCHAINES" = "" ] && MAX_JOBS_ENCHAINES=5
   [ ${#cpu} = 0 ] && mes=$mes"Directive #PBS -l walltime=HH:MM:SS not found in $ETUDE/$sub_file!\n" && message && exit -1
elif [ $sub = SGE ]
then
   cpu="72:00" # Pas d'option sur SGE pour fixer la duree CPU du JOB ? Sur castor 72 heures...
   ici=`pwd` && [ "`basename $ici`" = "test_reprise_auto" ] && cpu="00:30"
   [ "$MAX_JOBS_ENCHAINES" = "" ] && MAX_JOBS_ENCHAINES=1
elif [ $sub = LSF ]
then
   cpu=`$TRUST_Awk '($2=="-W") && /:/ {print $3}' $sub_file`
   [ "$MAX_JOBS_ENCHAINES" = "" ] && MAX_JOBS_ENCHAINES=5
   [ ${#cpu} = 0 ] && mes=$mes"Directive #BSUB -W HH:MM not found in $ETUDE/$sub_file!\n" && message && exit -1
elif [ $sub = CCC ]
then
   cpu=`$TRUST_Awk '($2=="-T") {h=int($3/3600);m=int(($3-3600*h)/60);print h":"m} ($2=="-W") {print $3}' $sub_file`
   [ "$MAX_JOBS_ENCHAINES" = "" ] && MAX_JOBS_ENCHAINES=5
   [ ${#cpu} = 0 ] && mes=$mes"Directive #MSUB -T SS or #BSUB -W HH:MN not found in $ETUDE/$sub_file!\n" && message && exit -1
elif [ $sub = SLURM ]
then
   cpu=`$TRUST_Awk '($2=="-t") && /:/ {print $3}' $sub_file`
   [ "$MAX_JOBS_ENCHAINES" = "" ] && MAX_JOBS_ENCHAINES=5
   [ ${#cpu} = 0 ] && mes=$mes"Directive #SBATCH -t HH:MM:SS not found in $ETUDE/$sub_file!\n" && message && exit -1
fi
format="Error, the instructions should be: $0 && command_line_to_run_parallel_TRUST datafile 1>datafile.out 2>datafile.err\n" 
if [ "`grep -i 'reprise_auto &&' $sub_file`" = "" ]
then
   # Recupere le premier parametre de la ligne contenant 1> et 2> 
   ligne=`$TRUST_Awk '/1>/ && /2>/ {print $0}' $sub_file`
   [ ${#ligne} = 0 ] && mes=$mes$format && message && exit -1
   echo $ECHO_OPTS "1,$ s?$ligne?$0 \&\& $ligne?g\nw" | ed $sub_file 1>/dev/null 2>&1
   mes=$mes"File $sub_file changed to add the script $0\n" 
fi
data=`$TRUST_Awk '/reprise_auto &&/ { for (i=3;i<=NF;i++) {gsub("\\\.data","",$i);file=$i".data";if (system("[ -f "file" ] && ok=1")==0) {data=file;exit}} } \
END {print data} \
' $sub_file`
[ $data = ".data" ] && mes=$mes$format && message && exit -1
[ ! -f $data ] && mes=$mes"Pas de jeu de donnees $data dans $ETUDE\n" && message && exit -1
dos2unix_ $data
out=`$TRUST_Awk '/reprise_auto &&/ {out=$(NF-1);gsub("1>","",out);print out}' $sub_file`
[ ${#out} = 0 ] && mes=$mes$format && message && exit -1
[ ${out%.out} != ${data%.data} ] && mes=$mes"The $out file should be ${data%.data}.out in $sub_file\n" && message && exit -1
err=`$TRUST_Awk '/reprise_auto &&/ {err=$(NF);gsub("2>","",err);print err}' $sub_file`
[ ${#err} = 0 ] && mes=$mes$format && message && exit -1
[ ${err%.err} != ${data%.data} ] && mes=$mes"The $err file should be ${data%.data}.err in $sub_file\n" && message && exit -1
Execution=0 # reprise_auto n'est pas appele depuis le sub_file mais en interactif
[ $sub = PBS ] && [ "$PBS_O_WORKDIR" != "" ] 		&& Execution=1 && JOB_ID=`echo $PBS_JOBID | $TRUST_Awk -F"." '{print $1}'` 
[ $sub = SGE ] && [ "$SGE_CWD_PATH" != "" ]  		&& Execution=1 && JOB_ID=`echo $SGE_STDERR_PATH | $TRUST_Awk -F".e" '{print $NF}'` 
[ $sub = LSF ] && [ "$LS_SUBCWD" != "" ]     		&& Execution=1 && JOB_ID=$LSB_JOBID
[ $sub = CCC ] && [ "$BRIDGE_MSUB_PWD" != "" ]     	&& Execution=1 && JOB_ID=$BRIDGE_MSUB_JOBID && [ "$JOB_ID" = "" ] && JOB_ID=$LSB_JOBID && [ "$JOB_ID" = "" ] && JOB_ID=$PBS_JOBID
[ $sub = SLURM ] && [ "$SLURM_SUBMIT_DIR" != "" ]     	&& Execution=1 && JOB_ID=`echo $SLURM_JOBID | $TRUST_Awk -F"." '{print $1}'`
if [ $Execution = 0 ]
then
   rm -f reprise_auto.log
   mes=$mes"Message of $0 on $HOST ($sub):\n"
else
   mes=$mes"Message of job $JOB_ID on $HOST ($sub):\n"
   # Lancement d'une commande differee pour arreter le calcul dans $periode
   # Sur 30 minutes, le at est execute au bout de 20 minutes.
   # Sur N heures, le at sera execute a N heures - 30 minutes
   # Mise en commentaire car forte suspicion de blocage
   #minutes=`echo $cpu | $TRUST_Awk -F: '{h=$1;m=$2;if (h>1) {print (h-1)*60+m+30} else if (m>25) {print m-10}}'`
   #mes=$mes"Running a delayed command to stop the calculation after $minutes minutes.\n"
   #mes=$mes"The calculation should be stopped at the date: "`echo "echo 1 > ${data%.data}.stop" | at -v now + $minutes minutes 2>&1`" \n"
fi
check_max_jobs
sauvs=`grep -i -e 'sauvegarde ' -e 'sauvegarde_simple ' $data | $TRUST_Awk '(NF==2 || NF==3) {print $NF}'`
if [ ${#sauvs} != 0 ]
then
   # Dans le jeu de donnees
   sauv=""
   for file in $sauvs
   do
      fin=`echo $file | $TRUST_Awk -F. '{print $NF}'`
      deb=${file%.$fin}
      tmp=`ls $deb*.$fin 2>/dev/null`
      [ ${#tmp} != 0 ] && sauv=$sauv" "$tmp
   done
else
   # Par defaut
   sauv=`ls ${data%.data}*.sauv 2>/dev/null`
fi
if [ ${#sauv} != 0 ]
then
   # Verifie si les fichiers de sauvegarde ne sont pas vides
   for file in $sauv
   do
      [ ! -s $file ] && mes=$mes"Warning, the file $file is empty... Your dt_sauv keyword is may be too small in the file $data ?\n" && message && exit -1
   done
   [ ! -f $out ] && mes=$mes"File $out not found in the directory $ETUDE whereas saving files (.sauv or .xyz) have been found.\nDelete the saving files?\n" && message && exit -1
   [ ! -f $err ] && mes=$mes"File $err not found in the directory $ETUDE\n" && message && exit -1  
   temps=`grep -E "Backup of the field|Sauvegarde du champ" $err | tail -1 | $TRUST_Awk '{print $NF}'`  
   # Verification du .err
   check_err
   if [ ${#temps} != 0 ]
   then
      archivage
      mes=$mes"The data file $data has been changed to retart at tinit=$temps\n"   
      Run_reprise $data -no_gui 1>>Run_reprise.log 2>&1
   else
      mes=$mes"No backup times found in the $err file\n$data file is not changed.\n"
   fi
else
   # Verification eventuelle du .err
   [ -f $err ] && check_err
   mes=$mes"No saving files (.sauv or .xyz) found.\n$data file is not changed.\n"
fi
resoumission
if [ $Execution = 1 ]
then  
   # Verifie qu'il n'y a qu'un seul job running avant le demarrage du calcul
   check_max_jobs
   demarrage="Starting" && [ "$temps" != "" ] && demarrage="Restarting"
   mes=$mes"$demarrage the calculation at `grep -i tinit $data`\n" 
   # Recupere le numero du dernier job arrete
   if [ -f .LAST_JOBID ]
   then
      LAST_JOBID=`cat .LAST_JOBID`
      mv -f $out $out$LAST_JOBID
      mv -f $err $err$LAST_JOBID
   fi
   echo $JOB_ID > .LAST_JOBID
fi
message
