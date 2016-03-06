##Clue開発までの流れ

本家(https://github.com/midwhite/clue)をgithub上でforkします．

Cloneしてきます．

`rake db:migrate`を行い，マイグレーションしたいのですが，mysqlサーバが起動した状態でないとマイグレーションが行えません．

Macなら`brew install mysql`でmysqlを入れた後，`mysql.server start`コマンドでmysqlを起動させます．

`rake db:create`コマンドでデータベースファイルを作成し，`rake db:migrate`でマイグレーションを実行します．

あとは`rails s`でWebサーバを立てて，`localhost:3000`にアクセスすればOK．
