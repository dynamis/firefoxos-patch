## Firefox OS 日本ユーザ向けパッチファイル

Firefox OS のデフォルトビルドでは日本国内での利用を想定したソフトウェアや設定になっておらず、いくつかの制限事項があります。このスクリプトを用いて端末内のファイルを書き換えることで解決することができます


### 事前準備 - リモートデバッグを有効にする

adb を通じて端末内のファイルを読み書きできるようにするため、Settings (環境設定) アプリ を起動してリモートデバッグを有効化してください。

* Firefox OS 1.3 の場合
  * Device information (端末情報) =>  More Information (その他の情報) => Developer (開発者) => Remote debugging (リモートデバッグ) をオンにする
* Firefox OS 2.0 の場合
  * Developer (開発者) => Debugging via USB (USB 経由のデバッグ) を ADB only (ADB のみ) または ADB and DevTools (ADB と開発ツール) にする

リモートデバッグを有効にしたら Firefox OS 端末を USB ケーブル (データ通信対応) でパソコンに接続し adb コマンドで端末の接続を確認してください。

Windows の場合:
```
adb.exe devices
```

Mac / Linux の場合:
```
./adb devices
```

正しく接続できていれば次のように接続した端末の device id が出力されます。
```
$ ./adb devices
List of devices attached 
f296d820	device
```
note: Windows の場合 USB ケーブル初回接続時にはドライバのインストールが完了するのを待ってから実行してください。


### データ通信をする

国内の携帯ネットワークを通じてデータ通信を行う場合、データ通信に対応した SIM を端末 (Flame であれば背面左側の 3G 通信用 SIM スロット) に挿入し、電源を入れたらデータ通信の有効化と APN の設定を行ってください。

この設定は Settings (環境設定) アプリ => Cellular & Data (携帯ネットワーク設定) => SIM1 => Data settings (データ通信設定) で行えます。

ご利用の SIM が選択肢として表示されている場合はその項目を選択、表示されない場合は Custom Setting (カスタム設定) を選択して APN, Identifier (ユーザ名), Password (パスワード) などを入力して OK をタップし、Data connection (データ通信接続) をオンにしてください。

但し、初期出荷時のビルドなどではご利用の SIM によっては Custom Setting として APN 情報を入力しても設定値が反映されない場合があります (国内 MVNO SIM の多くの場合が該当)。そのような場合は (adb devices で端末の接続を確認した上で) 次のコマンドでスクリプトを実行してください。

Windows の場合:
```
patch-apn.bat
```

Mac / Linux の場合:
```
./patch-apn.sh
```

端末中の環境設定アプリに含まれる APN 設定情報ファイルを書き換えるスクリプトが実行され、次のように出力されます (Mac での出力例)。
```
$ ./patch-apn.sh
4791 KB/s (3150477 bytes in 0.642s)
Archive:  application.zip
  inflating: shared/resources/apn.json  
patching file shared/resources/apn.json
updating: shared/resources/apn.json (deflated 90%)
4131 KB/s (3151794 bytes in 0.744s)
Please restart Setting apps (or reboot the device) and set up apn for your SIM!
```

ホームボタンを長押ししてタスクマネージャを表示し、Settings (環境設定) アプリを終了させるか、端末を再起動したら再度 Settings (環境設定) アプリ => Cellular & Data (携帯ネットワーク設定) => SIM1 => Data settings (データ通信設定) を開き、適切な APN 設定を選択またはカスタム設定を入力してください。


### FM ラジオを聞く

Firefox OS 端末の FM ラジオで視聴できる周波数帯は OS の内部設定で調整できますが、既存の端末では国内の FM ラジオとは異なる周波数帯 (87.5MHz ~ 108.0 MHz) が設定されています。
この設定をアプリや環境設定画面から変更する機能は用意されていないため、国内で放送される周波数帯の FM ラジオを聞くには  (adb devices で端末の接続を確認した上で) 次のコマンドでスクリプトを実行してください。

Windows の場合:
```
patch-apn.bat
```

Mac / Linux の場合:
```
./patch-apn.sh
```

端末中のユーザ設定ファイル (user.js) に FM ラジオの周波数帯設定 ([dom.fmradio.band](http://dxr.mozilla.org/mozilla-central/source/dom/fmradio/FMRadioService.cpp)) が追記され、次のように出力されます (Mac での出力例)。
```
./patch-fmradio.sh 
remote object '/data/local/user.js' does not exist
36 KB/s (61 bytes in 0.001s)
Please reboot the device and enjoy radio!
```

端末を再起動してから FM Radio (FM ラジオ) アプリを起動すれば日本のラジオで使われるものを含めた周波数帯域 (76.0 MHz ~ 108.0 MHz) で設定できるようになります。

