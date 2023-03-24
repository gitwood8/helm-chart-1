#!/usr/bin/bash
read -p "Enter a comment for commit: " COM
git add .
git commit -m "$COM"
git push