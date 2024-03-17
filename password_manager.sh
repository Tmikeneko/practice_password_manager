#!/bin/bash

echo 'パスワードマネージャーへようこそ！'
read -p 'サービス名を入力してください：' Service_Name
read -p 'ユーザー名を入力してください：' User_Name
read -p 'パスワードを入力してください：' Password
echo 'Thank you!'

echo $Service_Name $User_Name $Password>> password.txt
