#!/bin/bash
cd 
mkdir myDirectory
cd myDirectory
mkdir secondDirectory
cd secondDirectory
touch myNotePaper.txt
cp myNotePaper.txt ..
cd ..
mv myNotePaper.txt myOldNotePaper.txt

