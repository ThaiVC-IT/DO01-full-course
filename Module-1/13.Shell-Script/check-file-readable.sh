#!/bin/bash

#set -x

# Check file if it is regular file

echo "Input name of file you wanna check: "
read FILE

if [ -r $FILE ]; then
    echo "Your file is readable"
    ls -la $FILE
else
    ls -la $FILE 
    echo "Your file is not readable file"
    echo "Add read permission for that $FILE"
    chmod +r $FILE
    ls -la $FILE
fi
