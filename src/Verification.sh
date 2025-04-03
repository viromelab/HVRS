#!/bin/bash
#
FILES="0";
#
declare -a DATASETS=("DS1" "DS2" "DS3" "DS4" "DS5" "DS6" "DS7" "DS8" "DS9" "DS10" "DS11" "DS12" "DS13"  "DS14"  "DS15"  "DS16" "DS17"  "DS18"  "DS19"  "DS20"  "DS21"  "DS22"  "DS23"  "DS24"  "DS25"  "DS26"  "DS27"  "DS28"  "DS29"  "DS30"  "DS31"  "DS32"  "DS33"  "DS34"  "DS35"  "DS36"  "DS37"  "DS38"  "DS39"  "DS40"  "DS41"  "DS42"  "DS43"  "DS44"  "DS45"  "DS46"  "DS47"  "DS48"  "DS49"  "DS50"  "DS51"  "DS52"  "DS53"  "DS54"  "DS55"  "DS56"  "DS57"  "DS58"  "DS59"  "DS60"  "DS61"  "DS62" "DS63"  "DS64"  "DS65");
#
declare -a REAL_DATASETS=("SRR12175231" "SRR12175232" "SRR12175233" "SRR23101235" "SRR23101281" "SRR23101259" "SRR23101276" "SRR23101228")
#
declare -a VIRUSES=("B19" "HPV" "VZV" "MCPyV" "HHV6B" "POLY7" "EBV" "CMV" "MT");
#
RUN_SPADES=0; 
RUN_METASPADES=0; 
RUN_METAVIRALSPADES=0; 
RUN_CORONASPADES=0; 
RUN_QURE=0; 
RUN_TRACESPIPELITE=0; 
RUN_TRACESPIPE=0; 
RUN_QVG=0; 
RUN_VPIPE=0; 
RUN_VISPA=0; 
RUN_LAZYPIPE=0; 
RUN_PEHAPLO=0; 
RUN_VIRGENA=0; 
RUN_SSAKE=0;
RUN_HAPLOFLOW=0;
RUN_IRMA=0;
#
CAREFUL=0;
FAILED=0;
#
################################################################################
#
SHOW_MENU () {
  echo " -------------------------------------------------------------------- ";
  echo "                                                                      ";
  echo " Verification.sh : Verification version v0.1                          ";
  echo "                                                                      ";
  echo " Verifies if the tools were successfully installed and the datasets   ";
  echo " were generated.                                                      ";  
  echo "                                                                      ";
  echo " Program options ---------------------------------------------------- ";
  echo "                                                                      ";
  echo " -h, --help                    Show this,                             ";
  echo " -t, --tools                   Checks if the all tools are installed, ";
  echo " -d, --datasets                Checks if the datasets were generated  ";
  echo "                               and generates them if they do not      ";
  echo "                               exist.                                 ";
  echo "                                                                      ";
  echo " --coronaspades                Checks installation of coronaSPAdes,   ";
  echo " --haploflow                   Checks installation of Haploflow,      ";
  echo " --irma                        Checks installation of IRMA,           ";
  echo " --lazypipe                    Checks installation of LAZYPIPE,       ";
  echo " --metaspades                  Checks installation of metaSPAdes,     ";
  echo " --metaviralspades             Checks installation of metaviralSPAdes,";
  echo " --pehaplo                     Checks installation of PEHaplo,        ";
  echo " --qure                        Checks installation of QuRe,           ";
  echo " --qvg                         Checks installation of QVG,            ";
  echo " --spades                      Checks installation of SPAdes,         ";
  echo " --ssake                       Checks installation of SSAKE,          ";
  echo " --tracespipe                  Checks installation of TRACESPipe,     ";
  echo " --tracespipelite              Checks installation of TRACESPipeLite, ";
  echo " --virgena                     Checks installation of VirGenA,        ";
  echo " --vispa                       Checks installation of ViSpA,          ";
  echo " --vpipe                       Checks installation of V-pipe.         ";
  echo "                                                                      ";
  echo " --other                       Checks installation of other tools used";
  echo "                               in HVRS.                               ";
  echo "                                                                      ";
  echo " --all                         Checks all tools and datasets.         ";
  echo "                                                                      ";
  echo " -c, --careful                 Checks if the reconstruction programs  ";
  echo "                               execute correctly.                     ";
  echo "                                                                      ";
  echo " Examples ----------------------------------------------------------- ";
  echo "                                                                      ";
  echo " - Checks tools and datasets                                          ";
  echo "  ./Verification.sh --all                                             ";
  echo "                                                                      ";
  echo " -------------------------------------------------------------------- ";
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
      shift;
    ;;
    --coronaspades)
      RUN_CORONASPADES=1;
      shift
    ;;
    --haploflow)
      RUN_HAPLOFLOW=1;
      shift
    ;;
    --irma)
      RUN_IRMA=1;
      shift
    ;;
    --lazypipe)
      RUN_LAZYPIPE=1;
      shift
    ;;
    --metaspades)
      RUN_METASPADES=1;
      shift
    ;;
    --metaviralspades)
      RUN_METAVIRALSPADES=1;
      shift
    ;;
    --pehaplo)
      RUN_PEHAPLO=1;
      shift
    ;;
    --qure)
      RUN_QURE=1;
      shift
    ;;
    --qvg)
      RUN_QVG=1;
      shift
    ;;
    --spades)
      RUN_SPADES=1;
      shift
    ;;
    --ssake)
      RUN_SSAKE=1;
      shift
    ;;
    --tracespipe)
      RUN_TRACESPIPE=1;
      shift
    ;;
    --tracespipelite)
      RUN_TRACESPIPELITE=1;
      shift
    ;;
    --virgena)
      RUN_VIRGENA=1;
      shift
    ;;
    --vispa)
      RUN_VISPA=1;
      shift
    ;;
    --vpipe)
      RUN_VPIPE=1;
      shift
    ;;
    --other)
      RUN_AUX_TOOLS=1;
      shift
    ;;
    --all)
      RUN_CORONASPADES=1;
      RUN_HAPLOFLOW=1;
      RUN_IRMA=1;
      RUN_LAZYPIPE=1;
      RUN_METASPADES=1;
      RUN_METAVIRALSPADES=1;
      RUN_PEHAPLO=1;
      RUN_QURE=1;
      RUN_QVG=1;
      RUN_SPADES=1;
      RUN_SSAKE=1;
      RUN_TRACESPIPE=1;
      RUN_TRACESPIPELITE=1;
      RUN_VIRGENA=1;
      RUN_VISPA=1;
      RUN_VPIPE=1;
      RUN_AUX_TOOLS=1;
      FILES=1;
      shift;
    ;;
    -t|--tools)
      RUN_CORONASPADES=1;
      RUN_HAPLOFLOW=1;
      RUN_IRMA=1;
      RUN_LAZYPIPE=1;
      RUN_METASPADES=1;
      RUN_METAVIRALSPADES=1;
      RUN_PEHAPLO=1;
      RUN_QURE=1;
      RUN_QVG=1;
      RUN_SPADES=1;
      RUN_SSAKE=1;
      RUN_TRACESPIPE=1;
      RUN_TRACESPIPELITE=1;
      RUN_VIRGENA=1;
      RUN_VISPA=1;
      RUN_VPIPE=1;
      shift;
    ;;
    -d|--datasets|--dataset)
      FILES=1;
      shift;
    ;;
    -c|--careful)
      CAREFUL=1;
      shift;
    ;;
    -*) # unknown option with small
    echo "Invalid arg ($1)!";
    echo "For help, try: ./Verification.sh -h"
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
PROGRAM_EXISTS () {
  printf "Checking $3 ... ";
  if ! [ -x "$(command -v $1)" ];
    then
    echo -e "\e[41mERROR\e[49m: $3 is not installed." >&2;
    echo -e "\e[42mTIP\e[49m: Try to reinstall $3 using ./Installation.sh --$2" >&2;
    #exit 1;
    else
    echo -e "\e[42mSUCCESS!\e[49m";
    fi
  }
  
PROGRAM_EXISTS_V2 () {
  printf "Checking $3 ... ";
  if ! [ -e "$(find . -name $1 | head -n 1)" ];
    then
    echo -e "\e[41mERROR\e[49m: $3 is not installed." >&2;
    echo -e "\e[42mTIP\e[49m: Try to reinstall $3 using ./Installation.sh --$2" >&2;
    #exit 1;
    else
    echo -e "\e[42mSUCCESS!\e[49m";
    fi
  }
  
VERIFY_DATASET () {

  dataset=$1

  if [[ -f ${dataset}_1.fq ]]; then
    if [[ -f ${dataset}_2.fq ]]; then
      printf "\e[42m${dataset} exists\e[49m\n"
    else
      printf "\e[41m${dataset} with errors\e[49m\n"
      FAILED=1
    fi
    
  else
    printf "\e[41m${dataset} with errors\e[49m\n"
    FAILED=1
  fi
}

VERIFY_EXECUTION (){

  TOOL=$1
  
  printf "Checking $TOOL ... ";
  ./Reconstruction.sh --$TOOL -r DStest -t 1 -m 10 -y &> a.txt
  rm a.txt
  
  if [[ ! -s "reconstructed/DStest/$3-DStest.fa" ]]; then 
  
    ./Reconstruction.sh --$TOOL -r DStest2 -t 2 -m 28 -y &> a.txt
    rm a.txt
    
    if [[ ! -s "reconstructed/DStest2/$3-DStest2.fa" ]]; then 
      echo -e "\e[41mERROR\e[49m: $2 is not installed." >&2;
      echo -e "\e[42mTIP\e[49m: Try to reinstall $2 using ./Installation.sh --$1" >&2;
    else
      echo -e "\e[42mSUCCESS!\e[49m";
    fi
    
  else
    echo -e "\e[42mSUCCESS!\e[49m";
  fi
  
  rm -rf reconstructed
   
}
#
################################################################################
#
if [[ "$CAREFUL" -eq "1" ]];
  then
  
  lzma -k -f -d VDB.fa.lzma
  
  gto_fasta_extract_read_by_pattern -p "AY386330.1" < VDB.fa > B19.fa
  gto_fasta_extract_read_by_pattern -p "DQ479959.1" < VDB.fa > VZV.fa
  gto_fasta_extract_read_by_pattern -p "KU298932.1" < VDB.fa > HPV.fa
  gto_fasta_extract_read_by_pattern -p "KX827417.1" < VDB.fa | sed 's|/||g' > MCPyV.fa
  
  gto_fasta_mutate -s 1 -e 0.01 < B19.fa > B19-1.fa
  gto_fasta_mutate -s 1 -e 0.01 < VZV.fa > VZV-1.fa
  gto_fasta_mutate -s 1 -e 0.01 < MCPyV.fa > MCPyV-1.fa
  gto_fasta_mutate -s 1 -e 0.01 < HPV.fa > HPV-1.fa
  
  cat B19-1.fa > DStest.fa
  cat B19-1.fa VZV-1.fa MCPyV-1.fa HPV-1.fa > DStest2.fa
  art_illumina -rs 4  -i DStest.fa -p -sam -l 150 -f 15 -m 200 -s 10 -o DStest_ &> a.txt
  art_illumina -rs 7  -i DStest2.fa -p -sam -l 150 -f 30 -m 200 -s 10 -o DStest2_ &> a.txt
  rm a.txt
  
  VERIFY_DATASET "DStest"
  
  if [[ "$FAILED" -eq "1" ]];
    then
    exit 1
  fi
  
fi



if [[ "$RUN_SPADES" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "spades.py" spades SPAdes;
    
  else
    VERIFY_EXECUTION spades SPAdes spades;
  fi

fi
#
if [[ "$RUN_CORONASPADES" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "coronaspades.py" coronaspades coronaSPAdes;
    
  else
    VERIFY_EXECUTION coronaspades coronaSPAdes coronaspades;
  fi
fi
#
if [[ "$RUN_METASPADES" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "metaspades.py" metaspades metaSPAdes;
    
  else
    VERIFY_EXECUTION metaspades metaSPAdes metaspades;
  fi
fi
#
if [[ "$RUN_METAVIRALSPADES" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "metaviralspades.py" metaviralspades metaviralSPAdes;
    
  else
    VERIFY_EXECUTION metaviralspades metaviralSPAdes metaviralspades;
  fi
fi
#
if [[ "$RUN_HAPLOFLOW" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate haploflow
    PROGRAM_EXISTS "haploflow" haploflow Haploflow; 
    
  else
    VERIFY_EXECUTION haploflow Haploflow haploflow;
  fi
fi
#
if [[ "$RUN_IRMA" -eq "1" ]]; 
  then
  
    if [[ "$CAREFUL" -eq "0" ]];
    then
    
    PROGRAM_EXISTS_V2 "IRMA" irma IRMA; 
    
  else
    VERIFY_EXECUTION irma IRMA irma;
  fi
fi
#
if [[ "$RUN_LAZYPIPE" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate blast
    conda activate --stack lazypipe
    PROGRAM_EXISTS_V2 "lazypipe.pl" lazypipe LAZYPIPE2;
    
  else
    VERIFY_EXECUTION lazypipe LAZYPIPE2 lazypipe;
  fi
fi
#
if [[ "$RUN_PEHAPLO" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate bio2
    PROGRAM_EXISTS_V2 "pehaplo.p*" pehaplo PEHaplo;
    
  else
    VERIFY_EXECUTION pehaplo PEHaplo pehaplo;
  fi
fi
#    
if [[ "$RUN_QURE" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate java-env
    PROGRAM_EXISTS_V2 "QuRe_v0.99971" qure QuRe; 
    
  else
    VERIFY_EXECUTION qure QuRe qure; 
  fi
fi    
#
if [[ "$RUN_QVG" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate qvg
    PROGRAM_EXISTS_V2 "QVG.sh" qvg QVG qvg;
    
  else
    VERIFY_EXECUTION qvg QVG qvg;
  fi
fi    
#    
if [[ "$RUN_SSAKE" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate base
    PROGRAM_EXISTS_V2 "runSSAKE.sh" ssake SSAKE ssake;
    
  else
    VERIFY_EXECUTION ssake SSAKE ssake;
  fi
fi    
#
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate tracespipelite
    PROGRAM_EXISTS_V2 "TRACESPipeLite.sh" tracespipelite TRACESPipeLite;
    
  else
    VERIFY_EXECUTION tracespipelite TRACESPipeLite tracespipelite;
  fi
fi    
#
if [[ "$RUN_TRACESPIPE" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate tracespipe
    PROGRAM_EXISTS_V2 "TRACESPipe.sh" tracespipe TRACESPipe;
    
  else
    VERIFY_EXECUTION tracespipe TRACESPipe tracespipe;
  fi
fi    
#
if [[ "$RUN_VIRGENA" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate java-env   
    PROGRAM_EXISTS_V2 "VirGenA.jar" virgena VirGenA;
    
  else
    VERIFY_EXECUTION virgena VirGenA virgena;
  fi
fi 
#
if [[ "$RUN_VISPA" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate vispa
    PROGRAM_EXISTS_V2 "main_mosaik.bash" vispa ViSpA;
    
  else
    VERIFY_EXECUTION vispa ViSpA vispa;
  fi
fi  
#
if [[ "$RUN_VPIPE" -eq "1" ]];
  then
  
  if [[ "$CAREFUL" -eq "0" ]];
    then
    
    eval "$(conda shell.bash hook)"
    conda activate base
    PROGRAM_EXISTS_V2 "vpipe" vpipe V-Pipe; 
    
  else
    VERIFY_EXECUTION vpipe V-Pipe v-pipe; 
  fi
fi 
#
#
if [[ "$RUN_AUX_TOOLS" -eq "1" ]];
  then
    eval "$(conda shell.bash hook)"
    # Simulation tools
    conda activate base
    PROGRAM_EXISTS "gto" tools GTO;
    PROGRAM_EXISTS "./sratoolkit.3.0.7-ubuntu64/bin/fastq-dump" tools sratoolkit-fastq-dump;
    PROGRAM_EXISTS "./sratoolkit.3.0.7-ubuntu64/bin/prefetch" tools sratoolkit-prefetch;
    PROGRAM_EXISTS "art_illumina" tools ART;
    PROGRAM_EXISTS "AlcoR" tools AlcoR;
    
fi 
#
#
#
if [[ "$FILES" -eq "1" ]];
  then
    printf "Starting dataset verificaton...\n"
    for dataset in "${DATASETS[@]}"
      do
      if [[ -f ${dataset}.fa ]]; then
        if [[ -f ${dataset}_1.fq ]]; then
          if [[ -f ${dataset}_2.fq ]]; then
            printf "\e[42m${dataset} exists\e[49m\n"
          else
            printf "\e[41m${dataset} with errors\e[49m\n"
          fi
        else
          printf "\e[41m${dataset} with errors\e[49m\n"
        fi
      else
        printf "\e[41m${dataset} with errors\e[49m\n"
      fi
    done 
    
    
    for dataset in "${REAL_DATASETS[@]}"
      do
      VERIFY_DATASET $dataset
    done    
    
    
    for virus in "${VIRUSES[@]}"
      do
      if [[ -f ${virus}.fa ]]; then
        printf "\e[42m${virus} exists\e[49m\n"
      else
        printf "\e[41m${virus} with errors\e[49m\n"
      fi
    done 
fi
#
