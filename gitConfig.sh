#!/bin/sh

git remote set-url origin git@github.com:soaresluciano/Scripts.git
echo -n "Please enter your name: "
read name
git config --global user.name "$name"
echo -n "Please enter your e-mail: "
read email
git config --global user.email "$email"
ssh-keygen -t ed25519 -C $email
cat ~/.ssh/id_ed25519.pub
echo "https://github.com/settings/ssh/new"
exec ssh-agent bash
ssh-add ~/.ssh/id_ed25519
