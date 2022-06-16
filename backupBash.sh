#!/bin/bash

#Comprobamos el numero de argumentos > 0
if test $# -gt 0
	
	#Comprobamos si argumento1 es un directorio
	if ! test -d $1 
	then
		echo "$1 no existe o no es un directorio"
		exit 1
	fi
	
	#Si solo hay 1 argumento el directorio de copia es $1
	if test $# -eq 1
	then		
		BACKUP_DIRECTORY=$1
	fi
	
	#Si hay 2 argumentos el directorio de copia es $2
	if test $# -eq 2
	then
		#Comprobamos si argumento2 es un directorio
		if ! test -d $2 
		then
			echo "$1 no existe o no es un directorio"
			exit 2
		
		else
			BACKUP_DIRECTORY=$2
			
		fi
	fi
	#Si hay más de 2 argumentos ERROR
	else
		echo "Demasiados argumentos, uso: $0 argumento1 o $0 argumento1 argumento2"
		exit 3
	fi 
#Si hay 0 argumentos ERROR
else
	echo "uso: $0 argumento1 o $0 argumento1 argumento2"
	exit 4
fi

#Nos situamos en la direccion de backup y creamos el directorio
cd $BACKUP_DIRECTORY
mkdir directorio1BAK

for FILE in `find $1 -name "*.txt"`
do
	#Movemos el archivo encontrado del directorio = argumento1 al directorio de backup (opcion de -b para copia de seguridad y archivos *.bak)
	mv -b $1/$FILE $BACKUP_DIRECTORY/directorio1BAK

	#Damos permisos solo de lectura al archivo encontrado
	chmod 444 $BACKUP_DIRECTORY/directorio1BAK/$FILE
done

#Nos situamos en el directorio donde hacemos la copia y muestra el tamaño total del directorio
cd $BACKUP_DIRECTORY/directorio1BAK
du -s 

