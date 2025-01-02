#!/bin/zsh
set -u

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
. $SCRIPT_DIR/_common.sh

exit_if_not_macos

#----------------------------------------------------------
# Base
#----------------------------------------------------------
# スタンバイまでの時間を24時間へ変更 (デフォルト1時間)
sudo pmset -a standbydelay 86400
# ブート時のサウンドの無効化 (寂しい気もしますが煩いので消しています)
#sudo nvram SystemAudioVolume=" "
# スクロールバーの常時表示
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# コンソールアプリケーションの画面サイズ変更を高速にする
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# フリーズすると自動的に再起動
sudo systemsetup -setrestartfreeze on
# スリープさせない
sudo systemsetup -setcomputersleep Never > /dev/null
# 自動大文字の無効化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# クラッシュレポートの無効化
defaults write com.apple.CrashReporter DialogType -string "none"
# 時計アイコンクリック時にOSやホスト名ipを表示する
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# Bluetoothヘッドフォン/ヘッドセットの音質を向上させる
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# tabなどでMacのボタンのフォーカスを変えられるフルコントロールを設定
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# タップしたときに、クリックとする
defaults write -g com.apple.mouse.tapBehavior -int 1
# マウスの速度を速める
defaults write -g com.apple.mouse.scaling 5
# 3本指でmission control & expose
defaults write com.apple.dock showMissionControlGestureEnabled -bool true
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.dock showDesktopGestureEnabled -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool true
# 3本指ドラッグを有効化
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool false
# Bluetoothトラックパッドの設定を変更
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -bool false
# ユーザー設定の入力モードも変更
defaults write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -int 1

#----------------------------------------------------------
# Dock
#----------------------------------------------------------
# window効果の最大/最小を変更
defaults write com.apple.dock mineffect -string "scale"
# Dockで開いているアプリケーションのインジケータライトを表示する
defaults write com.apple.dock show-process-indicators -bool true
# 開いているアプリケーションのみをdockに表示
defaults write com.apple.dock static-only -bool true
# アプリケーション起動時のアニメーションを無効化
defaults write com.apple.dock launchanim -bool false
# すべての（デフォルトの）アプリアイコンをDockから消去する
defaults write com.apple.dock persistent-apps -array
# Dashboard無効化
defaults write com.apple.dashboard mcx-disabled -bool true

# ----------------------------------------------------------
# Finder
# ----------------------------------------------------------
# アニメーションを無効化する
defaults write com.apple.finder DisableAllAnimations -bool true
# デフォルトで隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder AppleShowAllFiles YES
# ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true
# パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true
# 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# 検索時にデフォルトでカレントディレクトリを検索
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# 拡張子変更時の警告を無効化
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# ディレクトリのスプリングロードを有効化
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
# スプリングロード遅延を除去
defaults write NSGlobalDomain com.apple.springing.delay -float 0
# USBやネットワークストレージに.DS_Storeファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# ディスク検証を無効化
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
# ボリュームマウント時に自動的にFinderを表示
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
# ゴミ箱を空にする前の警告の無効化
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# Show the ~/Library folder
chflags nohidden ~/Library
# Show the /Volumes folder
sudo chflags nohidden /Volumes

#----------------------------------------------------------
# App Store
#----------------------------------------------------------
# WebKitデベロッパーツールを有効にする
defaults write com.apple.appstore WebKitDeveloperExtras -bool true
# デバッグメニューを有効にする
defaults write com.apple.appstore ShowDebugMenu -bool true
# 自動更新チェックを有効にする
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# 毎日アプリケーションのアップデートを確認する
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# アプリケーションのアップデートをバックグラウンドでダウンロードする
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# システムデータファイルとセキュリティ更新プログラムをインストールする
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
# 他のMacで購入したアプリを自動的にダウンロードする
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1
# アプリケーションの自動更新を有効化
defaults write com.apple.commerce AutoUpdate -bool true
# 再起動が必要なアプリケーションの場合自動で再起動を有効化する
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

#----------------------------------------------------------
# Chrome
#----------------------------------------------------------
# トラックパッドの感度の悪いバックスワイプをすべて無効にする
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
# システム固有の印刷プレビューダイアログを使用する
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
# 既定で印刷ダイアログを展開する
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
