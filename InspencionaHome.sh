#!/bin/bash
#Script para fazer um relatorio de espaço utilizado por exetensões .mp4,.mp3 e .jpg


for user in /home/*
do
	MP4C=0
	MP3C=0
	JPGC=0
	OLDIFS=$IFS
	IFS=$'\n'
	for files in $(find $user -name '*.jpg' -o -name '*.mp4' -o -name '*.mp3')
	do
		case $files in
			*.mp4)
				MP4C=$(expr $MP4C + 1)
				;;
			*.mp3)
				MP3C=$(expr $MP3C + 1)
				;;
			*.jpg)
				JPGC=$(expr $JPGC+ 1)
				;;
		esac
	done

echo "Usuario: $(basename $user)"
echo "Arquivos JPG: $JPGC"
echo "Arquivos MP3: $MP3C"
echo "Arquivos MP4: $MP4C"
echo
done

IFS=$OLDIFS

