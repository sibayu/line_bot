# line_bot

＜line_botレポジトリ 詳細＞

・環境構築

主に下記のサイトを参考に構築しました。

『今更ながらRails5+line-bot-sdk-ruby+HerokuでLineBot作成してみたら、色々詰まったのでまとめました。』
→https://qiita.com/y428_b/items/d2b1a376f5900aea30dc

・変更を加えた箇所と変更内容

今回ラインボットの作成にあたって、変更を加えた箇所は
line_bot/app/controllers/disney_crawler.rb（webスクレイピングすることで待ち時間・更新時間の取得するファイル）
line_bot/app/controllers/linebot_controller.rb（ライン上での表示の仕方ファイル）
です。

・変更内容

line_bot/app/controllers/disney_crawler.rb

→Disneycrawlerというclassを作成し
https://tokyodisneyresort.info/realtime.php?park=land
https://tokyodisneyresort.info/realtime.php?park=sea
というサイトをopen-uriで開き、attraction_info変数の中に待ち時間情報・更新時間を格納し、
lists変数にattraction_info内の余分な空白・文字を除去した情報を格納し、
再度待ち時間情報の取得→アトラクション名の取得し、eachメソッドで一行ずつ表示させた情報をresult変数に格納しています。

line_bot/app/controllers/linebot_controller.rb

→変更を加えた箇所は主に30行目からで、ラインに送られたメッセージが『Disney sea』であればdisneyseaのurlでクロールされるため、disneyseaの情報が表示され
それ以外のメッセージの場合はdisneylandの情報が表示されるようになっています。
またline_bot/app/controllers/disney_crawler.rbファイルで作成したDisneycrawlerクラスをdisney_textに格納し文字が送られれば返せるようになっています。

