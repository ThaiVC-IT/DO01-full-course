#!/bin/bash


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
# Create 3 sub-folder using for loop 	  ===> Prefer Method in this assignment
	for i in {img,pdf,txt}
	do 
		mkdir -p $FOLDER/loop/$i
		ls -la $FOLDER/loop
	done
# Create file 20 file .img in IMG folder 
# Fist step define a variable with IMG folder for easy future task
 	IMG="$FOLDER/loop/img"
# 	cd $IMG && touch file{1..20}.img 		===> Method 1
#	cd $IMG && for i in {1..20}; do touch file$i.img; done     ==> Method 2
	cd $IMG 
	for i in {1..20}
	do 
		touch file$i.img
	done
	echo "Create 20 file .img in $IMG"
	ls -la $IMG
    sleep 4
# Create file 10 file .txt in TXT folder 
# Fist step define a variable with TXT folder for easy future task
	TXT="$FOLDER/loop/txt"
	cd $TXT && for i in {1..10}; do touch file$i.txt; done
	echo "Create 10 file .txt in $TXT"
	ls -la $TXT
	sleep 4
# Create file 20 file .pdf in PDF folder 
# Fist step define a variable with PDF folder for easy future task
	PDF="$FOLDER/loop/pdf"
	cd $PDF && touch file{20..40}.pdf
	echo "Create 20 file .pdf in $PDF"
	ls -la $PDF
	sleep 4
# Check file that was created in previous step exits or not 
# Check TXT
    if [ `ls -1 $TXT/*.txt 2>/dev/null | wc -l ` -gt 9 ]; then
     	echo "You just created enough 10 txt file"
# Define a variable for all img file
        TXT_FILE="$TXT/*.txt"
# Remove write permission for all txt file
		for i in $TXT_FILE
		do 
			chmod 777 $i
		done
    else 
     	echo "You just didn't create enough 10 txt file"
    fi

# Check PDF
 	if [ `ls -1 $PDF/*.pdf 2>/dev/null | wc -l ` -gt 19 ]; then
     	echo "You just created enough 20 pdf file"
# Define a variable for all img file
        PDF_FILE="$PDF/*.pdf"
# Remove write permission for all txt file
		for i in $PDF_FILE
		do 
			chmod 777 $i
		done
    else 
     	echo "You just didn't create enough 20 pdf file"
    fi
# Check IMG
    if [ `ls -1 $IMG/*.img 2>/dev/null | wc -l ` -gt 19 ]; then
     	echo "You just created enough 20 img file"
# Define a variable for all img file
        IMG_FILE="$IMG/*.img"
# Add read permission for all .img file
		for i in $IMG_FILE
		do 
			chmod 777 $i			
		done
    else 
     	echo "You just didn't create enough 20 img file"
    fi

    sleep 4 

# Redirect output ls -a in IMG folder into 5 first files txt
	echo "Redirect output $IMG into 5 first file in txt folder"
	for i in $TXT/file{1..5}.txt
	do
		ls -a $IMG >> $i
	done

	sleep 4

# Redirect output ls -a in TXT folder into all files pdf
	echo "Redirect output $TXT into all file in $PDF folder"
	for i in $PDF_FILE
	do
		ls -lha $TXT >> $i
	done

	sleep 4

# Redirect output 2 folder TXT and PDF into IMG all file
	echo "Redirect output $TXT vs $PDF into all file in $PDF folder"
    for i in $IMG_FILE
    do
    	ls -la $TXT $PDF >> $i
    done

    sleep 2

# Create folder backup 
	BACKUP="/root/backup"
	echo "Create folder backup $BACKUP"
    mkdir -p $BACKUP
    DATE=$(date +%Y-%m-%d_%H_%M_%S)
    echo "Create folder with $DATE as name of folder"
    mkdir -p $BACKUP/$DATE

    sleep 2
    
    echo "Backup file from $TXT $PDF $IMG into $BACKUP"
    for i in $TXT_FILE $PDF_FILE $IMG_FILE
    do
    	cp $i $BACKUP/$DATE
    done
    # Check backup status

 	if [ $? -eq 0 ]; then
 		echo "Backup was successfull"
 		# Delete all file in folder img
 	else 
 		echo "Backup was not successfull"
 		exit 1
 	fi
# Count file in each folder
# Create function to count file 
   	countfile()
   	{
   	 	local COUNT_FOLDER=$1

   	 	COUNT=`ls -1 $COUNT_FOLDER | wc -l`
   	 	echo "There are $COUNT in $COUNT_FOLDER"
   	}
# Count file for IMG folder
	echo ===========================
	echo "Count file for IMG folder"
	countfile $IMG
	sleep 4
## Count file for TXT folder
	echo ===========================
	echo "Count file for TXT folder"
	countfile $TXT
	sleep 4
# Count file for PDF folder
	echo ===========================
	echo "Count file for IMG folder"
	countfile $PDF
	sleep 4
elif [ -f $FOLDER ]; then
	echo "$FOLDER is a file"
else
	echo "$FOLDER is not exits"
	exit 1
fi
