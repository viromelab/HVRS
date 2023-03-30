#!/bin/bash
#
#declare -a DATASETS=("DS3" "DS4" "DS5");
declare -a DATASETS=("DS1" "DS2" "DS3" "DS4" "DS5" "DS6");
declare -a VIRUSES=("B19" "HPV" "VZV");
declare -a METAGENOMIC=("tracespipelite" "spades" "metaspades" "metaviralspades" "coronaspades" "ssake" "tracespipe" "lazypipe" "pehaplo");
declare -a NOT_METAGENOMIC=("qvg" "qure" "vispa" "virgena");
#
D_PATH="reconstructed";
#
cd $D_PATH
echo "Dataset	File	Time	Nr_bases	Total_Nr_Aligned_Bases	SNPs	AvgIdentity	Accuracy(%)	Mem	%CPU	Nr contigs	Metagenomic" > total_stats.tsv
rm -rf total_stats.tex
for dataset in "${DATASETS[@]}" #analyse each virus
  do
  printf "$dataset\n";	  


  echo "
  
$dataset
  
" >> total_stats.tex

  for file in `cd ${dataset};ls -1 *.fa*` #for each fasta file in curr dir
  do 	 
    printf "\n\nFile: $file\nDataset: $dataset \n\n"; #print file name, virus and dataset	  
    #cp $dataset/$file G_A.fa; #reference
    #cp ../$dataset.fa G_B.fa #query
    #
    fst_char=$(cat $dataset/$file | head -c 1)
    if [[ -z "$fst_char" ]]; then
      printf "The result file is empty."    
    else
      dnadiff $dataset/$file ../$dataset.fa ; #run dnadiff
      #quast $dataset/$file -r ../$dataset.fa ; #run quast
      #mv quast_results/results_*_*_*_*_* quast_results/results_${dataset}_$file
      #
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
    
      TMP=$(($TALBA * 100))
      ACCURACY=$(echo $TMP \/ $TBASES |bc -l | xargs printf %.3f)
      
      NAME_TOOL="$(cut -d'-' -f1 <<< $file_wout_extension)"
      CLASS="?"
      

      for i in "${METAGENOMIC[@]}" #analyse each virus
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          CLASS="Yes"
        fi 
      done
      
      for i in "${NOT_METAGENOMIC[@]}"
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          CLASS="No"
        fi 
      done
      
      NR_SPECIES=$(grep '>' $dataset/$file -c)
      
      
      
    #ds	file	exec_time	tbases	alignedbases	snps	avg_identity	max_mem	cpu_avg	nr_contigs_reconstructed	metagenomic
    echo "$dataset	$file	$TIME	$NRBASES	$TALBA	$SNPS	$IDEN	$ACCURACY	$MEM	$CPU_P	$NR_SPECIES	$CLASS" >> total_stats.tsv
    CPU="$(cut -d'%' -f1 <<< "$CPU_P")"
    echo "$NAME_TOOL & $TIME & $NRBASES & $TALBA & $SNPS & $IDEN & $ACCURACY & $MEM & $CPU & $NR_SPECIES & $CLASS \\\\\\hline" >> total_stats.tex
    printf "%s\t%s\t%s\n" "$ALBA" "$IDEN" "$SNPS";
    #rm -f G_A.fa G_B.fa ; #remove tmp files
    fi
  done
done
#
