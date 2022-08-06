{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Main where

import Control.Monad (filterM, forM_, when)
import Data.Bifunctor (bimap)
import Data.Bool (bool)
import Data.Char (isSpace)
import Data.List (dropWhileEnd, elemIndex, find)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe (catMaybes, fromJust, fromMaybe, isJust, isNothing)
import System.Directory (getHomeDirectory)
import System.Environment.XDG.BaseDir (getUserConfigFile)
import System.Exit (exitSuccess)
import System.FilePath ((</>))
import System.IO.Unsafe (unsafeDupablePerformIO)
import Text.Regex.TDFA ((=~))
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys (keysResizeWindow)
import XMonad.Actions.Navigation2D
import XMonad.Actions.NoBorders (toggleBorder)
import XMonad.Actions.OnScreen (Focus (..), onScreen)
import XMonad.Actions.Submap
import XMonad.Actions.SwapWorkspaces
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.Fullscreen (fullscreenManageHook)
import XMonad.Layout.MultiToggle (Toggle (..), mkToggle, single, (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (..))
import XMonad.Layout.NoBorders (borderEventHook)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing (Border (..), spacingRaw)
import XMonad.Prompt (XPConfig (..), XPPosition (..))
import XMonad.Prompt.ConfirmPrompt
import qualified XMonad.StackSet as W
import XMonad.Util.Cursor (setDefaultCursor, xC_left_ptr)
import XMonad.Util.EZConfig
import qualified XMonad.Util.ExtensibleState as ES
import XMonad.Util.Run (runProcessWithInput)
import XMonad.Util.SpawnOnce (spawnOnce)

---------------------------------------------------------------------

{- |
   Module : Theme.Theme
   Copyright : (c) 2021 Joan Milev <joantmilev@gmail.com>
   License : MIT
   Maintainer : Joan Milev <joantmilev@gmail.com>
   Stability : Stable
   Portability : Unknown
-}

basebg, basefg, basecr, base00, base08, base01, base09, base02, base10, base03, base11, base04, base12, base05, base13, base06, base14, base07, base15 :: String
basebg = xprop "*.background"
basefg = xprop "*.foreground"
basecr = xprop "*.cursorColor"
base00 = xprop "*.color0"
base08 = xprop "*.color8"
base01 = xprop "*.color1"
base09 = xprop "*.color9"
base02 = xprop "*.color2"
base10 = xprop "*.color10"
base03 = xprop "*.color3"
base11 = xprop "*.color11"
base04 = xprop "*.color4"
base12 = xprop "*.color12"
base05 = xprop "*.color5"
base13 = xprop "*.color13"
base06 = xprop "*.color6"
base14 = xprop "*.color14"
base07 = xprop "*.color7"
base15 = xprop "*.color15"

---------------------------------------------------------------------

main :: IO ()
main = do
  xmonad . ewmh . ewmhFullscreen $ docks myConfig

---------------------------------------------------------------------

-- myConfig :: XConfig _
myConfig =
  let c = def { borderWidth         = 2
              , normalBorderColor   = basebg
              , focusedBorderColor  = basefg
              , terminal            = "alacritty"
              , modMask             = mod4Mask
              , manageHook          = defaultWorkspaceManageHook <+> myManageHook <+> manageHook def
              , handleEventHook     = borderEventHook <+> handleEventHook def
              , layoutHook          = myLayoutHook
              , startupHook         = do
                  setWMName "LG3D"
                
                  spawnOnce "nitrogen --restore"
                  liftIO (getUserConfigFile "polybar" "launch.sh") >>= spawn

                  spawnOnce "picom"
                  spawnOnce "dunst"

                  spawnOnce "numlockx on"

                  spawnOnce "xidlehook --not-when-fullscreen --not-when-audio --timer 300 'betterlockscreen -l dim' '' --timer 3600 'systemctl suspend' ''"

                  spawnOnce "pulse-listener | xob -s default 1> /dev/null"
                  spawnOnce "brightness-listener | xob -s brightness 1> /dev/null"

                  registerDefaultWorkspaces
                  pure ()
              , keys                = \ c -> mkKeymap c (myKeys c)
              , workspaces          = snd <$> myWorkspaces
              , focusFollowsMouse   = True
              , clickJustFocuses    = False
              }
  in
    navigation2DP (def { defaultTiledNavigation = sideNavigation
                       , screenNavigation       = sideNavigation })
                  ("<U>", "<L>", "<D>", "<R>")
                  [ ("M-", windowGo), ("M-S-", windowSwap) ]
                  False
    $ c

myLayoutHook =
  let myGaps = 7
  in mkToggle (single FULL)
--     $ smartBorders
--     $ lessBorders OnlyScreenFloat
     $ tiled myGaps ||| fullscreen
  where
    tiled myGaps = avoidStruts
      $ spacingRaw False (Border 0 myGaps 0 myGaps) True (Border myGaps 0 myGaps 0) True
      $ ResizableTall 1 (2/100) (1/2) []

    fullscreen = Full

myKeys :: XConfig a -> [(String, X ())]
myKeys c =
  [ ("M-S-e",                     confirmPrompt nordXPConfig "exit" $ io exitSuccess)
  , ("M-S-r",                     liftIO getHomeDirectory >>= \ homeDir -> restart (homeDir </> ".nix-profile" </> "bin" </> "xmonad") True)
  , ("M-S-q",                     withFocused killWindow)
  , ("M-<Return>",                spawn (terminal c))
  , ("M-d",                       spawn "rofi -show drun")
  , ("M-r",                       withFocused resizeMode)
  , ("M-S-b",                     withFocused toggleBorder)
  , ("M-<Print>",                 spawn "flameshot gui")
  , ("M-S-<Space>",               withFocused floatOrUnfloat)
  , ("M-l",                       spawn "betterlockscreen -l dim")
  , ("M-S-u",                     spawn "unipicker --copy")
  , ("M-f",                       sendMessage (Toggle FULL))
  , ("M-C-<Right>",               swapWorkspaces' Next)
  , ("M-C-<Left>",                swapWorkspaces' Prev)
  -- ↓↓↓ Special keys ↓↓↓
  -- • Display backlight level
  , ("<XF86MonBrightnessUp>",     spawn "brightnessctl s 5%+")
  , ("<XF86MonBrightnessDown>",   spawn "brightnessctl s 5%-")
  -- • Audio level
  , ("<XF86AudioRaiseVolume>",    spawn "pactl set-sink-volume @DEFAULT_SINK@ +4%")
  , ("<XF86AudioLowerVolume>",    spawn "pactl set-sink-volume @DEFAULT_SINK@ -4%")
  , ("<XF86AudioMute>",           spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  -- • Keyboard backlight level
  , ("<XF86KbdBrightnessUp>",     spawn "brightnessctl --device=$(brightnessctl --list | grep kbd | awk '{print $2}' | sed -e \"s/'//g\") s 1+")
  , ("<XF86KbdBrightnessDown>",   spawn "brightnessctl --device=$(brightnessctl --list | grep kbd | awk '{print $2}' | sed -e \"s/'//g\") s 1-")
  -- • Music
  , ("<XF86AudioPrev>",           spawn "player-mpris-tail previous")
  , ("<XF86AudioNext>",           spawn "player-mpris-tail next")
  , ("<XF86AudioPlay>",           spawn "player-mpris-tail play-pause")
  , ("<XF86AudioStop>",           spawn "player-mpris-tail stop")
  ] <> workspaceSwitch
  where
    resizeMode win = submap . mkKeymap c $
      [ ("<L>",       resizeLeft win   >> resizeMode win)
      , ("<R>",       resizeRight win  >> resizeMode win)
      , ("<U>",       resizeTop win    >> resizeMode win)
      , ("<D>",       resizeBottom win >> resizeMode win)
      , ("<Escape>",  pure ())
      ]

    resizeLeft win   = isFloating win >>= bool (sendMessage Shrink) (keysResizeWindow (-10, 0) (0, 0) win)
    resizeRight win  = isFloating win >>= bool (sendMessage Expand) (keysResizeWindow (10, 0) (0, 0) win)
    resizeTop win    = isFloating win >>= bool (sendMessage MirrorExpand) (keysResizeWindow (0, -10) (0, 0) win)
    resizeBottom win = isFloating win >>= bool (sendMessage MirrorShrink) (keysResizeWindow (0, 10) (0, 0) win)

    workspaceSwitch = mconcat
      [ [ ("M-" <> key,   viewWorkspaceOnCorrectScreen ws)
        , ("M-S-" <> key, shiftToWorkspace ws)
        ]
      | (key, ws) <- myWorkspaces
      ]

    isFloating :: Window -> X Bool
    isFloating win = gets (Map.member win . W.floating . windowset)

    floatOrUnfloat win = isFloating win >>= bool (float win) (windows $ W.sink win)

myWorkspaces :: [(String, WorkspaceId)]
myWorkspaces =
  [ ("&",  "chat")
  , ("é",  "dev")
  , ("\"", "www")
  , ("'",  "4")
  , ("(",  "5")
  , ("-",  "music")
  , ("è",  "settings")
  , ("_",  "games")
  , ("ç",  "9")
  , ("à",  "0")
  ]

defaultWorkspaceManageHook :: ManageHook
defaultWorkspaceManageHook = composeAll
  [      className =?  "Emacs"
    <||> className =?  "jetbrains-idea-ce"    --> doShift "dev"
  ,      className =?  "discord"              --> doShift "chat"
  ,      className =?  "Brave-browser"        --> doShift "www"
  ,      className =?  "vlc"
    <||> className =?  "Audacity"             --> doShift "music"
  ,      className =?  "Pulseeffects"
    <||> className =?  "easyeffects"
    <||> className =?  "Pavucontrol"          --> doShift "settings"
  ,      className =?  "minecraft-launcher"
    <||> className =~? "Minecraft.*"          --> doShift "games"
  ]
  where
    (=~?) :: Query String -> String -> Query Bool
    q =~? r = (=~ r) <$> q

myManageHook :: ManageHook
myManageHook = composeOne
  [ isDesktop                     -?> doWindowAction sendToBottom
  , isDock                        -?> doWindowAction sendToJustAboveDesktop
  , isOSD                         -?> doCenterFloat
  , isDialog                      -?> doCenterFloat
  , isRole =? "pop_up"            -?> doCenterFloat
  , transience                    --- move to parent window
  , className =? "Xmessage"       -?> doCenterFloat
--  , isFullscreen                  -?> doFullFloat
  , pure True                     -?> insertPosition Below Newer
  ]
  where
    isRole    = stringProperty "WM_WINDOW_ROLE"
    isDesktop = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DESKTOP"
    isDock    = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DOCK"
    isOSD     = isInProperty "_NET_WM_WINDOW_TYPE" "_KDE_NET_WM_WINDOW_TYPE_ON_SCREEN_DISPLAY"

---------------------------------------------------------------------

nordXPConfig :: XPConfig
nordXPConfig = def
  { font                  = "xft:Iosevka:style=Regular:size=10"
  , bgColor               = basebg
  , fgColor               = basefg
  , bgHLight              = basefg
  , fgHLight              = basebg
  , borderColor           = basefg
  , position              = Top
  , height                = 22
  , showCompletionOnTab   = True
  }

---------------------------------------------------------------------

doWindowAction :: (Window -> X ()) -> ManageHook
doWindowAction action = ask >>= liftX . action >> idHook

allWindowsByType :: Query Bool -> X [Window]
allWindowsByType query = withDisplay $ \display -> do
  (_, _, windows) <- asks theRoot >>= io . queryTree display
  filterM (runQuery query) windows

sendToBottom :: Window -> X ()
sendToBottom window = withDisplay $ \display ->
  io $ lowerWindow display window

sendToJustAboveDesktop :: Window -> X ()
sendToJustAboveDesktop window = do
  sendToBottom window
  allWindowsByType isDesktop >>= mapM_ sendToBottom
  where
    isDesktop = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DESKTOP"


viewWorkspaceOnCorrectScreen :: WorkspaceId -> X ()
viewWorkspaceOnCorrectScreen wsid = do
  W.Screen{ W.screen = sid, W.workspace = ws, .. } <- withWindowSet (pure . W.current)
  sidToSpawnOn <- ES.gets (fromIntegral . Map.findWithDefault sid wsid)

  allScreens <- withWindowSet (pure . W.screens)
  sidToSpawnOn <- pure case lookupScreen sidToSpawnOn allScreens of
    Nothing -> sid
    Just _  -> sidToSpawnOn

  windows $ onScreen (W.view wsid) FocusNew sidToSpawnOn
  ES.modify (Map.insert wsid sidToSpawnOn)

  -- NOTE: we need to remove **all** un-focused empty workspaces
  hiddenWSs <- withWindowSet (pure . filter (isNothing . W.stack) . W.hidden)
  forM_ hiddenWSs \ ws -> do
    ES.modify (Map.delete $ W.tag ws :: WorkspaceState -> WorkspaceState)
  where
    lookupScreen sid []        = Nothing
    lookupScreen sid (screen:ss)
      | W.screen screen == sid = Just screen
      | otherwise              = lookupScreen sid ss

shiftToWorkspace :: WorkspaceId -> X ()
shiftToWorkspace wsid = do
  windows $ W.shift wsid
  withWindowSet \ wset -> do
    let W.Screen{ W.workspace = ws, .. } = W.current wset

    when (isNothing $ W.stack ws) do
      ES.modify (Map.delete $ W.tag ws :: WorkspaceState -> WorkspaceState)

swapWorkspaces' :: Direction1D -> X ()
swapWorkspaces' dir = do
  W.Screen { W.screen = currentScreenId, W.workspace = currentWS, .. } <- withWindowSet (pure . W.current)

  case dir of
    Prev -> prevScreen
    Next -> nextScreen
  nextWS <- withWindowSet (pure . W.workspace . W.current)

  nextSid <- ES.gets (Map.findWithDefault currentScreenId (W.tag nextWS))
  currentSid <- ES.gets (Map.findWithDefault currentScreenId (W.tag currentWS))

  case dir of
    Prev -> swapNextScreen
    Next -> swapPrevScreen

  ES.modify (Map.insert (W.tag currentWS) nextSid :: WorkspaceState -> WorkspaceState)
  ES.modify (Map.insert (W.tag nextWS) currentSid :: WorkspaceState -> WorkspaceState)

registerDefaultWorkspaces :: X ()
registerDefaultWorkspaces = withWindowSet \ wset ->
  forM_ (W.screens wset) \ (W.Screen ws sid _) -> do
    ES.modify (Map.insertWith (const id) (W.tag ws) sid :: WorkspaceState -> WorkspaceState)
    -- NOTE: this function runs on every (re)start of xmonad; we don't want to re-register workspaces
    -- (those already are because the extension is persistent)


type WorkspaceState = Map WorkspaceId ScreenId

instance ExtensionClass WorkspaceState where
  initialValue = mempty
  extensionType = PersistentExtension

---------------------------------------------------------------------

{- |
   Module : Theme.Xresources
   Copyright : (c) 2021 Joan Milev <joantmilev@gmail.com>
   License : MIT
   Maintainer : Joan Milev <joantmilev@gmail.com>
   Stability : Stable
   Portability : Unknown
-}

xProperty :: String -> IO String
xProperty key = fromMaybe "" . findValue key <$> runProcessWithInput "xrdb" ["-query"] ""

findValue :: String -> String -> Maybe String
findValue xresKey xres = snd <$> find ((== xresKey) . fst) (catMaybes $ splitAtColon <$> lines xres)

splitAtColon :: String -> Maybe (String, String)
splitAtColon str = splitAtTrimming str <$> elemIndex ':' str

splitAtTrimming :: String -> Int -> (String, String)
splitAtTrimming str idx = bimap trim' (trim' . tail) $ splitAt idx str

trim', xprop :: ShowS
trim' = dropWhileEnd isSpace . dropWhile isSpace
xprop = unsafeDupablePerformIO . xProperty
