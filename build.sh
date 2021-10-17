
# command line args
file=$1

# compute word count
wc_file=$(cat ${file}.txt | sed -n '/\.\.\./,/# References/p' | sed 's/\.\.\.//' | sed 's/# References//' | sed 's/\\newpage//g' | sed 's/[0-9]\.//g' | sed 's/    [a-z].//g' | sed 's/    [a-z][a-z].//g' | sed 's/\\item//g' | sed 's/\\begin{itemize}//g' | sed 's/\\end{itemize}//g' | grep -v "#" | grep -v "[^[0-9]]:" | grep -v "[^[0-9][0-9]]:")
wc=$(echo ${wc_file} | wc -w)
echo "Word Count: $wc"
echo ${wc} | xargs > wc.txt

# compile
pandoc cover_sheet.txt -o cover_sheet.pdf
pandoc $file.txt -o $file.pdf
pdfunite cover_sheet.pdf $file.pdf submission.pdf

rm wc.txt cover_sheet.pdf $file.pdf