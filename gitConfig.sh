#!/bin/sh
echo -n "Please enter your name: "
read name
git config --global user.name "$name"
echo -n "Please enter your e-mail: "
read email
git config --global user.email "$email"
ssh-keygen -t ed25519 -C $email
exec ssh-agent bash
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
