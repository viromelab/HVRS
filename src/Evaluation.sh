#!/bin/bash
#
#declare -a DATASETS=("DS3" "DS4" "DS5");
declare -a DATASETS=("DS1" "DS2" "DS3" "DS4" "DS5" "DS6" "DS7" "DS8" "DS9");
declare -a VIRUSES=("B19" "HPV" "VZV" "MT");
#
declare -a ANALYSIS=("tracespipelite" "spades" "metaspades" "metaviralspades" "coronaspades" "ssake" "tracespipe" "lazypipe" "pehaplo");
declare -a NOT_ANALYSIS=("qvg" "qure" "vispa" "virgena");
#
declare -a CLASSIFICATION=("tracespipelite" "tracespipe");
#
D_PATH="reconstructed";
#
cd $D_PATH
echo "Dataset	File	Time	SNPs	AvgIdentity	NCD	NRC	Mem	%CPU	Nr contigs	Metagenomic_analysis	Metagenomic_classification" > total_stats.tsv
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
      
      DOES_ANALYSIS="?"
      DOES_CLASSIFICATION="?"
      

      for i in "${ANALYSIS[@]}" #analyse each virus
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          DOES_ANALYSIS="Yes"
        fi 
      done
      
      for i in "${NOT_ANALYSIS[@]}"
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          DOES_ANALYSIS="No"
        fi 
      done
      
      
      for i in "${CLASSIFICATION[@]}"
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          DOES_CLASSIFICATION="No"
        fi 
      done
      
      NR_SPECIES=$(grep '>' $dataset/$file -c)
      
      #Compressing sequences C(X) or C(X,Y)
      GeCo3 -l 1 -lr 0.06 -hs 8 $dataset/$file
      COMPRESSED_SIZE_WOUT_REF=$(ls -l $dataset/$file_wout_extension.fa.co | cut -d' ' -f5)
      rm $dataset/$file_wout_extension.fa.*
      
      #Conditional compression C(X|Y) [use reference and target]
      GeCo3 -rm 20:500:1:35:0.95/3:100:0.95 -rm 13:200:1:1:0.95/0:0:0 -lr 0.03 -hs 64 -r ../DS1.fa $dataset/$file
      COMPRESSED_SIZE_COND_COMPRESSION=$(ls -l $dataset/$file_wout_extension.fa.co | cut -d' ' -f5)      
      rm $dataset/$file_wout_extension.fa.*
      
      #Conditional (referential) exclusive compression C(X||Y)
      GeCo3 rm 20:500:1:35:0.95/3:100:0.95 -rm 13:200:1:1:0.95/0:0:0 -tm 10:200:0:1:0/0:200:0 -tm 15:100:0:1:0/0:100:0 -c 20 -g 0.85 -r ../DS1.fa $dataset/$file
      COMPRESSED_SIZE_W_REF=$(ls -l $dataset/$file_wout_extension.fa.co | cut -d' ' -f5)      
      rm $dataset/$file_wout_extension.fa.*
            
      FILE_SIZE=$(ls -l $dataset/$file_wout_extension.fa | cut -d' ' -f5)
      
      
      printf "Cond compress -> $COMPRESSED_SIZE_COND_COMPRESSION ; Compressed size wout ref -> $COMPRESSED_SIZE_WOUT_REF\n\n"
      NCD=$(echo $COMPRESSED_SIZE_COND_COMPRESSION \/ $COMPRESSED_SIZE_WOUT_REF |bc -l | xargs printf %.3f)
      AUX_MULT=$(($FILE_SIZE * 2))
      NRC=$(echo $COMPRESSED_SIZE_W_REF \/ $AUX_MULT|bc -l | xargs printf %.3f)
      
      
      
      
    #ds	file	exec_time	snps	avg_identity	NCD	NRC	max_mem	cpu_avg	nr_contigs_reconstructed	metagenomic_analysis	metagenomic_classification
    echo "$dataset	$file	$TIME	$SNPS	$IDEN	$NCD	$NRC	$MEM	$CPU_P	$NR_SPECIES	$DOES_ANALYSIS	$DOES_CLASSIFICATION" >> total_stats.tsv
    CPU="$(cut -d'%' -f1 <<< "$CPU_P")"
    echo "$NAME_TOOL & $TIME & $SNPS & $IDEN & $NCD & $NRC & $MEM & $CPU & $NR_SPECIES & $DOES_ANALYSIS & $DOES_CLASSIFICATION \\\\\\hline" >> total_stats.tex
    printf "%s\t%s\t%s\n" "$ALBA" "$IDEN" "$SNPS";
    #rm -f G_A.fa G_B.fa ; #remove tmp files
    fi
  done
done
#
