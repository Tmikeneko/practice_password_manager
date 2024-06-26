#!/bin/bash

echo 'パスワードマネージャーへようこそ！'

while true; do
    read -p '次の選択肢から入力してください(Add Password/Get Password/Exit)：' Selection
    case "$Selection" in 

    # Add Password が入力された場合
    "Add Password") 
    read -p 'サービス名を入力してください：' Service_Name
    read -p 'ユーザー名を入力してください：' User_Name
    read -p 'パスワードを入力してください：' Password
    gpg -d password.txt.gpg > password.txt 2> /dev/null 
    
    echo $Service_Name $User_Name $Password>> password.txt

    #パスワードを暗号化   
    gpg -c --yes password.txt
    rm password.txt
    echo 'パスワードの追加は成功しました。' ;;

    # Get Password が入力された場合
    "Get Password")
    read -p 'サービス名を入力してください：'  Get_Service_Name 
    gpg -d password.txt.gpg > password.txt 2> /dev/null

    ## サービス名が保存されていた場合
        if grep -q "^$Get_Service_Name" password.txt; then
           echo -n "サービス名："
           grep "^$Get_Service_Name" password.txt | awk '{print $1}'
           echo -n "ユーザー名："
           grep "^$Get_Service_Name" password.txt | awk '{print $2}'
           echo -n "パスワード："
           grep "^$Get_Service_Name" password.txt | awk '{print $3}'
           rm password.txt
    ## サービス名が保存されていなかった場合
        else
        echo "そのサービスは登録されていません。"      
        fi ;;

    # Exit が入力された場合    
    "Exit") break ;;

    *) echo '入力が間違えています。Add Password/Get Password/Exit から入力してください。'
    esac
done
echo 'Thank you!'

