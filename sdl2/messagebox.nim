#
# Simple DirectMedia Layer
# Copyright (C) 1997-2013 Sam Lantinga <slouken@libsdl.org>
#
# This software is provided 'as-is', without any express or implied
# warranty.  In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.
#


const
  # TMessageBox flags. If supported will display warning icon, etc.
  MESSAGEBOX_ERROR* = 0x00000010 ## error dialog
  MESSAGEBOX_WARNING* = 0x00000020 ## warning dialog
  MESSAGEBOX_INFORMATION* = 0x00000040 ## informational dialog


  # Flags for TMessageBoxButtonData.
  MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT* = 0x00000001 ## Marks the default button when return is hit
  MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT* = 0x00000002 ## Marks the default button when escape is hit


type
  
  PMessageBoxButtonData* = ptr TMessageBoxButtonData
  TMessageBoxButtonData* = object
    ## Individual button data.
    flags*: Uint32 ## MessageBoxButtonFlags
    buttonid*: int ## defined button id (value returned via showMessageBox)
    text*: cstring ## The UTF-8 button text

  
  PMessageBoxColor* = ptr TMessageBoxColor
  TMessageBoxColor* = object
    ## RGB value used in a message box color scheme
    r*, g*, b*: Uint8


  TMessageBoxColorType* = enum
    MESSAGEBOX_COLOR_BACKGROUND,
    MESSAGEBOX_COLOR_TEXT,
    MESSAGEBOX_COLOR_BUTTON_BORDER,
    MESSAGEBOX_COLOR_BUTTON_BACKGROUND,
    MESSAGEBOX_COLOR_BUTTON_SELECTED,
    MESSAGEBOX_COLOR_MAX

  
  PMessageBoxColorScheme* = ptr TMessageBoxColorScheme
  TMessageBoxColorScheme* = object
    ## A set of colors to use for message box dialogs
    colors*: array[0..ord(MESSAGEBOX_COLOR_MAX)-1, TMessageBoxColor]


  PMessageBoxData* = ptr TMessageBoxData
  TMessageBoxData* = object
    ## MessageBox structure containing title, text, window, etc.
    flags*: Uint32 ## MessageBoxFlags
    window*: PWindow ## Parent window, can be nil
    title*: cstring ## UTF-8 title
    message*: cstring ## UTF-8 message text
    numbuttons*: int
    buttons*: PMessageBoxButtonData
    colorScheme*: PMessageBoxColorScheme ## TMessageBoxColorScheme, can be nil to use system settings


proc showMessageBox*(messageboxdata: PMessageBoxData, buttonid: ptr int): int {.cdecl, importc: "SDL_ShowMessageBox", dynlib: LibName.}
  ## Create a modal message box.
  ##
  ## ``messageboxdata`` The PMessageBoxData structure with title, text, etc.
  ##
  ## ``buttonid`` The pointer to which user id of hit button should be copied.
  ##
  ## Rreturn -1 on error, otherwise 0 and buttonid contains user id of button
  ## hit or -1 if dialog was closed.
  ##
  ## This function should be called on the thread that created the parent
  ## window, or on the main thread if the messagebox has no parent.  It will
  ## block execution of that thread until the user clicks a button or
  ## closes the messagebox.


proc showSimpleMessageBox*(flags: Uint32, title, message: cstring, window: PWindow): int {.cdecl, importc: "SDL_ShowSimpleMessageBox", dynlib: LibName.}
  ## Create a simple modal message box
  ##
  ## ``flags`` MessageBoxFlags
  ##
  ## ``title`` UTF-8 title text
  ##
  ## ``message`` UTF-8 message text
  ##
  ## ``window`` The parent window, or nil for no parent
  ##
  ## Return 0 on success, -1 on error
  ##
  ## See also: showMessageBox
