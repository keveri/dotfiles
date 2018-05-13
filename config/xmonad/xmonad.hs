import XMonad
import XMonad.Config.Desktop
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.DynamicLog
import XMonad.Layout.SimplestFloat
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.SimpleFloat


myModMask    = mod4Mask
myTerminal   = "termite"
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myBar        = "xmobar"
myLauncher   = "dmenu_run -l 10 -fn 'xos4 Terminus-10'"
myScreenshot = "xfce4-screenshooter -r"

myPP = xmobarPP { ppCurrent = xmobarColor "green" "" . wrap "<" ">" }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myKeys =
    [ ((myModMask, xK_d), spawn myLauncher)
    , ((myModMask .|. controlMask, xK_s), spawn "systemctl suspend")
    , ((myModMask .|. controlMask, xK_h), spawn "systemctl hibernate")
    , ((myModMask .|. controlMask, xK_l), spawn "i3lock -f -c 000000")
    , ((myModMask, xK_p), spawn myLauncher)
    , ((myModMask, xK_s), spawn myScreenshot)
    -- volume keys
    , ((0 , xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +1.5%")
    , ((0 , xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -1.5%")
    , ((0 , xF86XK_AudioMute),        spawn "pactl set-sink-mute 0 toggle")
    -- todo: brightness keys
    ]

myLayoutHook = smartSpacing 2 $ smartBorders $ desktopLayoutModifiers $
               Tall 1 (2/100) (1/2) |||
               Mirror (Tall 1 (2/100) (1/2)) |||
               ThreeColMid 1 (2/100) (1/2) |||
               Full |||
               simpleFloat

myFocusedBorderColor = "green"

myConfig = desktopConfig
    { terminal           = myTerminal
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , layoutHook         = myLayoutHook
    , focusedBorderColor = myFocusedBorderColor
    } `additionalKeys` myKeys

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
