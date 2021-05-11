#!/bin/bash

#Function create folder
#Function check total file
#Function add permission read
#Function add permission write
#Function redirect output
#Function backup
#Function countfile

# Check argument that users provide so only one be accept here

if ! [ $# -eq 1 ]; then
	echo "You must provide one argument e.g $0 argument"
	exit 1
fi

# Define a variable with name FOLDER as $1
FOLDER=$1
# Check argument users provided is folder or not

if [ -d "$FOLDER" ]; then
	echo "$FOLDER is an directory"
	echo "Create 3 sub-folder"
#	mkdir -p $FOLDER/loop/{img,txt,pdf}   ===> Method 1
# Define create folder function ()
	create_folder() {

		local FOLDER1=$1
		local FOLDER2=$2
		local FOLDER3=$3


		# Create a folder
		echo "Create three sub-folder $FOLDER1 $FOLDER2 $FOLDER3"
		sleep 3
		mkdir -p $FOLDER/loop/$FOLDER1 $FOLDER/loop/$FOLDER2 $FOLDER/loop/$FOLDER3
		ls -la $FOLDER/loop
	}

	#Call function create_foler() for creating foders
		create_folder IMG TXT PDF

# Define function create file img, txt, pdf inside each folder
		IMG="$FOLDER/loop/IMG"
		TXT="$FOLDER/loop/TXT"
		PDF="$FOLDER/loop/PDF"

		create_file() {

			local FILE_NAME=$1

			if [[ "$FILE_NAME" == "txt" ]]; then
				echo "Creating 10 txt files"
				for i in {1..10}
				do
					touch $TXT/file$i.$FILE_NAME
					sleep 3
					ls -la $TXT
				done
			elif [[ "$FILE_NAME" == "img" ]]; then
				echo "Creating 20 img files"
				for i in {1..20}
				do
					touch $IMG/file$i.$FILE_NAME
					sleep 3
					ls -la $IMG
				done
			else
				echo "Creating 20 pdf files"
				for i in {20..40}
				do
					touch $PDF/file$i.$FILE_NAME
					sleep 3
					ls -la $PDF
				done
			fi

		}

# Create 10 files for txt
		create_file txt
# Create 20 files for img
		create_file img
# Create 20 files for pdf
		create_file pdf

# Check total files in each folder img, txt, pdf
# Define function check_total_file()
		check_total_file() {

			local FILE_NAME_CHECK=$1
			# Check for txt
			if [[ "$FILE_NAME_CHECK" == "txt" ]]; then
				if [ `ls -1 $TXT/*.txt 2>/dev/null | wc -l ` -gt 9 ]; then
					echo "You just created enough 10 txt files"
					sleep 3
				else
					echo "You didn't create enough 10 txt files"
				    sleep 3
				fi
			# Check for img
			elif [[ "FILE_NAME_CHECK" == "img" ]]; then
				if [ `ls -1 $IMG/*.img 2>/dev/null | wc -l ` -gt 19 ]; then
					echo "You just created enough 20 img file"
					sleep 3
				else
					echo "You just didn't create enough 20 img file"
				fi
			# Check for pdf
			else
				if [ `ls -1 $PDF/*.pdf 2>/dev/null | wc -l ` -gt 19 ]; then
					echo "You just created enough 20 pdf file"
					sleep 3
				else
					echo "You just didn't create enough 20 pdf file"
					sleep 3
				fi
			fi
		}
# Check files for txt
		check_total_file txt
# Check files for txt
		check_total_file img
# Check files for txt
		check_total_file pdf
# Grant permisson full for all files in all sub-folders
# Define function to grant permision
		grant_permission() {

			local NAME_FOLDER1=$1
			local NAME_FOLDER2=$2
			local NAME_FOLDER3=$3

			#Define an array include three sub-folders

			ARRAY=($NAME_FOLDER1, $NAME_FOLDER2, $NAME_FOLDER3)
			for i in ${ARRAY[@]}
			do
				cd $FOLDER/loop/$i
				chmod 777 $FOLDER/loop/$i/*
				sleep 4
				ls -la $FOLDER/loop/$i
			done

		}
# Grant permission for all file
		grant_permission IMG TXT PDF

# Redirect output into file
# Define function for redirect output
# Define a variable for all img txt file
TXT_FILE="$TXT/*.txt"
PDF_FILE="$PDF/*.pdf"
IMG_FILE="$IMG/*.img"
		redirect_output() {

			local INPUT_FOLDER=$1
			local INPUT_FOLDER2=$2

			if [[ "$INPUT_FOLDER" == "IMG" ]]; then
				echo "Redirect output ls command in $INPUT_FOLDER into first 5 txt files"
				ls -a $IMG >> $TXT/file{1..5}.txt
				sleep 3
			elif [[ "$INPUT_FOLDER" == "TXT" ]]; then
				echo "Redirect output ls command in $INPUT_FOLDER into all pdf files"
				ls -lha $TXT >> $PDF_FILE
				sleep 3
			else
				echo "Redirect output ls command in $INPUT_FOLDER into img files"
				ls -la $TXT $PDF >> $IMG_FILE
				sleep 3
		}

# Redirect for IMG
		redirect_output IMG
# Redirect for TXT
		redirect_output TXT
# Redirect for PDF and TXT
		redirect_output
