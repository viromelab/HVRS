#!/bin/bash
#
eval "$(conda shell.bash hook)"
#
NR_THREADS=6;
MAX_RAM=48;
#
CREATE_RECONSTRUCTION_FOLDERS=1;
#
#RUN_SHORAH=0;
RUN_QURE=0; #w
RUN_SAVAGE_NOREF=0; #rn
RUN_SAVAGE_REF=0; 
#RUN_QSDPR=0; 
RUN_SPADES=0; #t
RUN_METASPADES=0; #t
RUN_METAVIRALSPADES=0; #t
RUN_CORONASPADES=0; #t
RUN_VIADBG=0;
#RUN_VIRUSVG=0; #t
#RUN_VGFLOW=0; #t
#RUN_PREDICTHAPLO=0;
RUN_TRACESPIPELITE=0; #t
RUN_TRACESPIPE=0; #t
RUN_ASPIRE=0;
RUN_QVG=0; #t
RUN_VPIPE=0; 
RUN_STRAINLINE=0;
RUN_HAPHPIPE=0;
#RUN_ABAYESQR=0;
#RUN_HAPLOCLIQUE=0;
RUN_VISPA=0; #t
#RUN_QUASIRECOMB=0;
RUN_LAZYPIPE=0; #w 
#RUN_VIQUAS=0;
RUN_MLEHAPLO=0;
RUN_PEHAPLO=0; #w
#RUN_REGRESSHAPLO=0;
#RUN_CLIQUESNV=0;
RUN_IVA=0; 
RUN_PRICE=0;
RUN_VIRGENA=0; #w
RUN_TARVIR=0;
RUN_VIP=0;
RUN_DRVM=0;
RUN_SSAKE=0; #w
#RUN_VIRALFLYE=0;
RUN_ENSEMBLEASSEMBLER=0;
RUN_HAPLOFLOW=0; #w
#RUN_TENSQR=0;
RUN_VIQUF=0;
RUN_IRMA=0;
#
RESULT=0
#
RUN_CLASSIFICATION="0";
TOP="150";
#
CURR_DIR=$(pwd)
#
declare -a DATASETS=("DS4" "DS6") # "DS2" "DS3" "DS4" "DS5" "DS6" "DS7" "DS8" "DS9" "DS10" "DS11" "DS12" "DS13"  "DS14"  "DS15"  "DS16" "DS17"  "DS18"  "DS19"  "DS20"  "DS21"  "DS22"  "DS23"  "DS24"  "DS25"  "DS26"  "DS27"  "DS28"  "DS29"  "DS30"  "DS31"  "DS32"  "DS33"  "DS34"  "DS35"  "DS36"  "DS37"  "DS38"  "DS39"  "DS40"  "DS41"  "DS42"  "DS43"  "DS44"  "DS45"  "DS46"  "DS47"  "DS48"  "DS49"  "DS50"  "DS51"  "DS52"  "DS53"  "DS54"  "DS55"  "DS56"  "DS57"  "DS58"  "DS59"  "DS60"  "DS61"  "DS62");
declare -a VIRUSES=("B19" "HPV" "VZV" "MCPyV" "MT");
#
#declare -a DATASETS=("DS63")
#declare -a VIRUSES=("B19" "HPV" "VZV" "MCPyV" "HHV6B" "MT");
#
#declare -a DATASETS=("DS64")
#declare -a VIRUSES=("B19" "HPV" "VZV" "POLY7" "EBV" "MT");
#
#declare -a DATASETS=("DS65")
#declare -a VIRUSES=("B19" "HPV" "VZV" "MCPyV" "CMV" "MT");
#
VIRGENA_TIMEOUT=15;
OVERALL_TIMEOUT=360;
#
ASSUME_YES="0";
#
declare -a VIRUSES_AVAILABLE=("B19V" "BuV" "CuV" "HBoV" "AAV" "BKPyV" "JCPyV" "KIPyV"
                    "WUPyV" "MCPyV" "HPyV6" "HPyV7" "TSPyV" "HPyV9" "MWPyV"
                    "STLPyV" "HPyV12" "NJPyV" "LIPyV" "SV40" "TTV" "TTVmid"
                    "TTVmin" "HAV" "HBV" "HCV" "HDV" "HEV" "SENV" "HPV2"
                    "HPV6" "HPV11" "HPV16" "HPV18" "HPV31" "HPV39" "HPV45"
                    "HPV51" "HPV56" "HPV58" "HPV59" "HPV68" "HPV77" "HSV1"
                    "HSV2" "VZV" "EBV" "HCMV" "HHV6" "HHV7" "KSHV" "ReDoV"
                    "VARV" "MPXV" "EV" "SARS2" "HERV" "MT");
#
#
#creates a fasta file for each of the datasets with paired reads
create_paired_fa_files () { 
  printf "Creating fasta files from .fq files\n\n"
  for dataset in "${DATASETS[@]}"
  do	    
    sed -n '1~4s/^@/>/p;2~4p' ${dataset}_1.fq > tmp_${dataset}_1.fa
    sed -n '1~4s/^@/>/p;2~4p' ${dataset}_2.fq > tmp_${dataset}_2.fa
    cat tmp_${dataset}_*.fa > input.fasta
    perl -pe 's/[\r\n]+/;/g; s/>/\n>/g' input.fasta | sort -t"[" -k2,2V | sed 's/;/\n/g' | sed '/^$/d'
    mv input.fasta gen_$dataset.fasta
  done
}
#
#
check_installation () { 
  NAME_TOOL=$1
  RESULT=0
  ./Verification.sh --$NAME_TOOL > verif.txt
  if [[ $(wc -l < verif.txt ) -eq "1" ]] 
    then
    RESULT=1
  else
    RESULT=0
  fi
  #yprintf "$NAME_TOOL      $RESULT\n"
}
#
CREATE_PAIRED_FALCON () { 
  printf "Creating fasta files from .fq files\n\n"	    
  sed -n '1~4s/^@/>/p;2~4p' ${DATASETS[0]}_1.fq > tmp_new_1.fa
  sed -n '1~4s/^@/>/p;2~4p' ${DATASETS[0]}_2.fq > tmp_new_2.fa
  cat tmp_new_*.fa > input.fasta
  perl -pe 's/[\r\n]+/;/g; s/>/\n>/g' input.fasta | sort -t"[" -k2,2V | sed 's/;/\n/g' | sed '/^$/d' > tmp.txt
  rm $CURR_DIR/tmp.txt
  mv input.fasta paired.fa
}
#
generate_references () { 
  printf "Classifying with FALCON-meta.\n\n"
  OUTPUT_DIR="refs"
  rm -rf $CURR_DIR/$OUTPUT_DIR
  conda activate falcon
  
  #lzma -d $DATABASE.lzma
  lzma -d VDB.fa.lzma
      
  CREATE_PAIRED_FALCON;
  
  FALCON -v -n $NR_THREADS -t $TOP -F -m 6:1:1:0/0 -m 13:50:1:0/0 -m 19:500:1:5/10 -g 0.85 -c 10 -x top-metagenomics.csv paired.fa "VDB.fa"
  #
  ## GET HIGHEST SIMILAR REFERENCE =============================================
  #
  rm -f $CURR_DIR/best-viral-metagenomics.txt
  for VIRUS in "${VIRUSES_AVAILABLE[@]}"
    do
    printf "%s\t" "$VIRUS" >> best-viral-metagenomics.txt;
    #
    RESULT=`cat top-metagenomics.csv | grep -a -f IDS/ID-$VIRUS.ids \
    | awk '{ if($3 > 0 && $2 > 200 && $2 < 9000000) print $3"\t"$4; }' \
    | head -n 1 \
    | awk '{ print $1"\t"$2;}' \
    | sed "s/NC\_/NC-/" \
    | tr '_' '\t' \
    | awk '{ print $1"\t"$2;}'`;
  
    if [ -z "$RESULT" ]
      then
      echo -e "-\t-" >> best-viral-metagenomics.txt
      else
      echo "$RESULT" | sed "s/NC-/NC\_/" >> best-viral-metagenomics.txt
      fi
    done
  
    rm -rf $CURR_DIR/$OUTPUT_DIR
    mkdir $OUTPUT_DIR
    while IFS= read -r line
    do
      PERC="$(cut -d'	' -f2 <<< $line)"
      if [ "$PERC" != "-" ];
        then
        NAME="$(cut -d'	' -f1 <<< $line)"
        ID="$(cut -d'	' -f3 <<< $line)"
        gto_fasta_extract_read_by_pattern -p $ID < VDB.fa | sed 's|/||g' > $NAME.fa
        mv $NAME.fa $OUTPUT_DIR
      fi 
    done < best-viral-metagenomics.txt
   
    mv best-viral-metagenomics.txt $OUTPUT_DIR
    mv top-metagenomics.csv $OUTPUT_DIR
    conda activate base
    cd refs 
    read a
    rm $CURR_DIR/refs/*.csv  
    rm $CURR_DIR/refs/*.txt
    VIRUSES=($(ls -1 *.fa | sed -e 's/\.fa$//'))
   
    
     
    
    printf "$(ls -1 *.fa| sed -e 's/\.fa$//')\n\n"
    
    
    for virus in "${VIRUSES[@]}"
      do
      
      printf "$virus \n"
      
    done 
    
    
    
    
    read a
    cp * ..
    cd ..
}
#
SHOW_MENU () {
  echo " ------------------------------------------------------------------ ";
  echo "                                                                    ";
  echo " Reconstruction.sh : Reconstruction script for HVRS                 ";
  echo "                                                                    ";
  echo " Script to reconstruct all of the datasets contained in HVRS.       "; 
  echo "                                                                    ";
  echo " Program options -------------------------------------------------- ";
  echo "                                                                    ";
  echo " -h, --help                    Show this,                           ";
  echo "                                                                    ";
  echo " --all                         Reconstruction using all tools,      ";
  echo "                                                                    ";
  echo " --coronaspades                Reconstruction using coronaSPAdes,   ";
  echo " --haploflow                   Reconstruction using Haploflow,      ";
  echo " --lazypipe                    Reconstruction using LAZYPIPE,       ";
  echo " --irma                        Reconstruction using IRMA,           ";
  echo " --metaspades                  Reconstruction using metaSPAdes,     ";
  echo " --metaviralspades             Reconstruction using metaviralSPAdes,";
  echo " --pehaplo                     Reconstruction using PEHaplo,        ";
  echo " --qure                        Reconstruction using QuRe,           ";
  echo " --qvg                         Reconstruction using QVG,            ";
  echo " --spades                      Reconstruction using SPAdes,         ";
  echo " --ssake                       Reconstruction using SSAKE,          ";
  echo " --tracespipe                  Reconstruction using TRACESPipe,     ";
  echo " --tracespipelite              Reconstruction using TRACESPipeLite, ";
  echo " --virgena                     Reconstruction using VirGenA,        ";
  echo " --vispa                       Reconstruction using ViSpA,          ";
  echo " --vpipe                       Reconstruction using V-pipe.         ";
  echo "                                                                    ";
  echo " -t  <INT>, --threads <INT>    Number of threads,                   ";
  echo " -m  <INT>, --memory <INT>     Maximum of RAM available,            ";
  echo "                                                                    ";
  echo " --virgena-timeout <INT>       Maximum time used by VirGenA         "; 
  echo "                               to reconstruct with each reference,  ";
  echo " --timeout <INT>               Maximum time used by a reconstruction";
  echo "                               program to reconstruct a genome.     ";
  echo "                                                                    ";
  echo " -r <STR>, --reads <STR>       FASTQ reads file name. The string    ";
  echo "                               must be the name before _1 and _2.fq.";
  echo "                               The references are retrieved using   ";
  echo "                               FALCON-meta.                         ";
  echo "                                                                    ";
  echo " -y, --yes                     Assume the answer to all prompts is yes.";
  echo "                                                                    ";
  echo " --top_falcon  <INT>           Maximum number of references retrived";
  echo "                               by FALCON-meta.                      ";
  echo "                                                                    ";
  echo "                                                                    ";
  echo " Examples --------------------------------------------------------- ";
  echo "                                                                    "; 
  echo " - Reconstruct using all tools                                      ";
  echo "  ./Reconstruction.sh --all                                         ";
  echo "                                                                    ";
  echo " ------------------------------------------------------------------ ";
  }
#
################################################################################
#
if [[ "$#" -lt 1 ]];
  then
  HELP=1;
  fi
#
POSITIONAL=();
#
while [[ $# -gt 0 ]]
  do
  i="$1";
  case $i in
    -h|--help|?)
      HELP=1;
      shift
    ;;
    -y|--yes)
      ASSUME_YES="1";
      shift
    ;;
    --coronaspades)
      check_installation coronaspades;
      RUN_CORONASPADES=$RESULT;
      shift
    ;;
    --haploflow)
      check_installation haploflow;
      RUN_HAPLOFLOW=$RESULT;
      shift
    ;;
    --irma)
      check_installation irma;
      RUN_IRMA=$RESULT;
      shift
    ;;
    --lazypipe)
      check_installation lazypipe;
      RUN_LAZYPIPE=$RESULT;
      shift
    ;;
    --metaspades)
      check_installation metaspades;
      RUN_METASPADES=$RESULT;
      shift
    ;;
    --metaviralspades)
      check_installation metaviralspades;
      RUN_METAVIRALSPADES=$RESULT;
      shift
    ;;
    --pehaplo)
      check_installation pehaplo;
      RUN_PEHAPLO=$RESULT;
      shift
    ;;
    --qure)
      check_installation qure;
      RUN_QURE=$RESULT;
      shift
    ;;
    --qvg)
      check_installation qvg;
      RUN_QVG=$RESULT;
      shift
    ;;
    --spades)      
      check_installation spades;
      RUN_SPADES=$RESULT;
      shift
    ;;
    --ssake)
      check_installation ssake;
      RUN_SSAKE=$RESULT;
      shift
    ;;
    --tracespipe)
      check_installation tracespipe;
      RUN_TRACESPIPE=$RESULT;
      shift
    ;;
    --tracespipelite)
      check_installation tracespipelite;
      RUN_TRACESPIPELITE=$RESULT;
      shift
    ;;
    --virgena)
      check_installation virgena;
      RUN_VIRGENA=$RESULT;
      shift
    ;;
    --vispa)
      check_installation vispa;
      RUN_VISPA=$RESULT;
      shift
    ;;
    --vpipe)
      check_installation vpipe;
      RUN_VPIPE=$RESULT;
      shift
    ;;
    --all)
      check_installation coronaspades;
      RUN_CORONASPADES=$RESULT;
      check_installation haploflow;
      RUN_HAPLOFLOW=$RESULT;
      check_installation irma;
      RUN_IRMA=$RESULT;
      check_installation lazypipe;
      RUN_LAZYPIPE=$RESULT;
      check_installation metaspades;
      RUN_METASPADES=$RESULT;
      check_installation metaviralspades;
      RUN_METAVIRALSPADES=$RESULT;
      check_installation pehaplo;
      RUN_PEHAPLO=$RESULT;
      check_installation qure;
      RUN_QURE=$RESULT;
      check_installation qvg;
      RUN_QVG=$RESULT;
      check_installation spades;
      RUN_SPADES=$RESULT;
      check_installation ssake;
      RUN_SSAKE=$RESULT;
      check_installation tracespipe;
      RUN_TRACESPIPE=$RESULT;
      check_installation tracespipelite;
      RUN_TRACESPIPELITE=$RESULT;
      check_installation virgena;
      RUN_VIRGENA=$RESULT;
      check_installation vispa;
      RUN_VISPA=$RESULT;
      check_installation vpipe;
      RUN_VPIPE=$RESULT;
      shift
    ;;
    --virgena-timeout)
      VIRGENA_TIMEOUT="$2";
      shift 2;
    ;;
    --timeout)
      OVERALL_TIMEOUT="$2";
      if [ "$OVERALL_TIMEOUT" -gt "$VIRGENA_TIMEOUT" ]; then
        VIRGENA_TIMEOUT=$OVERALL_TIMEOUT
      fi
      shift 2;
    ;;
    -t|--threads)
      NR_THREADS="$2";
      shift 2;
    ;;
    -m|--memory)
      MAX_RAM="$2";
      shift 2;
    ;;
    --top_falcon)
      TOP="$2";
      printf "$TOP \n\n"
      shift 2;
    ;;
    -r|--input|--reads)
      declare -a DATASETS=("$2");
      RUN_CLASSIFICATION="1";
      shift 2;
    ;;
    -*) # unknown option with small
    echo "Invalid arg ($1)!";
    echo "For help, try: ./Reconstruction.sh -h"
    exit 1;
    ;;
  esac
  done
#
set -- "${POSITIONAL[@]}" # restore positional parameters
#
################################################################################
#
if [[ "$HELP" -eq "1" ]];
  then
  SHOW_MENU;
  exit;
  fi
#
################################################################################
#

#Creates a folder for each dataset
if [[ "$CREATE_RECONSTRUCTION_FOLDERS" -eq "1" ]] 
  then 
  
  if [[ "$ASSUME_YES" -eq "0" ]] 
  then
    if [[ -d "$(pwd)/reconstructed" ]]
    then
      printf "Main folder where the results will be stored exists. Do you wish to remove it and create a new folder? [Y/N]\n"
    
      read charrm 
    
      if [ "$char" = "Y" ] || [ "$char" = "y" ]; then
        printf "Creating the folders where the results will be stored - $(pwd)/reconstructed/\n\n"
        rm -rf $CURR_DIR/reconstructed
        mkdir reconstructed
        cd reconstructed
        for dataset in "${DATASETS[@]}"
        do
          mkdir $dataset  
        done
        cd ..
   
        elif [ "$char" = "N" ] || [ "$char" = "n" ]; then 
          printf "Skipping ...\n\n"
        else
          printf "Not a valid option. Skipping ... \n\n"
      fi
    
    else
      printf "Creating the folders where the results will be stored - $(pwd)/reconstructed/\n\n"
      rm -rf $CURR_DIR/reconstructed
      mkdir reconstructed
      cd reconstructed
      for dataset in "${DATASETS[@]}"
      do
        mkdir $dataset  
      done
      cd ..
    fi
  
  else #assume_yes = 1
    printf "Creating the folders where the results will be stored - $(pwd)/reconstructed/\n\n"
    #rm -rf $CURR_DIR/reconstructed
    #mkdir reconstructed
    cd reconstructed
    for dataset in "${DATASETS[@]}"
    do
      mkdir $dataset  
    done
    cd ..
  fi
  
fi



#Generates the references with FALCON-meta
if [[ "$RUN_CLASSIFICATION" -eq "1" ]] 
  then 
  
  if [[ "$ASSUME_YES" -eq "0" ]] 
  then
    printf "This process may erase data present in the current directory. Do you wish to continue?[Y/N]\n\n"
    read char
    if [ "$char" = "Y" ] || [ "$char" = "y" ]; then
      generate_references;
    else
      printf "Not a valid option. Skipping ... \n\n"
    fi
  else
    generate_references;
  fi
fi

#spades - working
if [[ "$RUN_SPADES" -eq "1" ]] 
  then
  printf "Reconstructing with SPAdes\n\n"
  eval "$(conda shell.bash hook)"
  conda activate spades

  for dataset in "${DATASETS[@]}"
    do
    
    mkdir spades_reconstruction
    cd spades_reconstruction
    mkdir spades_${dataset}	
    cp ../${dataset}_*.fq spades_${dataset}
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o spades-${dataset}-time.txt spades.py -o spades_${dataset} -1 spades_${dataset}/${dataset}_1.fq -2 spades_${dataset}/${dataset}_2.fq -t $NR_THREADS -m $MAX_RAM 
    
    mv spades-${dataset}-time.txt ../reconstructed/$dataset
    mv spades_${dataset}/scaffolds.fasta spades_${dataset}/spades-${dataset}.fa
    #mv spades_${dataset}/contigs.fasta spades_${dataset}/spades-${dataset}.fa
    cp spades_${dataset}/spades-${dataset}.fa ../reconstructed/$dataset
    cd ..
    rm -rf $CURR_DIR/spades_reconstruction
  done
  conda activate base
fi

#metaspades - working
if [[ "$RUN_METASPADES" -eq "1" ]] 
  then
  printf "Reconstructing with metaSPAdes\n\n"
  eval "$(conda shell.bash hook)"
  conda activate spades
  
  for dataset in "${DATASETS[@]}"
    do
    mkdir metaspades_reconstruction
    cd metaspades_reconstruction
    mkdir metaspades_${dataset}	
    cp ../${dataset}_*.fq metaspades_${dataset}
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o metaspades-${dataset}-time.txt metaspades.py -t $NR_THREADS -o metaspades_${dataset} -1 metaspades_${dataset}/${dataset}_1.fq -2 metaspades_${dataset}/${dataset}_2.fq -t $NR_THREADS -m $MAX_RAM 
    
    mv metaspades-${dataset}-time.txt ../reconstructed/$dataset
    mv metaspades_${dataset}/scaffolds.fasta metaspades_${dataset}/metaspades-${dataset}.fa
    cp metaspades_${dataset}/metaspades-${dataset}.fa ../reconstructed/$dataset
    cd ..
    rm -rf $CURR_DIR/metaspades_reconstruction
    
  done
  conda activate base
fi

#metaviralspades - working
if [[ "$RUN_METAVIRALSPADES" -eq "1" ]] 
  then
  printf "Reconstructing with metaviralSPAdes\n\n"
  eval "$(conda shell.bash hook)"
  conda activate spades
  
  for dataset in "${DATASETS[@]}"
    do
    mkdir metaviralspades_reconstruction
    cd metaviralspades_reconstruction
    mkdir metaviralspades_${dataset}	
    cp ../${dataset}_*.fq metaviralspades_${dataset}
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o metaviralspades-${dataset}-time.txt metaviralspades.py -t 1 -o metaviralspades_${dataset} -1 metaviralspades_${dataset}/${dataserm t}_1.fq -2 metaviralspades_${dataset}/${dataset}_2.fq -t $NR_THREADS -m $MAX_RAM 
    
    mv metaviralspades-${dataset}-time.txt ../reconstructed/$dataset
    mv metaviralspades_${dataset}/scaffolds.fasta metaviralspades_${dataset}/metaviralspades-${dataset}.fa
    cp metaviralspades_${dataset}/metaviralspades-${dataset}.fa ../reconstructed/$dataset
    cd ..
    rm -rf $CURR_DIR/metaviralspades_reconstruction
  done
  
  conda activate base
fi

#coronaspades - working
if [[ "$RUN_CORONASPADES" -eq "1" ]] 
  then
  printf "Reconstructing with coronaSPAdes\n\n"
  eval "$(conda shell.bash hook)"
  conda activate spades
  
  for dataset in "${DATASETS[@]}"
    do
    mkdir coronaspades_reconstruction
    cd coronaspades_reconstruction
    mkdir coronaspades_${dataset}	
    cp ../${dataset}_*.fq coronaspades_${dataset}
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o coronaspades-${dataset}-time.txt coronaspades.py -o coronaspades_${dataset} -1 coronaspades_${dataset}/${dataset}_1.fq -2 coronaspades_${dataset}/${dataset}_2.fq -t $NR_THREADS -m $MAX_RAM 
    mv coronaspades-${dataset}-time.txt ../reconstructed/$dataset
    mv coronaspades_${dataset}/raw_scaffolds.fasta coronaspades_${dataset}/coronaspades-${dataset}.fa
    cp coronaspades_${dataset}/coronaspades-${dataset}.fa ../reconstructed/$dataset
    cd ..
    
    rm -rf $CURR_DIR/coronaspades_reconstruction  
  done
  conda activate base
fi

#viaDBG - err - ./bin/viaDBG: error while loading shared libraries: libboost_system.so.1.60.0: cannot open shared object file: No such file or directory
if [[ "$RUN_VIADBG" -eq "1" ]] 
  then
  printf "Reconstructing with viaDBG\n\n"
  cd viaDBG/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf $CURR_DIR/viaDBG/$dataset
    mkdir $dataset
    
    rm -rf $CURR_DIR/viaDBG/res_$dataset
    mkdir res_$dataset
    
    rm -rf $CURR_DIR/viaDBG/uni_$dataset
    mkdir uni_$dataset
    
    cp ../${dataset}_*.fq $dataset
    
    ./bin/viaDBG -p $dataset -o res_$dataset -u uni_$dataset -k 5 -t $NR_THREADS #-reference [path to reference] --metaquastpath [path to metaquast.py file] --postprocess [remove duplicates from contigs file]
    
    #cd viadbg_docker
    #rm -rf viadbg_${dataset}
    #mkdir viadbg_${dataset}	
    #cp ${dataset}_*.fq viadbg_${dataset}
    #cd ..
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" sudo docker run -d viadbg_docker
    
  done
  cd ..
  
fi

#ShoRAH
if [[ "$RUN_SHORAH" -eq "1" ]] 
  then
  printf "Reconstructing with ShoRAH\n\n"
  
  
fi

#IRMA
if [[ "$RUN_IRMA" -eq "1" ]] 
  then
  printf "Reconstructing with IRMA\n\n"
  
  #create irma module 
  cd flu-amd/IRMA_RES/modules

  for virus in "${VIRUSES[@]}"
    do
    #printf "$(pwd)\n\n"
    rm -rf $CURR_DIR/flu-amd/IRMA_RES/modules/$virus
    cp -r ORG $virus
    cd $virus/reference
    cp ../../../../../$virus.fa  .
    mv $virus.fa consensus.fasta
    cd ../
    ./init.sh
    cd ..
  done
  cd ../../
  
  

  #reconstruct
  for dataset in "${DATASETS[@]}"
    do
  
    for virus in "${VIRUSES[@]}"
      do
      
      if [[ -d "$CURR_DIR/flu-amd/IRMA_RES/modules/$virus" ]]; then
  
        cp ../${dataset}_*.fq .
      
        /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o irma-${virus}-${dataset}-time.txt ./IRMA $virus ${dataset}_1.fq ${dataset}_2.fq $dataset
      
        cd $dataset
        mv *.fasta ..
        cd ..
        rm -rf $CURR_DIR/flu-amd/$dataset
      fi
    done
  
    cat *.fasta > irma-$dataset.fa
    mv irma-$dataset.fa ../reconstructed/$dataset
  
    total_time=0
    total_mem=0
    total_cpu=0
    count=0
    for f in irma-*-$dataset-time.txt
      do
      echo "Processing $f" 
      cat $f
      TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
      CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
      CPU="$(cut -d'%' -f1 <<< $CPU)"
      total_time=`echo "$total_time+$TIME" | bc -l`
      if [[ $MEM -gt $total_mem ]]
      then
        total_mem=$MEM
      fi
      total_cpu=`echo "$total_cpu+$CPU" | bc -l`
      count=`echo "$count+1" | bc -l`
    done
    
  printf "$total_cpu    -   $count     "
  total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
  echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > irma-${dataset}-time.txt
  mv irma-${dataset}-time.txt ../reconstructed/$dataset
  done
  cd ../ 
fi

#savage - runs
if [[ "$RUN_SAVAGE_NOREF" -eq "1" ]] 
  then
  printf "Reconstructing with SAVAGE without reference\n\n"
  eval "$(conda shell.bash hook)"
  conda activate savage
  rm -rf $CURR_DIR/savage
  mkdir savage
  cd savage
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_*.fq .
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o savage-${dataset}-time.txt  savage --split 1 -p1 ${dataset}_1.fq -p2 ${dataset}_2.fq -m 10 -t $NR_THREADS 
    mv savage-${dataset}-time.txt ../reconstructed/$dataset
    mv contigs_stage_c.fasta savage-${dataset}.fa
    cp savage-${dataset}.fa ../reconstructed/$dataset
  done
  cd ..
  conda activate base
fi

#savage - err -> no reads could be aligned to reference error
if [[ "$RUN_SAVAGE_REF" -eq "1" ]] 
  then
  printf "Reconstructing with SAVAGE with reference\n\n"
  eval "$(conda shell.bash hook)"
  conda activate savage
  rm -rf $CURR_DIR/savage
  mkdir savage
  cd savage
  for dataset in "${DATASETS[@]}"
    do
    for virus in "${VIRUSES[@]}"
      do
      cp ../${dataset}_*.fq .
      cp ../$virus.fa .
      /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o savage-ref-${dataset}-time.txt  savage --split 1 -p1 ${dataset}_1.fq -p2 ${dataset}_2.fq -m 10 -t $NR_THREADS --ref $(pwd)/$virus.fa
      mv savage-ref-${dataset}-time.txt ../reconstructed/$dataset
      mv savage/contigs_stage_c.fasta savage/savage-ref-${dataset}.fa
      cp savage/savage-ref-${dataset}.fa ../reconstructed/$dataset 
    done
  done
  cd ..
  conda activate base
fi

#qsdpr - working
#if [[ "$RUN_QSDPR" -eq "1" ]] 
#  then
#  printf "Reconstructing with QSdpr\n\n"
#  eval "$(conda shell.bash hook)"
#  conda activate qsdpr
#  cd QSdpR_v3.2/
#  for dataset in "${DATASETS[@]}"
#    do
#    rm -rf QSdpR_data/${dataset}
#    mkdir QSdpR_data/${dataset}
#    cp ../${dataset}.fa ../${dataset}_.sam ../${dataset}_1.fq ../${dataset}_2.fq QSdpR_data/${dataset}
#    chmod +x ./QSdpR_source/QSdpR_master.sh
#    cd QSdpR_data/
#
#    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o qsdpr-${dataset}-time.txt ../QSdpR_source/QSdpR_master.sh #2 10 ../QSdpR_source ../QSdpR_data sample 1 1000 ../../samtools-1.16.1
#    
#    mv qsdpr-${dataset}-time.txt ../../reconstructed/$dataset
#    mv sample_10_recon.fasta qsdpr_$dataset.fa
#    cp qsdpr_$dataset.fa ../../reconstructed/$dataset
#    cd ..
#  done
#  cd ../
#  conda activate base
#fi

#qure - running
if [[ "$RUN_QURE" -eq "1" ]] 
  then
  printf "Reconstructing with QuRe\n\n"
  eval "$(conda shell.bash hook)"
  conda activate java-env
  create_paired_fa_files  
  cd QuRe_v0.99971/
  for dataset in "${DATASETS[@]}"
    do
    for virus in "${VIRUSES[@]}"
    do
    printf "$virus\n\n\n\n\n\n"
    cp ../gen_$dataset.fasta ../${virus}.fa .
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o qure-$virus-${dataset}-time.txt java -Xmx${MAX_RAM}G -XX:MaxRAM=${MAX_RAM}G QuRe gen_$dataset.fasta $virus.fa 
    mv gen_${dataset}_reconstructedVariants.txt results_$virus.fa
    done
    
    cat results_*.fa  >  qure-${dataset}.fa
    cp qure-${dataset}.fa ../reconstructed/${dataset}
    
    total_time=0
    total_mem=0
    total_cpu=0
    count=0
    
    for f in qure-*-$dataset-time.txt
    do
      echo "Processing $f" 
      TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
      CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
      CPU="$(cut -d'%' -f1 <<< $CPU)"
      total_time=`echo "$total_time+$TIME" | bc -l`
      if [[ $MEM -gt $total_mem ]]
      then
        total_mem=$MEM
      fi
      total_cpu=`echo "$total_cpu+$CPU" | bc -l`
      count=`echo "$count+1" | bc -l`
    done
    printf "$total_cpu    -   $count     "
    total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
    echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > qure-${dataset}-time.txt
    mv qure-${dataset}-time.txt ../reconstructed/$dataset
    
    rm -rf $CURR_DIR/QuRe_v0.99971/qure-*-time.txt
    rm $CURR_DIR/QuRe_v0.99971/gen_*.fasta
    rm $CURR_DIR/QuRe_v0.99971/*.fa
  done
  cd ..
  conda activate base

fi

#virus-vg - err; Subcommand 'msga' is deprecated and is no longer being actively maintained. Future releases may eliminate it entirely.
#error: could not parse i from argument "-a"
if [[ "$RUN_VIRUSVG" -eq "1" ]] 
  then
  printf "Reconstructing with Virus-VG\n\n"
  eval "$(conda shell.bash hook)"
  conda activate virus-vg-deps
  chmod +x jbaaijens-virus-vg-69a05f3e74f2/scripts/build_graph_msga.py
  cd jbaaijens-virus-vg-69a05f3e74f2
  cp ../vg .
  for dataset in "${DATASETS[@]}"
    do
    rm -rf $CURR_DIR/jbaaijens-virus-vg-69a05f3e74f2/samples_virusvg
    mkdir samples_virusvg
    cp ../${dataset}_*.fq .
    
    rm -rf $CURR_DIR/jbaaijens-virus-vg-69a05f3e74f2/spades_${dataset}
    mkdir spades_${dataset} 
    
    #generate contigs with spades
    conda activate spades 
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o exec_times-1-$dataset-time.txt spades.py -o spades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq -t $NR_THREADS -m $MAX_RAM 
    conda activate virus-vg-deps
    
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o exec_times-2-$dataset-time.txt scripts/build_graph_msga.py -f ${dataset}_1.fq -r ${dataset}_2.fq -c spades_${dataset}/contigs.fasta -vg ./vg -t $NR_THREADS
    python scripts/optimize_strains.py -m 1 -c 2 node_abundance.txt contig_graph.final.gfa
    
    
    #rm -rf node_abundance.txt
    #rm -rf contig_graph.final.gfa
    
    total_time=0
    total_mem=0
    total_cpu=0
    count=0
    for f in exec_times-*-$dataset-time.txt
    do
      echo "Processing $f" 
      TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
      CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
      CPU="$(cut -d'%' -f1 <<< $CPU)"
      total_time=`echo "$total_time+$TIME" | bc -l`
      if [[ $MEM -gt $total_mem ]]
      then
        total_mem=$MEM
      fi
      total_cpu=`echo "$total_cpu+$CPU" | bc -l`
      count=`echo "$count+1" | bc -l`
    done
    printf "$total_cpu    -   $count     "
    total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
    echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > virusvg-${dataset}-time.txt
    
    mv virusvg-${dataset}-time.txt ../reconstructed/$dataset
    
    mv haps.fasta virusvg-$dataset.fa 
    cp virusvg-$dataset.fa ../reconstructed/$dataset

  done
  cd ..
  conda activate base
fi

#vg-flow - working
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with VG-Flow\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vg-flow-env
  chmod +x jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py
  cd jbaaijens-vg-flow-ac68093bbb23/
  cp ../vg .
  for dataset in "${DATASETS[@]}"
    do
    rm -rf $CURR_DIR/jbaaijens-vg-flow-ac68093bbb23/samples_vgflow
    mkdir samples_vgflow
    cd samples_vgflow
    for virus in "${VIRUSES[@]}"
    do    
    cp ../../${dataset}_1.fq ../../${dataset}_2.fq ../../$virus.fa .
    
    #generate contigs with SAVAGE
    #conda activate savage
    #savage --split 1 -p1 ${dataset}_1.fq -p2 ${dataset}_2.fq -m 10 -t $NR_THREADS --no_stage_b --no_stage_c
    #conda activate vg-flow-env
    
    rm -rf $CURR_DIR/jbaaijens-vg-flow-ac68093bbb23/samples_vgflow/spades_${dataset}
    mkdir spades_${dataset} 
    
    #generate contigs with spades
    conda activate spades 
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o exec_times-1-$dataset-time.txt spades.py -o spades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq -t $NR_THREADS -m $MAX_RAM 
    conda activate vg-flow-env
    
    
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o exec_times-2-$dataset-time.txt python ../scripts/build_graph_msga.py -f ${dataset}_1.fq -r ${dataset}_2.fq -c spades_${dataset}/contigs.fasta -vg .././vg -t $NR_THREADS
    python ../scripts/vg-flow.py -m 1 -c 2 node_abundance.txt contig_graph.final.gfa
    
    mv sorted_contigs.fasta vgflow_$virus.fa
    
    done
    cat vgflow_*.fa > vgflow-$dataset.fa
    
    
    total_time=0
    total_mem=0
    total_cpu=0
    count=0
    for f in exec_times-*-$dataset-time.txt
    do
      echo "Processing $f" 
      TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
      CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
      CPU="$(cut -d'%' -f1 <<< $CPU)"
      total_time=`echo "$total_time+$TIME" | bc -l`
      if [[ $MEM -gt $total_mem ]]
      then
        total_mem=$MEM
      fi
      total_cpu=`echo "$total_cpu+$CPU" | bc -l`
      count=`echo "$count+1" | bc -l`
    done
    printf "$total_cpu    -   $count     "
    total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
    echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > vgflow-${dataset}-time.txt
    
    mv vgflow-${dataset}-time.txt ../../reconstructed/$dataset
    cp vgflow-$dataset.fa ../../reconstructed/$dataset

    cd ..
  done
  cd ..
  conda activate base
fi

#PredictHaplo - runs; can't detect reads on the .sam file
#if [[ "$RUN_PREDICTHAPLO" -eq "1" ]] 
#  then
#  printf "Reconstructing with PredictHaplo\n\n"
#  eval "$(conda shell.bash hook)"  
#  conda activate predicthaplo
#  rm -rf predicthaplo_data
#  mkdir predicthaplo_data
#  cd predicthaplo_data
#  for dataset in "${DATASETS[@]}"
#  do
#    cp ../${dataset}_.sam . 
#    for virus in "${VIRUSES[@]}"
#    do        
#      cp ../$virus.fa .    
#      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" predicthaplo --sam ${dataset}_.sam --reference $virus.fa       
#    done  
#  done
#  cd ..
#  conda activate base
#  
#fi

#tracespipelite - working
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Reconstructing with TRACESPipeLite\n\n"
  eval "$(conda shell.bash hook)"  
  conda activate tracespipelite
  cd TRACESPipeLite/src/  
  for dataset in "${DATASETS[@]}"
  do	
    cp ../../${dataset}_*.fq .
    lzma -d VDB.mfa.lzma
    rm $CURR_DIR/TRACESPipeLite/src/*.gz
    gzip *.fq
    
    
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o tracespipelite-${dataset}-time.txt ./TRACESPipeLite.sh --similarity 5 --threads $NR_THREADS --reads1 ${dataset}_1.fq.gz --reads2 ${dataset}_2.fq.gz --database VDB.mfa --output test_viral_analysis_${dataset} --no-plots # --cache 10


    cd test_viral_analysis_${dataset}
    for virus in $(ls)
    do
      if [ -d $virus ] 
      then
        printf "copying $virus\n\n"
        cd $virus*   
        cp *-consensus.fa ../../
        cd ..
      fi 
    done
    cd ..
    cat *-consensus.fa > tracespipelite-$dataset.fa
    mv tracespipelite-${dataset}-time.txt ../../reconstructed/$dataset
    cp tracespipelite-$dataset.fa ../../reconstructed/$dataset
    rm $CURR_DIR/TRACESPipeLite/src/*-*.fa
    rm -rf $CURR_DIR/TRACESPipeLite/src/test_viral_analysis*
    rm $CURR_DIR/TRACESPipeLite/src/*.fq.gz

  done  
  cd ../../
  conda activate base
fi

#tracespipe
if [[ "$RUN_TRACESPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with TRACESPipe\n\n"
  eval "$(conda shell.bash hook)"
  conda activate tracespipe
  lzma -d VDB.mfa.lzma
  cd tracespipe/
  printf "1  - $(pwd)"
  for dataset in "${DATASETS[@]}"
    do	
    cd input_data/
    cp ../../${dataset}_*.fq .
    rm -rf $CURR_DIR/tracespipe/input_data/*.fq.gz
    gzip *.fq
    cd ../meta_data/
    echo "x:${dataset}_1.fq.gz:${dataset}_2.fq.gz" > meta_info.txt
    cd ../src/
    #rm $CURR_DIR/tracespipe/src/tracespipe-*-time.txt
    cp ../../VDB.fa .

    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o tracespipe-${dataset}-time.txt ./TRACESPipe.sh --flush-logs --run-meta --threads $NR_THREADS --inter-sim-size 1 --run-all-v-alig --run-mito --remove-dup --run-de-novo --run-hybrid --min-similarity 5 --view-top 5 --very-sensitive 
 
    cp tracespipe-${dataset}-time.txt ../
    printf "$(pwd)\n\n"
    cd ..
    
    cat output_data/TRACES_hybrid_R5_consensus/*.fa > tracespipe-${dataset}.fa
     
    mv tracespipe-${dataset}.fa ../reconstructed/$dataset
    mv tracespipe-${dataset}-time.txt ../reconstructed/$dataset
  
    rm -rf $CURR_DIR/tracespipe/output_data/*
   
    rm $CURR_DIR/tracespipe/meta_data/meta_info.txt
    rm $CURR_DIR/tracespipe/input_data/*
    
    printf "$(pwd)\n\n"
   
  done
  cd ..   
  conda activate base  
fi

#ASPIRE - Can't locate App/Cmd/Setup.pm, tried installing one of the missing dependencies (Sub::Exporter), was not sucessfull, tried installing one of the missing dependencies for it (Test::LeakTrace) and it failed installation.
if [[ "$RUN_ASPIRE" -eq "1" ]] 
  then
  printf "Reconstructing with ASPIRE\n\n"
  cd aspire
  /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./aspire
  cd ..
fi

#QVG - working
if [[ "$RUN_QVG" -eq "1" ]] 
  then
  printf "Reconstructing with QVG\n\n"
  eval "$(conda shell.bash hook)"
  conda activate qvg
  cd QVG
  rm -rf $CURR_DIR/QVG/reconstruction_files
  mkdir reconstruction_files
  rm -rf $CURR_DIR/QVG/*.fa*
  for dataset in "${DATASETS[@]}"
    do	 
    for virus in "${VIRUSES[@]}"
      do
      rm -rf $CURR_DIR/QVG/${dataset}_files
      mkdir ${dataset}_files
      echo "${dataset}" > ${dataset}_files/samples
      cd ${dataset}_files
      rm -rf $CURR_DIR/QVG/${dataset}_files/output
      mkdir output
      cp ../../${dataset}_*.fq .
      gzip -cvf ${dataset}_1.fq > ${dataset}_R1.fastq.gz
      gzip -cvf ${dataset}_2.fq > ${dataset}_R2.fastq.gz
      cd ..
      cp ../${virus}.fa reconstruction_files
    
      timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o qvg-$virus-${dataset}-time.txt ./QVG.sh -r ./reconstruction_files/${virus}.fa -samples-list ./${dataset}_files/samples -s ./${dataset}_files -o ./${dataset}_files/output -annot yes -np $NR_THREADS
      #rm -rf ${dataset}_files/output/samples_multifasta_masked*
      cat ${dataset}_files/output/samples_multifasta_* > ${dataset}_files/output/qvg-${virus}-${dataset}.fasta      
      cp ${dataset}_files/output/qvg-${virus}-${dataset}.fasta .
    done
    cat *.fasta > qvg-${dataset}.fa
    rm -rf *.fasta
    mv qvg-${dataset}.fa ../reconstructed/$dataset 
    
    total_time=0
    total_mem=0
    total_cpu=0
    count=0
    for f in qvg-*-$dataset-time.txt
    do
      echo "Processing $f" 
      TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
      CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
      CPU="$(cut -d'%' -f1 <<< $CPU)"
      total_time=`echo "$total_time+$TIME" | bc -l`
      if [[ $MEM -gt $total_mem ]]
      then
        total_mem=$MEM
      fi
      total_cpu=`echo "$total_cpu+$CPU" | bc -l`
      count=`echo "$count+1" | bc -l`
    done
    printf "$total_cpu    -   $count     "
    total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
    echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > qvg-${dataset}-time.txt
    mv qvg-${dataset}-time.txt ../reconstructed/$dataset
    
    rm -rf $CURR_DIR/QVG/${dataset}_files
    rm $CURR_DIR/QVG/qvg-*-time.txt
  done
  conda activate base 
  cd ..
  
fi

#V-pipe - working
if [[ "$RUN_VPIPE" -eq "1" ]]
  then
  printf "Reconstructing with V-pipe\n\n"
  eval "$(conda shell.bash hook)"

  cd V-pipe/
  mkdir references
  
  for virus in "${VIRUSES[@]}"
    do 
    cd config/
    echo "---
name: $virus
general:
    aligner: "bwa"

input:
    reference: \"{VPIPE_BASEDIR}/../resources/$virus/$virus.fa\"

snv:
    consensus: false

lofreq:
    consensus: true" > $virus.yaml
    cd ../resources/
    rm -rf $CURR_DIR/V-pipe/resources/$virus
    mkdir $virus
    cp ../../$virus.fa $virus
    cd ../references/
    cp ../../$virus.fa .
    cd ..
    
      
  done
    
  for dataset in "${DATASETS[@]}"
    do 
    
    for virus in "${VIRUSES[@]}"
      do 
    
    echo "general:
  virus_base_config: '$virus'
  
input:
  datadir: samples
  samples_file: $(pwd)/config/samples.tsv
  reference: $(pwd)/references/${virus}.fa
  trim_percent_cutoff: 0.1

output:
  datadir: $(pwd)/results
  snv: false
  local: false
  global: false
  visualization: false
  QA: false" > config/config.yaml 
  
  echo "SRR10903401	20200102" > config/samples.tsv

      
      rm -rf $CURR_DIR/V-pipe/samples
      mkdir samples
      cd samples
    
      mkdir SRR10903401
      cd SRR10903401
      
      mkdir 20200102
      cd 20200102
      
      mkdir raw_data
      cd raw_data 
      
      cp ../../../../../${dataset}_*.fq .
      sed -i 's/J/I/g' ${dataset}_1.fq  
      sed -i 's/J/I/g' ${dataset}_2.fq  
       
      #sed -r -n 's/[Jj]/I/g' ${dataset}_1.fq   
      #sed -r -n 's/[Jj]/I/g' ${dataset}_2.fq   
      mv ${dataset}_1.fq SRR10903401_R1.fq
      mv ${dataset}_2.fq SRR10903401_R2.fq
      cd ../../../
      
      cd ..
    
      timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o v-pipe-$virus-${dataset}-time.txt ./vpipe  --cores $NR_THREADS --conda-frontend conda
      
      
      cp results/SRR10903401/20200102/references/ref_majority.fasta .
      mv ref_majority.fasta $virus.fasta
      
      
      
    done
    
    total_time=0
    total_mem=0
    total_cpu=0
    count=0
    for f in v-pipe-*-$dataset-time.txt
    do
      echo "Processing $f" 
      TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
      CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
      CPU="$(cut -d'%' -f1 <<< $CPU)"
      total_time=`echo "$total_time+$TIME" | bc -l`
      if [[ $MEM -gt $total_mem ]]
      then
        total_mem=$MEM
      fi
      total_cpu=`echo "$total_cpu+$CPU" | bc -l`
      count=`echo "$count+1" | bc -l`
    done
    printf "$total_cpu    -   $count     "
    total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
    echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > v-pipe-${dataset}-time.txt
  cp v-pipe-${dataset}-time.txt ../reconstructed/$dataset 
  rm -rf $CURR_DIR/V-pipe/v-pipe-*-time.txt
  cat *.fasta > v-pipe-${dataset}.fa
  rm -rf $CURR_DIR/V-pipe/*.fasta
  mv v-pipe-${dataset}.fa ../reconstructed/$dataset 
  #rm v-pipe-*.fa
    
  done
      
  cd ../
  conda activate base
 
fi

#Strainline - missing reads*.las, may be an error due to the reads being short 
if [[ "$RUN_STRAINLINE" -eq "1" ]] 
  then
  printf "Reconstructing with Strainline\n\n"
  #create_paired_fa_files
  eval "$(conda shell.bash hook)"
  conda activate strainline
  cd Strainline/
  srcpath=$(pwd)/src
  rm -rf out/tmp/
  chmod +x src/./strainline.sh
  for dataset in "${DATASETS[@]}"
    do
    input=$(pwd)/${dataset}/reads.fa
    rm -rf ${dataset}
    mkdir ${dataset} 
    cd ${dataset}    
    cp ../../gen_${dataset}.fasta .
    mv gen_${dataset}.fasta reads.fa
    cd ..
    
    #$(pwd)/../src/strainline.sh -i gen_${dataset}.fasta -o out -p ont -k 200 -t $NR_THREADS
    
    $srcpath/strainline.sh -i $input -o out -p pb --minTrimmedLen 100 --minOvlpLen 20 --minSeedLen 100 -t $NR_THREADS
    
    
    #./strainline.sh -i ../../${dataset}*.fa -o out -p ont
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ../src/strainline.sh -i ${dataset}_test.fa -o ${dataset} -p ont -k 20 -t 32
    
    #example
    #cd ../example/
    #rm -rf out
    #../src/strainline.sh -i reads.fa -o out -p pb -k 20 -t 32
    
    done
  cd ../
  conda activate base
  
  
fi

#HAPHPIPE - pipeline fails on stage ec_reads
if [[ "$RUN_HAPHPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with HAPHPIPE\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haphpipe
  
  rm -rf haphpipe_data
  mkdir haphpipe_data
  cd haphpipe_data
   
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do   
      cp ../${dataset}_*.fq .
      cp ../$virus.fa .
      echo "" > empty.gtf
    
      rm -rf denovo_assembly_${dataset}_$virus
      mkdir denovo_assembly_${dataset}_$virus
    
      #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" haphpipe assemble_denovo --fq1 ${dataset}_1.fq --fq2 ${dataset}_2.fq --outdir denovo_assembly_${dataset} --meta #--no_error_correction TRUE
      #haphpipe_assemble_01 ${dataset}_1.fq ${dataset}_1.fq $virus.fa empty.gtf $virus.fa denovo_assembly_${dataset}_$virus
      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" haphpipe_assemble_02 ${dataset}_1.fq ${dataset}_2.fq $virus.fa $virus #denovo_assembly_${dataset}_$virus
      done
    done
  cd ..
  conda activate base 
fi

#aBayesQR - running; doesn't output results, may be because of the .sam files
#if [[ "$RUN_ABAYESQR" -eq "1" ]] 
#  then
#  printf "Reconstructing with aBayesQR\n\n"
#  cd aBayesQR 
#  for dataset in "${DATASETS[@]}"
#    do
#    
#    for virus in "${VIRUSES[@]}"
#    do
    
      #cp ${dataset}_*.fq .
#      cp ../$virus.fa ../${dataset}_.sam .
#      rm -rf config_${dataset}
#      echo "filename of reference sequence (FASTA) : ${virus}.fa
#filname of the aligned reads (sam format) : ${dataset}_.sam
#paired-end (1 = true, 0 = false) : 1
#SNV_thres : 0.01
#reconstruction_start : 1
#reconstruction_stop: 300000
#min_mapping_qual : 10
#min_read_length : 10
#max_insert_length : 250
#characteristic zone name : test
#seq_err (assumed sequencing error rate(%)) : 0.1
#MEC improvement threshold : 0.0395 " >> config_${dataset}
#      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./aBayesQR config_${dataset}
#      done
#    done
#  cd ..
#    
#fi

#HaploClique - No reads could be retrieved from the BamFile.
#if [[ "$RUN_HAPLOCLIQUE" -eq "1" ]] 
#  then
#  printf "Reconstructing with HaploClique\n\n"
#  eval "$(conda shell.bash hook)"
#  conda activate haploclique  
#  alt_create_bam_files
#  rm -rf haploclique_data
#  mkdir haploclique_data
#  cd haploclique_data
#  for dataset in "${DATASETS[@]}"
#    do
#    cp ../$dataset.bam .
#    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" haploclique $dataset.bam 
#  done
#  cd ..
#  conda activate base
#
#fi

#ViSpA - working
if [[ "$RUN_VISPA" -eq "1" ]] 
  then
  printf "Reconstructing with ViSpA\n\n"  
  eval "$(conda shell.bash hook)"
  create_paired_fa_files
  conda activate vispa  
  cd home
  rm -rf $CURR_DIR/home/test
  mkdir test
  cd test 
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../gen_${dataset}.fasta .
    for virus in "${VIRUSES[@]}"
    do
      cp ../../$virus.fa .
     
      echo "" >> ${dataset}.txt
    
      timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o vispa-$virus-${dataset}-time.txt  ../code/vispa_mosaik/./main_mosaik.bash gen_${dataset}.fasta $virus.fa $NR_THREADS 100 120
      mv gen_${dataset}_I_*_*_CNTGS_DIST0.txt tmp_$virus-$dataset.fa
      done
      
      for f in tmp_*-$dataset.fa
        do
        printf "changing $f \n\n"
        content=$(cat $f)
        echo ">${f}
${content}" > zz_$f
        done
          
      cat zz_tmp_*-$dataset.fa > vispa-$dataset.fa
      mv vispa-$dataset.fa ../../reconstructed/$dataset
      
      total_time=0
      total_mem=0
      total_cpu=0 
      count=0
      for f in vispa-*-${dataset}-time.txt
      do
        echo "Processing $f" 
        TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
        MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
        CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
        CPU="$(cut -d'%' -f1 <<< $CPU)"       
        total_time=`echo "$total_time+$TIME" | bc -l`      
        if [[ $MEM -gt $total_mem ]]
        then
          total_mem=`echo "$total_mem+$MEM" | bc -l`
        fi
        total_cpu=`echo "$total_cpu+$CPU" | bc -l`
        count=`echo "$count+1" | bc -l`     
      done
    total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
    echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > vispa-${dataset}-time.txt
    mv vispa-${dataset}-time.txt ../../reconstructed/$dataset
    #rm * attention
    cd ..
    rm $CURR_DIR/home/test/*
    cd test
  done
    cd ../../
    conda activate base  
fi

#QuasiRecomb -> ParsingException in thread "main" java.lang.reflect.InvocationTargetException
#Caused by: net.sf.samtools.SAMException: No index is available for this BAM file.
#if [[ "$RUN_QUASIRECOMB" -eq "1" ]] 
#  then
#  printf "Reconstructing with QuasiRecomb\n\n"
#  eval "$(conda shell.bash hook)"
#  conda activate quasirecomb
#  alt_create_bam_files 
  #cd QuasiRecomb-1.2
#  for dataset in "${DATASETS[@]}"
#    do
    #cp ../${dataset}_.sam .
    #java -jar QuasiRecomb.jar -i ${dataset}_.sam
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" java -jar QuasiRecomb.jar -i ${dataset}_.sam -coverage
#    java -jar QuasiRecomb.jar -i $dataset.bam

#    done
#  conda activate base
#fi

#Lazypipe - working
if [[ "$RUN_LAZYPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with Lazypipe\n\n"
  eval "$(conda shell.bash hook)"
  conda activate blast
  conda activate --stack lazypipe
  cd lazypipe
  export TM="$CONDA_PREFIX/share/trimmomatic"
  export BLASTDB="$(pwd)/BLASTDB/"
  export data="$(pwd)/data/"
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_*.fq .
    rm -rf $CURR_DIR/lazypipe/results_$dataset
    mkdir results_$dataset
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o lazypipe-${dataset}-time.txt perl lazypipe.pl -1 ${dataset}_1.fq -2 ${dataset}_2.fq --pipe all,rep -v -t $NR_THREADS   
    mv results/$dataset/contigs.fa results/$dataset/lazypipe-$dataset.fa
    cp results/$dataset/lazypipe-$dataset.fa ../reconstructed/${dataset}
    mv lazypipe-${dataset}-time.txt ../reconstructed/${dataset}
    rm $CURR_DIR/lazypipe/${dataset}_*.fq
    rm -rf $CURR_DIR/lazypipe/results_${dataset}
    cd results
    rm -rf $CURR_DIR/lazypipe/results/${dataset}
    cd ..
  done
  cd ..
  conda activate base 
fi

#ViQuaS - err - [0] smalt.c:1116 ERROR: could not open file cut: alnc.sam: No such file or directory, may be caused by lack of Bio::Seq module, which couldn't be installed
#if [[ "$RUN_VIQUAS" -eq "1" ]] 
#  then
#  printf "Reconstructing with ViQuaS\n\n"
#  create_bam_files
#  eval "$(conda shell.bash hook)"
#  conda activate viquas
#  cd ViQuaS1.3  
#  for dataset in "${DATASETS[@]}"
#    do 
#        
#    for virus in "${VIRUSES[@]}"
#    do       
#      cp ../${dataset}.bam .  
#      cp ../${virus}.fa .
#      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" Rscript ViQuaS.R ${virus}.fa $dataset.bam 1 1 1 20 
      
      #example
      #Rscript ViQuaS.R reference.fsa sample_reads.bam
    
#    done
#  done
#  conda activate base  
#  cd ..  
#fi

#MLEHaplo - constructs graphs with 0 vertices and 0 edges, illegal division by 0
if [[ "$RUN_MLEHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with MLEHaplo\n\n"  
  #timer
  #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
  create_paired_fa_files
  eval "$(conda shell.bash hook)"
  conda activate mlehaplo
  cd MLEHaplo-0.4.1  
  for dataset in "${DATASETS[@]}"
    do
    rm -rf ${dataset}
    mkdir ${dataset}
    cd ${dataset}
    echo ${dataset}"_1.fq
"${dataset}"_2.fq" > files_${dataset}.txt
    echo "55
45
35
25" > listofkmers.txt
    cp ../../gen_${dataset}.fasta .
    mv gen_${dataset}.fasta paired-reads.fasta
    cd ..   
    
    #example given
    #./multi-dsk/multi-dsk Example/paired-reads.fasta  Example/listofkmers.txt  -m 8192 -d 10000
    #./multi-dsk/parse_results Example/paired-reads.solid_kmers_binary.60 > paired-reads.60
    #perl construct_graph.pl  Example/paired-reads.fasta paired-reads.60 0 paired-reads.60.graph "s"
    #perl construct_paired_without_bloom.pl -fasta Example/paired-reads.fasta -kmerfile paired-reads.60 -thresh 0 -wr paired-reads.60.pk.txt
    #perl dg_cover.pl -graph paired-reads.60.graph -kmer paired-reads.60 -paired paired-reads.60.pk.txt -fact 15 -thresh 0 -IS 400 > paired-reads.60.fact15.txt
    #perl process_dg.pl paired-reads.60.fact15.txt > paired-reads.60.fact15.fasta
    #perl get_paths_dgcover.pl -f paired-reads.60.fact15.txt -w paired-reads.60.fact15.paths.txt
    #perl likelihood_singles_wrapper.pl -condgraph paired-reads.60.cond.graph -compset paired-reads.60.comp.txt -pathsfile paired-reads.60.fact15.paths.txt -back -gl 1200 -slow  > paired-reads.60.smxlik.txt
    #perl extract_MLE.pl -f paired-reads.60.fact15.fasta -l paired-reads.60.smxlik.txt > paired-reads.60.MLE.fasta
    
    #adaptation to the example given
    ./multi-dsk/multi-dsk ${dataset}/paired-reads.fasta  ${dataset}/listofkmers.txt  -m 8192 -d 10000
    ./multi-dsk/parse_results ${dataset}/paired-reads.solid_kmers_binary.60 > paired-reads.60
    perl construct_graph.pl  ${dataset}/paired-reads.fasta paired-reads.60 0 paired-reads.60.graph "s"
    perl construct_paired_without_bloom.pl -fasta ${dataset}/paired-reads.fasta -kmerfile paired-reads.60 -thresh 0 -wr paired-reads.60.pk.txt
    perl dg_cover.pl -graph paired-reads.60.graph -kmer paired-reads.60 -paired paired-reads.60.pk.txt -fact 15 -thresh 20 -IS 400 > paired-reads.60.fact15.txt
    perl process_dg.pl paired-reads.60.fact15.txt > paired-reads.60.fact15.fasta
    perl get_paths_dgcover.pl -f paired-reads.60.fact15.txt -w paired-reads.60.fact15.paths.txt
    perl likelihood_singles_wrapper.pl -condgraph paired-reads.60.cond.graph -compset paired-reads.60.comp.txt -pathsfile paired-reads.60.fact15.paths.txt -back -gl 1200 -slow  > paired-reads.60.smxlik.txt
    perl extract_MLE.pl -f paired-reads.60.fact15.fasta -l paired-reads.60.smxlik.txt > paired-reads.60.MLE.fasta   
  
  done
  conda activate base 
fi

#PEHaplo - working
if [[ "$RUN_PEHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with PEHaplo\n\n"
  eval "$(conda shell.bash hook)"
  conda activate bio2
  cd TAR-VIR/PEHaplo/  
   
  for dataset in "${DATASETS[@]}"
    do	
      rm -rf $CURR_DIR/TAR-VIR/PEHaplo/assembly
      mkdir assembly  
      cd assembly     
      cp ../../../${dataset}_*.fq .
      sed -n '1~4s/^@/>/p;2~4p' ${dataset}_1.fq > ${dataset}_1.fa
      sed -n '1~4s/^@/>/p;2~4p' ${dataset}_2.fq > ${dataset}_2.fa      
      timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o pehaplo-${dataset}-time.txt python ../pehaplo.py -f1 ${dataset}_1.fa -f2 ${dataset}_2.fa -l 10 -r 150 -t $NR_THREADS -m ${MAX_RAM}GB -correct yes 
      cp pehaplo-${dataset}-time.txt ../../../reconstructed/$dataset
      mv Contigs.fa pehaplo-${dataset}.fa
      cp pehaplo-${dataset}.fa ../../../reconstructed/$dataset
      rm -rf $CURR_DIR/TAR-VIR/PEHaplo/assembly/Contigs.fa
      
      cd ..
      rm -rf $CURR_DIR/TAR-VIR/PEHaplo/assembly
  done
  cd ../../
  conda activate base  
fi

#RegressHaplo
#if [[ "$RUN_REGRESSHAPLO" -eq "1" ]] 
#  then
#  printf "Reconstructing with RegressHaplo\n\n"
#  
#  timer
#  /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
#  
#fi

#CliqueSNV - working
#if [[ "$RUN_CLIQUESNV" -eq "1" ]] 
#  then
#  printf "Reconstructing with CliqueSNV\n\n"
#  eval "$(conda shell.bash hook)"
#  conda activate java-env
#  cd CliqueSNV-2.0.3
#  for dataset in "${DATASETS[@]}"
#    do
#    cp ../${dataset}_.sam .
#    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o cliquesnv-${dataset}-time.txt java -jar clique-snv.jar #-m snv-illumina -in ${dataset}_.sam -outDir $(pwd)
#    cp ${dataset}_.fasta cliquesnv-${dataset}.fa
#    mv cliquesnv-${dataset}-time.txt ../reconstructed/$dataset
#    cp cliquesnv-${dataset}.fa ../reconstructed/${dataset}
#    done
#  cd ..  
#  conda activate base
#fi

#IVA - err - Failed to make first seed. Cannot continue
if [[ "$RUN_IVA" -eq "1" ]] 
  then
  printf "Reconstructing with IVA\n\n"
  eval "$(conda shell.bash hook)"
  conda activate iva
  rm -rf IVA_reconstruction
  mkdir IVA_reconstruction
  cd IVA_reconstruction
  for dataset in "${DATASETS[@]}"
    do
    rm -rf $dataset
    mkdir $dataset
    cd $dataset    
    cp ../../${dataset}_*.fq .  
    gzip *.fq
    iva --threads $NR_THREADS -f ${dataset}_1.fq.gz -r ${dataset}_2.fq.gz results 
    cd ../
  done  
  cd ..
  conda activate base
fi


#PRICE - did nothing, no errors
if [[ "$RUN_PRICE" -eq "1" ]] 
  then
  create_paired_fa_files
  printf "Reconstructing with PRICE\n\n"
  cd PriceSource130506
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_*.fq .
    cp ../gen_${dataset}.fasta .
    mv gen_${dataset}.fasta gen_${dataset}_sequence.txt
    mv ${dataset}_1.fq ${dataset}_1_sequence.txt
    mv ${dataset}_2.fq ${dataset}_2_sequence.txt
    #example
    #./PriceTI -fp s_1_1_sequence.txt s_1_2_sequence.txt 300 500 s_1_1_sequence.txt 1 1 1 -nc 20 -a 10 -o lane1job.fasta
    
    ./PriceTI -fp ${dataset}_1_sequence.txt ${dataset}_2_sequence.txt 1 1 1 -nc 3 -a $NR_THREADS -o result.fasta
    #./PriceTI -fs gen_${dataset}_sequence.txt 1 1 1 -nc 3 -a $NR_THREADS -o result.fasta
    done
  cd ..  
fi


#TAR-VIR - no errors but no seed reads
if [[ "$RUN_TARVIR" -eq "1" ]] 
  then
  printf "Reconstructing with TAR-VIR\n\n"
  eval "$(conda shell.bash hook)"
  conda activate bio2
  
  cd TAR-VIR/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf data
    mkdir data
    cp ../gen_${dataset}.fasta data
    #cp ../${dataset}_.sam data
    cd Overlap_extension/
    
    ./build -f ../data/gen_${dataset}.fasta -o data
    ./overlap -S data/${dataset}_.sam -x data -f ../data/gen_${dataset}.fasta -c 50 -o virus_recruit.fa
    #example
    #./build -f test_data/virus.fa -o virus
    #./overlap -S test_data/HIV.sam -x virus -f test_data/virus.fa -c 180 -o virus_recruit.fa
    cd ..
  done 
  cd ../../
  conda activate base
fi

#VIP - missing DBI module, can´t install it
if [[ "$RUN_VIP" -eq "1" ]] 
  then
  printf "Reconstructing with VIP\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vip
  
  #timer
  #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
  
  cd VIP-master
  chmod +x ./VIP.sh
  
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do
      rm -rf reconstruction
      mkdir reconstruction
      cd reconstruction
      rm -rf ${dataset}.fa.report
      cp ../../${dataset}_*.fq .
      cp ../../gen_${dataset}.fasta .
      cp ../../${virus}.fa .
      .././VIP.sh -z -i gen_${dataset}.fasta -p illumina -f fasta -r ${virus}.fa
      .././VIP.sh -c gen_${dataset}.fasta.conf -i gen_${dataset}.fasta
      cd ..
      
      done
    done
  cd ..
  conda activate base
fi

#drVM - err - No such file or directory: 'GenusCovDepth.txt'
if [[ "$RUN_DRVM" -eq "1" ]] 
  then
  printf "Reconstructing with drVM\n\n"

  cd Tools 
  export MyDB="$(pwd)/MyDB"
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_*.fq .
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./drVM.py -1 ${dataset}_1.fq -2 ${dataset}_2.fq -type illumina -dn off -t $NR_THREADS -ar 0.1 -cl 150
  done
  cd ..
fi

#SSAKE - running
if [[ "$RUN_SSAKE" -eq "1" ]] 
  then
  printf "Reconstructing with SSAKE\n\n"
  cd ssake/tools/
  for dataset in "${DATASETS[@]}"
    do
    cp ../../${dataset}_*.fq .
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o ssake-${dataset}-time.txt ./runSSAKE.sh ${dataset}_1.fq ${dataset}_2.fq 10 ${dataset}_assembly
    mv ${dataset}_assembly_scaffolds.fa ssake-${dataset}.fa
    mv ssake-${dataset}.fa ../../reconstructed/${dataset}
    mv ssake-${dataset}-time.txt ../../reconstructed/$dataset
    rm $CURR_DIR/ssake/tools/${dataset}*
  done
  cd ../../
fi

#viralFlye - err can't find out dir, can't create out dir with flye - ERROR: No reads above minimum length threshold (1000)
if [[ "$RUN_VIRALFLYE" -eq "1" ]] 
  then
  printf "Reconstructing with viralFlye\n\n"
  eval "$(conda shell.bash hook)"
  conda activate viralFlye
  
  for dataset in "${DATASETS[@]}"
    do
    cd Flye/bin
    cp ../../${dataset}_*.fq . 
    rm -rf ../../viralFlye/out
    ./flye --nano-raw ${dataset}_1.fq ${dataset}_2.fq -o ../../viralFlye/out
    cd ../../
  
    cd viralFlye
    rm -rf flye_assembly_dir
    mkdir flye_assembly_dir 
    cd flye_assembly_dir 
    cp ../../${dataset}_*.fq .
    cd ..
    rm -rf output_dir
    mkdir output_dir
  
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./viralFlye.py --dir out --hmm ../Pfam-A.hmm.gz --reads flye_assembly_dir --outdir output_dir
    cd ..
  done
  conda activate base
fi

#EnsembleAssembler - no errors, doesn't output results
if [[ "$RUN_ENSEMBLEASSEMBLER" -eq "1" ]] 
  then
  printf "Reconstructing with EnsembleAssembler \n\n"
  #eval "$(conda shell.bash hook)"
  #conda activate ensembleAssembler
  cd ensembleAssembly_1

  for dataset in "${DATASETS[@]}"
    do
    rm -rf reconstruction
    mkdir reconstruction
    cd reconstruction    
    cp ../../${dataset}_*.fq
    echo "PE=150 0 $(pwd)/${dataset}_1.fq $(pwd)/${dataset}_2.fq
#SE=$(pwd)/${dataset}_2.fq
NUM_THREADS= $NR_THREADS
SOAP_KMER=21
ABYSS_KMER = 21
METAVELVET_KMER= 21
CON_LEN_DBG=21
CON_LEN_OLC=21
ASSEMBLY_MODE=optimal
#ASSEMBLY_MODE=quick " > config.txt
    .././ensembleAssembly config.txt
    chmod +x ./ensemble.sh
    ./ensemble.sh
    cd ..
    
    #chmod +x ./ensemble.sh
    #./ensemble.sh
    
  done
  cd ..
  #conda activate base 
  
fi

#Haploflow -working
if [[ "$RUN_HAPLOFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with Haploflow\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haploflow
  for dataset in "${DATASETS[@]}"
    do
    printf "Reconstructing $dataset\n"
    rm -rf $CURR_DIR/haploflow_data
    mkdir haploflow_data
    cd haploflow_data
    cp ../${dataset}_*.fq .
    cat ${dataset}_*.fq > ${dataset}_paired.fq
    timeout --signal=SIGINT ${OVERALL_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o haploflow-${dataset}-time.txt haploflow --read-file ${dataset}_paired.fq --out test_$dataset --log test_$dataset/log    
    mv haploflow-${dataset}-time.txt ../reconstructed/$dataset
    mv test_$dataset/contigs.fa test_$dataset/haploflow-${dataset}.fa
    cp test_$dataset/haploflow-${dataset}.fa ../reconstructed/$dataset
    
    cd ..
    rm -rf $CURR_DIR/haploflow_data
  done 
  conda activate base 
fi

#TenSQR -input contained no data: "zone_SNV_matrix.txt", no SNVs detected
#if [[ "$RUN_TENSQR" -eq "1" ]] 
#  then
#  printf "Reconstructing with TenSQR\n\n"
# 
#  cd TenSQR
#  rm -rf reconstruction_data
#  for dataset in "${DATASETS[@]}"
#    do
#    
#    for virus in "${VIRUSES[@]}"
#    do
#    
#    cp ../${dataset}_.sam .
#    cp ../$virus.fa .
#    echo "filename of reference sequence (FASTA) : "$virus.fa"
#filname of the aligned reads (sam format) : "${dataset}_.sam"
#SNV_thres : 0.0001
#reconstruction_start : 0
#reconstruction_stop: 300000
#min_mapping_qual : 40
#min_read_length : 50
#max_insert_length : 500
#characteristic zone name : zone
#seq_err (assumed sequencing error rate(%)) : 0.2
#MEC improvement threshold : 0.0312
#initial population size : 5" > config_${dataset}
#    ./ExtractMatrix config_${dataset}
#    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" python3 TenSQR.py config_${dataset}  
#    done
#  done  
#  cd ..
#fi

#ViQUF - UnboundLocalError: local variable 'extension' referenced before assignment
if [[ "$RUN_VIQUF" -eq "1" ]] 
  then
  printf "Reconstructing with ViQUF\n\n"
  #eval "$(conda shell.bash hook)"
  #conda activate viquf
  
  
  cd viquf
  
  
  for dataset in "${DATASETS[@]}"
    do
    rm -rf $dataset
    mkdir $dataset
    cd $dataset     
    cp ../../${dataset}_*.fq .    
    cd ..
    
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" python scripts/testBcalm.py $dataset 4 10 ngs --no-correct --no-join --no-meta
    ./bin/output.out tmp 4 tmp/unitigs.graph tmp/unitigs.unitigs.fa tmp/unitigs-viadbg.fa tmp/Ownlatest/append.fasta --virus
    python scripts/post-process.py 
  done
  
  cd ..
  #conda activate base  
fi

#VirGenA 
if [[ "$RUN_VIRGENA" -eq "1" ]] 
  then
  printf "Reconstructing with VirGenA\n\n"
  eval "$(conda shell.bash hook)"
  conda activate java-env
  cd release_v1.4
  chmod +x ./tools/vsearch
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do
      rm -rf $CURR_DIR/release_v1.4/${dataset}_*.fq
      #rm -rf ${virus}.fa
      rm -rf $CURR_DIR/release_v1.4/*.gz
      
      cp ../${dataset}_*.fq .
      cp ../${virus}.fa .
    
      gzip *.fq

    
      echo "<config>
    <Data>
        <pathToReads1>${dataset}_1.fq.gz</pathToReads1>
        <pathToReads2>${dataset}_2.fq.gz</pathToReads2>
        <InsertionLength>1000</InsertionLength>
    </Data>
    <Reference>${virus}.fa</Reference>
    <OutPath>./res/$dataset-$virus</OutPath>
    <ThreadNumber>-1</ThreadNumber>
	<BatchSize>1000</BatchSize>
    <ReferenceSelector>
		<Enabled>true</Enabled>
        <UseMajor>false</UseMajor>
        <ReferenceMSA>./data/HIV_RefSet_msa.fasta</ReferenceMSA>
        <PathToVsearch>./tools/vsearch</PathToVsearch>
        <UclustIdentity>0.95</UclustIdentity>
        <MinReadLength>50</MinReadLength>
        <MinContigLength>1000</MinContigLength>
        <Delta>0.05</Delta>
		<MaxNongreedyComponentNumber>5</MaxNongreedyComponentNumber>
        <MapperToMSA>
			<K>7</K>
			<IndelToleranceThreshold>1.5</IndelToleranceThreshold>
			<pValue>0.01</pValue>
			<RandomModelParameters>
				<Order>4</Order>
				<ReadNum>1000</ReadNum>
				<Step>10</Step>
			</RandomModelParameters>
        </MapperToMSA>
        <Graph>
            <MinReadNumber>5</MinReadNumber>
            <VertexWeight>10</VertexWeight>
			<SimilarityThreshold>0.05</SimilarityThreshold>
			<Debug>false</Debug>
        </Graph>
        <Debug>false</Debug>
    </ReferenceSelector>
    <Mapper>
		<K>5</K>
		<IndelToleranceThreshold>1.25</IndelToleranceThreshold>
        <pValue>0.01</pValue>
		<RandomModelParameters>
			<Order>4</Order>
			<ReadNum>1000</ReadNum>
			<Step>10</Step>
		</RandomModelParameters>
        <Aligner>
            <Match>2</Match>
            <Mismatch>-3</Mismatch>
            <GapOpenPenalty>5</GapOpenPenalty>
            <GapExtensionPenalty>2</GapExtensionPenalty>
        </Aligner>
    </Mapper>
    <ConsensusBuilder>
        <IdentityThreshold>0.9</IdentityThreshold>
        <CoverageThreshold>0</CoverageThreshold>
        <MinIntersectionLength>10</MinIntersectionLength>
        <MinTerminationReadsNumber>1</MinTerminationReadsNumber>
        <Reassembler>
            <IdentityThreshold>0.9</IdentityThreshold>
            <MinTerminatingSequenceCoverage>0</MinTerminatingSequenceCoverage>
            <PairReadTerminationThreshold>0.1</PairReadTerminationThreshold>
            <MinReadLength>50</MinReadLength>
        </Reassembler>
        <Debug>false</Debug>
    </ConsensusBuilder>
    <Postprocessor>
        <Enabled>true</Enabled>
        <MinFragmentLength>500</MinFragmentLength>
        <MinIdentity>0.99</MinIdentity>
		<MinFragmentCoverage>0.99</MinFragmentCoverage>
        <Debug>false</Debug>
    </Postprocessor>
</config>" > $dataset-conf.xml
    
    
    
    timeout --signal=SIGINT ${VIRGENA_TIMEOUT}m /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o virgena-$virus-${dataset}-time.txt java -jar VirGenA.jar assemble -c $dataset-conf.xml # config_test_linux.xml
    #java -jar VirGenA.jar map -c config.xml -r ../B19.fa -p1 ../DS1_1.fq -p2 ../DS1_2.fq

    done
    cd res
    cat *_complete_genome_assembly.fasta > virgena-$dataset.fa
    rm -rf $CURR_DIR/release_v1.4/res/*_complete_genome_assembly.fasta
    
    
    total_time=0
    total_mem=0
    total_cpu=0 
    count=0
    for f in ../virgena-*-$dataset-time.txt
    do
      echo "Processing $f" 
      TIME=`cat $f | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $f | grep "MEM" | awk '{ print $2;}'`;
      CPU=`cat $f | grep "CPU_perc" | awk '{ print $2;}'`;
      CPU="$(cut -d'%' -f1 <<< $CPU)"       
      total_time=`echo "$total_time+$TIME" | bc -l`      
      if [[ $MEM -gt $total_mem ]]
      then
        total_mem=$MEM
      fi
      total_cpu=`echo "$total_cpu+$CPU" | bc -l`
      count=`echo "$count+1" | bc -l`     
    done
    printf "$total_cpu    -   $count     "
    total_cpu=$(echo $total_cpu \/ $count |bc -l | xargs printf %.0f)
    echo "TIME	$total_time
MEM	$total_mem
CPU_perc	$total_cpu%" > ../virgena-${dataset}-time.txt
        
    mv ../virgena-${dataset}-time.txt ../../reconstructed/$dataset
    mv virgena-$dataset.fa ../../reconstructed/$dataset 

    cd ..
    rm $CURR_DIR/release_v1.4/virgena-*-$dataset-time.txt
    rm $CURR_DIR/release_v1.4/$dataset*
    rm $CURR_DIR/release_v1.4/*.fa
 
    rm -rf $CURR_DIR/release_v1.4/res/*
    
    
    
  done
  cd ..
  conda activate base
  
fi

#./Evaluation.sh

 
