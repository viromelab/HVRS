#!/bin/bash
#
#declare -a DATASETS=("DS3")
declare -a DATASETS=("DS1" "DS2" "DS3" "DS4" "DS5" "DS6" "DS7" "DS8" "DS9" "DS10" "DS11" "DS12" "DS13"  "DS14"  "DS15"  "DS16"  "DS17"  "DS18"  "DS19"  "DS20"  "DS21"  "DS22"  "DS23"  "DS24"  "DS25"  "DS26"  "DS27"  "DS28"  "DS29"  "DS30"  "DS31"  "DS32"  "DS33"  "DS34"  "DS35"  "DS36"  "DS37"  "DS38"  "DS39"  "DS40"  "DS41"  "DS42"  "DS43"  "DS44"  "DS45"  "DS46"  "DS47"  "DS48"  "DS49"  "DS50"  "DS51"  "DS52"  "DS53"  "DS54"  "DS55"  "DS56"  "DS57"  "DS58"  "DS59"  "DS60"  "DS61"  "DS62");
declare -a VIRUSES=("B19" "HPV" "VZV" "MCPyV" "MT");
#
declare -a ANALYSIS=("tracespipelite" "spades" "metaspades" "metaviralspades" "coronaspades" "ssake" "tracespipe" "lazypipe" "pehaplo" "haploflow");
declare -a NO_ANALYSIS=("qvg" "qure" "vispa" "virgena" "v");
#
declare -a CLASSIFICATION=("tracespipelite" "tracespipe" "lazypipe");
declare -a NO_CLASSIFICATION=("spades" "metaspades" "metaviralspades" "coronaspades" "ssake" "pehaplo" "qvg" "qure" "vispa" "virgena" "haploflow" "v");
#
declare -a ORDER_TOOLS=("coronaspades" "haploflow" "lazypipe" "metaspades" "metaviralspades" "pehaplo" "qure" "qvg" "spades" "ssake" "tracespipe" "tracespipelite" "virgena" "vispa" "v")
#
declare -a COVERAGE_2=("DS1" "DS9" "DS17"  "DS18"  "DS19"  "DS20"  "DS21"  "DS22"  "DS23"  "DS24")
declare -a COVERAGE_5=("DS2" "DS10" "DS25"  "DS26"  "DS27"  "DS28"  "DS29"  "DS30"  "DS31"  "DS32")
declare -a COVERAGE_10=("DS3" "DS11" "DS33"  "DS34"  "DS35"  "DS36"  "DS37"  "DS38"  "DS39"  "DS40")
declare -a COVERAGE_15=("DS4" "DS12")
declare -a COVERAGE_20=("DS5" "DS13" "DS41"  "DS42"  "DS43"  "DS44"  "DS45"  "DS46"  "DS47"  "DS48" "DS57"  "DS58" "DS61"  "DS62")
declare -a COVERAGE_25=("DS6" "DS14")
declare -a COVERAGE_30=("DS7" "DS15" "DS59")
declare -a COVERAGE_40=("DS8" "DS16" "DS49"  "DS50"  "DS51"  "DS52"  "DS53"  "DS54"  "DS55"  "DS56" "DS60")
#
declare -a SNP_1=("DS1"  "DS2"  "DS3"  "DS4"  "DS5"  "DS6"  "DS7"  "DS8"  "DS9"  "DS10"  "DS11"  "DS12"  "DS13"  "DS14"  "DS15"  "DS16" "DS57" "DS58" "DS61" "DS62")
declare -a SNP_0=("DS17"  "DS25"  "DS33"  "DS41" "DS49")
declare -a SNP_3=("DS18"  "DS26"  "DS34"  "DS42"  "DS50" "DS59")
declare -a SNP_5=("DS19"  "DS27"  "DS35"  "DS43"  "DS51" "DS60")
declare -a SNP_7=("DS20"  "DS28"  "DS36"  "DS44"  "DS52" )
declare -a SNP_9=("DS21"  "DS29"  "DS37"  "DS45"  "DS53")
declare -a SNP_11=("DS22"  "DS30"  "DS38"  "DS46"  "DS54")
declare -a SNP_13=("DS23"  "DS31"  "DS39"  "DS47"  "DS55")
declare -a SNP_15=("DS24"  "DS32"  "DS40"  "DS48"  "DS56")
#
declare -a CNT_0=("DS1" "DS2" "DS3" "DS4" "DS5" "DS6" "DS7" "DS8" "DS58")
declare -a CNT_3=("DS9" "DS10" "DS11" "DS12" "DS13"  "DS14"  "DS15"  "DS16"  "DS17"  "DS18"  "DS19"  "DS20"  "DS21"  "DS22"  "DS23"  "DS24"  "DS25"  "DS26"  "DS27"  "DS28"  "DS29"  "DS30"  "DS31"  "DS32"  "DS33"  "DS34"  "DS35"  "DS36"  "DS37"  "DS38"  "DS39"  "DS40"  "DS41"  "DS42"  "DS43"  "DS44"  "DS45"  "DS46"  "DS47"  "DS48"  "DS49"  "DS50"  "DS51"  "DS52"  "DS53"  "DS54"  "DS55"  "DS56"  "DS57" "DS59" "DS61"  "DS62")
declare -a CNT_6=("DS60")
#
count=0
#
D_PATH="reconstructed";
#
check_ds_coverage () { 
  cov_2=$(printf '%s\n' "${COVERAGE_2[@]}" | grep -w -- $dataset)
  cov_5=$(printf '%s\n' "${COVERAGE_5[@]}" | grep -w -- $dataset)
  cov_10=$(printf '%s\n' "${COVERAGE_10[@]}" | grep -w -- $dataset)
  cov_15=$(printf '%s\n' "${COVERAGE_15[@]}" | grep -w -- $dataset)
  cov_20=$(printf '%s\n' "${COVERAGE_20[@]}" | grep -w -- $dataset)
  cov_25=$(printf '%s\n' "${COVERAGE_25[@]}" | grep -w -- $dataset)
  cov_30=$(printf '%s\n' "${COVERAGE_30[@]}" | grep -w -- $dataset)
  cov_40=$(printf '%s\n' "${COVERAGE_40[@]}" | grep -w -- $dataset)

  if [ ! -z "$cov_2" ]
    then
    coverage=2  
  elif [ ! -z "$cov_5" ]
    then
    coverage=5
  elif [ ! -z "$cov_10" ]
    then
    coverage=10
  elif [ ! -z "$cov_15" ]
    then
    coverage=15
  elif [ ! -z "$cov_20" ]
    then
    coverage=20
    elif [ ! -z "$cov_25" ]
    then
    coverage=25
  elif [ ! -z "$cov_30" ]
    then
    coverage=30 
  elif [ ! -z "$cov_40" ]
    then
    coverage=40
  else
    coverage=0 
  fi
}
#
check_ds_snp () { 
  snp_0=$(printf '%s\n' "${SNP_0[@]}" | grep -w -- $dataset)
  snp_1=$(printf '%s\n' "${SNP_1[@]}" | grep -w -- $dataset)
  snp_3=$(printf '%s\n' "${SNP_3[@]}" | grep -w -- $dataset)
  snp_5=$(printf '%s\n' "${SNP_5[@]}" | grep -w -- $dataset)
  snp_7=$(printf '%s\n' "${SNP_7[@]}" | grep -w -- $dataset)
  snp_9=$(printf '%s\n' "${SNP_9[@]}" | grep -w -- $dataset)
  snp_11=$(printf '%s\n' "${SNP_11[@]}" | grep -w -- $dataset)
  snp_13=$(printf '%s\n' "${SNP_13[@]}" | grep -w -- $dataset)
  snp_15=$(printf '%s\n' "${SNP_15[@]}" | grep -w -- $dataset)

  if [ ! -z "$snp_0" ]
    then
    snp_ds=0.00  
  elif [ ! -z "$snp_1" ]
    then
    snp_ds=0.01
  elif [ ! -z "$snp_3" ]
    then
    snp_ds=0.03
  elif [ ! -z "$snp_5" ]
    then
    snp_ds=0.05
  elif [ ! -z "$snp_7" ]
    then
    snp_ds=0.07
  elif [ ! -z "$snp_9" ]
    then
    snp_ds=0.09
  elif [ ! -z "$snp_11" ]
    then
    snp_ds=0.11
  elif [ ! -z "$snp_13" ]
    then
    snp_ds=0.13
  elif [ ! -z "$snp_15" ]
    then
    snp_ds=0.15
  else
    snp_ds=10000 
  fi
  
  printf "cov - $coverage, $cov_2, $cov_5 \n\n\n\n"
}
#
check_ds_cont () { 
  cnt_0=$(printf '%s\n' "${CNT_0[@]}" | grep -w -- $dataset)
  cnt_3=$(printf '%s\n' "${CNT_3[@]}" | grep -w -- $dataset)
  cnt_6=$(printf '%s\n' "${CNT_6[@]}" | grep -w -- $dataset)
  
  if [ ! -z "$cnt_0" ]
    then
    cnt_ds=0.0  
  elif [ ! -z "$cnt_3" ]
    then
    cnt_ds=0.3
  elif [ ! -z "$cnt_6" ]
    then
    cnt_ds=0.6
  else
    cnt_ds=10000 
  fi
}

count=0
#
D_PATH="reconstructed";
#
cd $D_PATH
echo "Dataset	File	Time(s)	SNPs	AvgIdentity	NCD	NRC	Mem(GB)	%CPU	Nr contigs	Metagenomic_analysis	Metagenomic_classification	Coverage	SNP_mutations_DS	Contamination_ds" > total_stats.tsv
rm -rf total_stats.tex
for dataset in "${DATASETS[@]}" #analyse each virus
  do
  count=0
  check_ds_coverage
  check_ds_snp
  check_ds_cont
  printf "$dataset - Coverage: $coverage; SNPs : $snp_ds; Contamination : $cnt_ds\n"
  
  echo "\begin{table*}[h!]
\begin{center}
\caption{Results obtained for $dataset using the benchmark and applying it to the different databases generated. The execution time was measured in seconds, the RAM usage was measured in GB and the average identity, accuracy and CPU usage are presented as a percentage. The executions were, when possible, capped at 4 threads and 28 GB of RAM.}
\label{resultstable:$dataset}
\scriptsize
\begin{tabular}{| m{7.5em} | m{5em}| m{2.7em} | m{4em} | m{2.5em} | m{2.5em} | m{5em} | m{3em} | m{4em}  | m{6.5em} | m{6.5em} |}
\hline
\textbf{Reconstruction tool} & \textbf{Execution time} & \textbf{SNPs} & \textbf{Avg Identity} & \textbf{NCD} & \textbf{NRC} & \textbf{RAM usage} & \textbf{CPU usage} & \textbf{Number of contigs} & \textbf{Metagenomic analysis} & \textbf{Metagenomic classification} \\\\\\hline 

" >> total_stats.tex
  for file in `cd ${dataset};ls -1 *.fa*` #for each fasta file in curr dir
  do 
    rm -rf out.report	 
    TIME=-1
    SNPS=-1
    IDEN=1
    NCD=1
    NRC=1
    MEM=-1
    CPU_P=-1
    NR_SPECIES=-1
    DOES_ANALYSIS=-1
    DOES_CLASSIFICATION=-1

    printf "\n\nFile: $file\nDataset: $dataset \n\n"; #print file name, virus and dataset	  
    fst_char=$(cat $dataset/$file | head -c 1)
    if [[ -z "$fst_char" ]]; then
      printf "The result file is empty."    
    else
      dos2unix $dataset/$file
      #sed -i 's/_/-/g' $dataset/$file      
      #sed -i 's/\./-/g' $dataset/$file   
      awk -i inplace '{ while(sub(/QuRe./,int(rand()*99999999999)+1)); print }' $dataset/$file
      #awk -i inplace '{ while(sub(/_/,-); print }' $dataset/$file
      #awk -i inplace '{ while(sub(/100.0/,int(rand()*99999999999)+10)); print }' $dataset/$file
      awk -i inplace '{ while(sub(/results/,int(rand()*99999999999)+1)); print }' $dataset/$file
      #cat $dataset/$file | tr 0123456789 abcdefghij > tmp
      #mv tmp $dataset/$file

      dnadiff $dataset/$file ../$dataset.fa ; #run dnadiff
      IDEN=`cat out.report | grep "AvgIdentity " | head -n 1 | awk '{ print $2;}'`;  #retrieve results
      ALBA=`cat out.report | grep "AlignedBases " | head -n 1 | awk '{ print $2;}'`;
      SNPS=`cat out.report | grep TotalSNPs | awk '{ print $2;}'`;
      TBASES=`cat out.report | grep "TotalBases" | awk '{ print $2;}'`;
      AUX="$(cut -d')' -f1 <<< "$ALBA")"
      PERALBA="$(cut -d'(' -f2 <<< "$AUX")"
      TALBA="$(cut -d'(' -f1 <<< "$ALBA")"    
      NRBASES=`cat out.report | grep "TotalBases" | awk '{ print $2;}'`;  
    
      file_wout_extension="$(cut -d'.' -f1 <<< $file)"
      TIME=`cat $dataset/$file_wout_extension-time.txt | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $dataset/$file_wout_extension-time.txt | grep "MEM" | awk '{ print $2;}'`;
      CPU_P=`cat $dataset/$file_wout_extension-time.txt | grep "CPU_perc" | awk '{ print $2;}'`;
      #TMP=$(($TALBA * 100))
      #ACCURACY=$(echo $TMP \/ $TBASES |bc -l | xargs printf %.3f)
      
      NAME_TOOL="$(cut -d'-' -f1 <<< $file_wout_extension)"
      
      DOES_ANALYSIS="?"
      DOES_CLASSIFICATION="?"      

      for i in "${ANALYSIS[@]}" #check if the tool does metagenomic analysis
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          DOES_ANALYSIS="Yes"
          break
        fi 
      done
      
      if [ "$DOES_ANALYSIS" == "?" ] ; then
        for i in "${NO_ANALYSIS[@]}"
        do
          if [ "$i" == "$NAME_TOOL" ] ; then
            DOES_ANALYSIS="No"
            break
          fi 
        done
      fi
      
      for i in "${CLASSIFICATION[@]}" #check if the tool does metagenomic classification
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          DOES_CLASSIFICATION="Yes"
          break
        fi
      done
      
      if [ "$DOES_CLASSIFICATION" == "?" ] ; then
        for i in "${NO_CLASSIFICATION[@]}"
        do
          if [ "$i" == "$NAME_TOOL" ] ; then
            DOES_CLASSIFICATION="No"
            break
          fi 
        done
      fi
      
      NR_SPECIES=$(grep '>' $dataset/$file -c)
      gto_fasta_rand_extra_chars < $dataset/$file > tmp.fa
      gto_fasta_to_seq < tmp.fa > $dataset/$file_wout_extension.seq
      
      #Compressing sequences C(X) or C(X,Y)
      GeCo3 -tm 1:1:0:1:0.9/0:0:0 -tm 7:10:0:1:0/0:0:0 -tm 16:100:1:10:0/3:10:0.9 -lr 0.03 -hs 64 $dataset/$file_wout_extension.seq   
      COMPRESSED_SIZE_WOUT_REF=$(ls -l $dataset/$file_wout_extension.seq.co | cut -d' ' -f5)
      rm $dataset/$file_wout_extension.seq.*
      
      #Conditional compression C(X|Y) [use reference and target]
      GeCo3 -rm 20:500:1:12:0.9/3:100:0.9 -rm 13:200:1:1:0.9/0:0:0 -tm 1:1:0:1:0.9/0:0:0 -tm 7:10:0:1:0/0:0:0 -tm 16:100:1:10:0/3:10:0.9 -lr 0.03 -hs 64 -r ../DS1.fa $dataset/$file_wout_extension.seq
      COMPRESSED_SIZE_COND_COMPRESSION=$(ls -l $dataset/$file_wout_extension.seq.co | cut -d' ' -f5)      
      rm $dataset/$file_wout_extension.seq.*
      
      #Relative compression (only reference models) C(X||Y)
      GeCo3 -rm 20:500:1:12:0.9/3:100:0.9 -rm 13:200:1:1:0.9/0:0:0 -lr 0.03 -hs 64 -r ../DS1.fa $dataset/$file_wout_extension.seq
      COMPRESSED_SIZE_W_REF=$(ls -l $dataset/$file_wout_extension.seq.co | cut -d' ' -f5)      
      rm $dataset/$file_wout_extension.seq.*            
      FILE_SIZE=$(ls -l $dataset/$file_wout_extension.fa | cut -d' ' -f5)
     
      NCD=$(echo $COMPRESSED_SIZE_COND_COMPRESSION \/ $COMPRESSED_SIZE_WOUT_REF |bc -l | xargs printf %.3f)
      
      #max_val=1       
      #result=$( echo "$NCD>$max_value" | bc)
      #printf "$result......    \n\n"
      
      #if [ $( echo "2.101>3.004" | bc) == "1" ]
      #  then
      #  printf "NCD - Correcting value from $NCD to $max_val\n\n"
      #  NCD=$max_val   
      #fi
           
      AUX_MULT=$(echo "$FILE_SIZE * 2" | bc -l )
      NRC=$(echo $COMPRESSED_SIZE_W_REF \/ $AUX_MULT|bc -l | xargs printf %.3f)      
      
      IDEN=$(echo $IDEN |bc -l | xargs printf %.3f)
      MEM=$(echo $MEM \/ 1048576 |bc -l | xargs printf %.3f)
      
    #ds	file	exec_time	snps	avg_identity	NCD	NRC	max_mem	cpu_avg	nr_contigs_reconstructed	metagenomic_analysis	metagenomic_classification	coverage	snp_dataset
    echo "$dataset	$file	$TIME	$SNPS	$IDEN	$NCD	$NRC	$MEM	$CPU_P	$NR_SPECIES	$DOES_ANALYSIS	$DOES_CLASSIFICATION	$coverage	$snp_ds	$cnt_ds" >> total_stats.tsv   
    
    while [ "${ORDER_TOOLS[$count]}" != "$NAME_TOOL" ] #add empty lines for the tools that couldn't output results
    do
      echo "${ORDER_TOOLS[$count]} & -- & -- & -- & -- & -- & -- & -- & -- & -- & -- \\\\\\hline" >> total_stats.tex
      count=$(($count + 1))
    done
    CPU="$(cut -d'%' -f1 <<< "$CPU_P")"
    echo "$NAME_TOOL & $TIME & $SNPS & $IDEN & $NCD & $NRC & $MEM & $CPU & $NR_SPECIES & $DOES_ANALYSIS & $DOES_CLASSIFICATION \\\\\\hline" >> total_stats.tex
    count=$(($count + 1))
    #printf "%s\t%s\t%s\n" "$ALBA" "$IDEN" "$SNPS";
    fi
  done
  
  while [ ${#ORDER_TOOLS[@]} -gt $count ] #add empty lines for the tools that couldn't output results
    do
      echo "${ORDER_TOOLS[$count]} & -- & -- & -- & -- & -- & -- & -- & -- & -- & -- \\\\\\hline" >> total_stats.tex
      count=$(($count + 1))
    done  
    
    echo "
\end{tabular}
\end{center}
\end{table*}


" >> total_stats.tex  
done
#
