;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. "~/.mycontribs/")
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(javascript
     html
     typescript
     python
     lua
     (unicode-fonts :variables
                    unicode-fonts-enable-ligatures t)

     rust
     c-c++

     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     better-defaults
     emacs-lisp
     git
     helm
     (lsp :variables
          lsp-enable-snippet t           ;; THIS IS REQUIRED for snippets
          lsp-lens-enable t)
     auto-completion
     markdown
     multiple-cursors
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     themes-megapack
     treemacs)


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      centered-cursor-mode
                                      org-roam
                                      elcord
                                      )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 20

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "nerd-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil
   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light). A theme from external
   ;; package can be defined with `:package', or a theme can be defined with
   ;; `:location' to download the theme package, refer the themes section in
   ;; DOCUMENTATION.org for the full theme specifications.
   dotspacemacs-themes '(doom-vibrant
                         spacemacs-dark
                         spacemacs-light
                         )

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(doom :separator wave :separator-scale 1.5)
   ;;dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. This setting has no effect when
   ;; running Emacs in terminal. The font set here will be used for default and
   ;; fixed-pitch faces. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("JetBrainsMono Nerd Font Mono"
                               :size 18.0
                               :weight regular
                               :width normal)

   ;; Default icons font, it can be `all-the-icons' or `nerd-icons'.
   dotspacemacs-default-icons-font 'nerd-icons

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "M-<return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "M-<return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;;If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; It is also possible to use a posframe with the following cons cell
   ;; `(posframe . position)' where position can be one of `center',
   ;; `top-center', `bottom-center', `top-left-corner', `top-right-corner',
   ;; `top-right-corner', `bottom-left-corner' or `bottom-right-corner'
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; Whether side windows (such as those created by treemacs or neotree)
   ;; are kept or minimized by `spacemacs/toggle-maximize-window' (SPC w m).
   ;; (default t)
   dotspacemacs-maximize-window-keep-side-windows t

   ;; If nil, no load-hints enabled. If t, enable the `load-hints' which will
   ;; put the most likely path on the top of `load-path' to reduce walking
   ;; through the whole `load-path'. It's an experimental feature to speedup
   ;; Spacemacs on Windows. Refer the FAQ.org "load-hints" session for details.
   dotspacemacs-enable-load-hints nil

   ;; If t, enable the `package-quickstart' feature to avoid full package
   ;; loading, otherwise no `package-quickstart' attemption (default nil).
   ;; Refer the FAQ.org "package-quickstart" section for details.
   dotspacemacs-enable-package-quickstart nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling nil

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers 'relative

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `ack' and `grep'.
   ;; (default '("rg" "ag" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "ack" "grep")

   ;; The backend used for undo/redo functionality. Possible values are
   ;; `undo-fu', `undo-redo' and `undo-tree' see also `evil-undo-system'.
   ;; Note that saved undo history does not get transferred when changing
   ;; your undo system. The default is currently `undo-fu' as `undo-tree'
   ;; is not maintained anymore and `undo-redo' is very basic."
   dotspacemacs-undo-system 'undo-fu

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; The variable `global-spacemacs-whitespace-cleanup-modes' controls
   ;; which major modes have whitespace cleanup enabled or disabled
   ;; by default.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs t

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
  This function is called at the very end of Spacemacs startup, after layer
  configuration.
  Put your configuration code here, except for variables that should be set
  before packages are loaded."
  (global-company-mode)
                                        ; (global-centered-cursor-mode t)
  (global-centered-cursor-mode t)
  (global-visual-line-mode -1)
  (setq-default truncate-lines t)
  (elcord-mode)
  (global-hl-line-mode -1)

  ;; Fix scroll wheel compatibility
  (setq ccm-recenter-at-end-of-file t)
  (setq ccm-ignored-commands '(mouse-drag-region
                               mouse-set-point
                               widget-button-click
                               scroll-bar-toolkit-scroll
                               evil-mouse-drag-region
                               mwheel-scroll))

                                        ; (setq centered-cursor-mode-disable-on-scroll t)
                                        ;(setq scroll-preserve-screen-position t)
                                        ;(setq scroll-conservatively 100000001)

  (setq lsp-headerline-breadcrumb-enable nil)
  (setq-default evil-ex-search-persistent-highlight nil)
  ;; Optional: Also disable substitute command highlights if needed
  ;; (setq-default evil-ex-substitute-highlight-all nil)
  (setq lsp-idle-delay 0)  ;; delay before sending changes (default 0.2)
  (setq lsp-log-io nil)  ;; disable logging for better performance
  (setq lsp-enable-file-watchers nil)  ;; disable file watchers if causing issues
  (setq lsp-file-watch-threshold 5000)  ;; increase if you have large projects
  (setq lsp-enable-folding nil)  ;; disable if you don't use it
  (setq lsp-enable-symbol-highlighting nil)  ;; disable automatic highlighting
  (setq lsp-enable-on-type-formatting nil)  ;; can be slow
  ;;(setq lsp-ui-doc-enable t)
  ;;(setq lsp-ui-doc-position 'at-point)
  ;;(setq lsp-ui-doc-delay 0)
  ;;(setq lsp-ui-sideline-enable t)
  ;;(setq lsp-ui-sideline-show-hover t)

  (setq org-startup-indented t)

  ;; Better peek features
  ;;(setq lsp-ui-peek-enable t)
  ;;(setq lsp-ui-peek-always-show t)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-enable-indentation nil)  ; Disable LSP-controlled indentation
  (setq lsp-enable-snippet-text-edit nil)  ; Disable snippet-based edits

  (setq-default indent-tabs-mode nil)  ; Use spaces instead of tabs
  (setq-default tab-width 4)           ; Display width for tabs
  (setq-default standard-indent 4)     ; Standard indentation amount
  (setq-default evil-shift-width 4)
  ;; JavaScript/JS2
  (setq-default js-indent-level 4)
  (setq-default js2-basic-offset 4)

  ;; Web mode
  (setq-default web-mode-markup-indent-offset 4)
  (setq-default web-mode-css-indent-offset 4)
  (setq-default web-mode-code-indent-offset 4)

  ;; TypeScript
  (setq-default typescript-indent-level 4)

  ;; CSS/SCSS
  (setq-default css-indent-offset 4)

  ;; Python
  (setq-default python-indent-offset 4)

  ;; C/C++
  (setq-default c-basic-offset 4)

  ;; HTML
  (setq-default sgml-basic-offset 4)
  )


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(custom-safe-themes
     '("f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd"
       "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
       "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700"
       "4d5d11bfef87416d85673947e3ca3d3d5d985ad57b02a7bb2e32beaf785a100e"
       "d481904809c509641a1a1f1b1eb80b94c58c210145effc2631c1a7f2e4a2fdf4"
       "13096a9a6e75c7330c1bc500f30a8f4407bd618431c94aeab55c9855731a95e1"
       "dd4582661a1c6b865a33b89312c97a13a3885dc95992e2e5fc57456b4c545176"
       "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
       "f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
       "e8bd9bbf6506afca133125b0be48b1f033b1c8647c628652ab7a2fe065c10ef0"
       "3f24dd8f542f4aa8186a41d5770eb383f446d7228cd7a3413b9f5e0ec0d5f3c0"
       "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
       "915ad655a1dd15966d7edde92238997bae06d75aebf88c64d9a1df3257133078"
       "18a1d83b4e16993189749494d75e6adb0e15452c80c431aca4a867bcc8890ca9"
       "5244ba0273a952a536e07abaad1fdf7c90d7ebb3647f36269c23bfd1cf20b0b8"
       "5c7720c63b729140ed88cf35413f36c728ab7c70f8cd8422d9ee1cedeb618de5"
       "0592f1b03ba5d7d8cfade2ce3a23db4c0d5f9926c9ae918dd740739dd95b697c"
       "7fea145741b3ca719ae45e6533ad1f49b2a43bf199d9afaee5b6135fd9e6f9b8"
       "f253a920e076213277eb4cbbdf3ef2062e018016018a941df6931b995c6ff6f6"
       "b99ff6bfa13f0273ff8d0d0fd17cc44fab71dfdc293c7a8528280e690f084ef0"
       "bb0f3ae2f6f6f6dbbbe03df66d74ca0aecefa6723ac1686f421dd1ffe26b71c3"
       "3061706fa92759264751c64950df09b285e3a2d3a9db771e99bcbb2f9b470037"
       "f5f070872db3e4d8b82dbb2f3b1c60beca86fc93327a38ebddd22070458a14bc"
       "2f8af2a3a2fae6b6ea254e7aab6f3a8b5c936428b67869cef647c5f8e7985877"
       "39cb0376bfc26ca69c42b8410cb8e97bc6e72a6da53b4f1268de9bd1b347b9f3"
       "a9eeab09d61fef94084a95f82557e147d9630fbbb82a837f971f83e66e21e5ad"
       "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569"
       "4c16a8be2f20a68f0b63979722676a176c4f77e2216cc8fe0ea200f597ceb22e"
       "c5532fb4c3025eb02c9452ba64e4671fcd33900db00b5ea10b4bb919f32f70a5"
       "24fba8d15d029ca2ed94dc4722459e9b64d679d7ae14b77b61412e2c85b3b641"
       "74e27bf8147ee1bc825fdd819f9d3e85869979dec40c5105f18149bedb4bd881"
       "9af2b1c0728d278281d87dc91ead7f5d9f2287b1ed66ec8941e97ab7a6ab73c0"
       "7ed236688b971b70744d1410d4e86cebde9b2980e0568f38d22db4f319e8d135"
       "c71be1e48e851103e312e2fb82d00e2c13e9419751f428a559daf40494701760"
       "fdaf036ac62069f9b785ad2486b8106fb704b7c898d73ff7f66dc657523349d3"
       "f922af4e48f8d9409737d13038898c1655c7ec43e8c10a72488e6991beb84800"
       "41a36087a3c357a3228167889377dca3ba9670f0053ab18a6ca3f7c17883fb07"
       "032f0de3d3eba65c9f561ec788b029488074c6d66cd025c10be3bba359c0dd2c"
       "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
       "a9b47677ddcb6c1d17015d0c8007ca2af8a20ad4d4700bda75bf454afaad073b"
       "5c93d1c8acc529a7b3755327eda5fbe5013459ba63385ef67216a50720aabcc1"
       "3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b"
       "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd"
       "01f347a923dd21661412d4c5a7c7655bf17fb311b57ddbdbd6fce87bd7e58de6"
       "73434a894b58d29665b2b16fd1c2845883001a79e05ccb72318dfe4bdaf39191"
       "77fff78cc13a2ff41ad0a8ba2f09e8efd3c7e16be20725606c095f9a19c24d3d"
       "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6"
       "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93"
       "272461f4064d228ab41e9c9785540948627e6fb74f2dcff5ee063537c86fbad6"
       "e3439f3f68993309d65512c69e5a0046224a97e2fa36c0bbddfc88ee2c066405"
       "2a73ef80e6aa1efe7759c4fc1c7e52b6c092976788a26a292365a960f7c8d9b7"
       "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e"
       "66132890ee1f884b4f8e901f0c61c5ed078809626a547dbefbb201f900d03fd8"
       "f04122bbc305a202967fa1838e20ff741455307c2ae80a26035fbf5d637e325f"
       "b8e08919a9bbb24d4296fcccb9433d5c6b3249997f29619b4abead03915128f4"
       "d5fd482fcb0fe42e849caba275a01d4925e422963d1cd165565b31d3f4189c87"
       "075ebf0443b362beac7da83995a6af1cf30c1591502d22b32903e7cb4a854831"
       "a0074afc88f875c2d6905ca5bd39df1ca226e201fc2fd7338bac21df7d957b05"
       "ebdaa6f5ec2f4c5afb361d785d7c49374c4f0d0c0512132bc87f1372ffd9f506"
       "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" default))
   '(package-selected-packages
     '(ace-link add-node-modules-path afternoon-theme aggressive-indent alect-themes
                all-the-icons ample-theme ample-zen-theme anaconda-mode
                anti-zenburn-theme apropospriate-theme auto-compile
                auto-highlight-symbol auto-yasnippet autothemer avy-jump-helm-line
                badwolf-theme birds-of-paradise-plus-theme blacken
                bubbleberry-theme bui busybee-theme centered-cursor-mode
                cherry-blossom-theme chocolate-theme clean-aindent-mode
                clues-theme code-cells code-review color-theme-sanityinc-solarized
                color-theme-sanityinc-tomorrow column-enforce-mode
                company-anaconda company-c-headers company-lua company-web
                concurrent counsel counsel-css cpp-auto-include ctable
                cyberpunk-theme cython-mode dakrone-theme dap-mode darkmine-theme
                darkokai-theme darktooth-theme define-word devdocs diminish
                dired-quick-sort disable-mouse disaster django-theme doom-modeline
                doom-themes dotenv-mode dracula-theme drag-stuff dumb-jump
                edit-indirect ef-themes elcord elisp-def elisp-demos
                elisp-slime-nav emmet-mode emr epc espresso-theme eval-sexp-fu
                evil-anzu evil-args evil-cleverparens evil-collection
                evil-easymotion evil-escape evil-evilified-state evil-exchange
                evil-goggles evil-iedit-state evil-indent-plus evil-lion
                evil-lisp-state evil-matchit evil-mc evil-nerd-commenter
                evil-numbers evil-org evil-surround evil-textobj-line evil-tutor
                evil-unimpaired evil-visual-mark-mode evil-visualstar
                exotica-theme expand-region eyebrowse eziam-themes fancy-battery
                farmhouse-themes flatland-theme flatui-theme flycheck-elsa
                flycheck-package flycheck-pos-tip font-utils gandalf-theme gendoxy
                ggtags gh-md git-link git-messenger git-modes git-timemachine
                gitignore-templates gnuplot golden-ratio google-c-style
                google-translate gotham-theme grandshell-theme grizzl
                gruber-darker-theme gruvbox-theme haml-mode hc-zenburn-theme
                helm-ag helm-c-yasnippet helm-comint helm-company helm-cscope
                helm-css-scss helm-descbinds helm-ls-git helm-lsp helm-make
                helm-mode-manager helm-org helm-org-rifle helm-projectile
                helm-purpose helm-pydoc helm-swoop helm-xref hemisu-theme
                heroku-theme hide-comnt highlight-indentation highlight-numbers
                highlight-parentheses hl-todo holy-mode htmlize hungry-delete
                hybrid-mode impatient-mode import-js importmagic indent-guide
                info+ inkpot-theme inspector ir-black-theme ivy jazz-theme
                jbeans-theme js-doc js2-mode js2-refactor kaolin-themes ligature
                light-soap-theme link-hint live-py-mode livid-mode load-env-vars
                lorem-ipsum lsp-docker lsp-origami lsp-pyright lsp-treemacs lsp-ui
                lua-mode lush-theme macrostep madhat2r-theme markdown-toc
                material-theme memoize minimal-theme modus-themes moe-theme
                molokai-theme monochrome-theme monokai-theme multi-line
                multiple-cursors mustang-theme mwim nameless naquadah-theme
                nerd-icons noctilux-theme nodejs-repl nose npm-mode obsidian-theme
                occidental-theme oldlace-theme omtose-phellack-themes
                open-junk-file org-cliplink org-contrib org-download org-mime
                org-pomodoro org-present org-projectile org-rich-yank org-roam
                org-superstar organic-green-theme orgit-forge overseer
                page-break-lines paradox password-generator pcache pcre2el
                persistent-soft pet phoenix-dark-mono-theme
                phoenix-dark-pink-theme pip-requirements pipenv pippel
                planet-theme poetry popwin powerline prettier-js
                professional-theme pug-mode purple-haze-theme py-isort pydoc
                pyenv-mode pylookup python-pytest pythonic pyvenv quickrun
                railscasts-theme rainbow-delimiters rebecca-theme reformatter
                restart-emacs reverse-theme ron-mode ruff-format rust-mode rustic
                sass-mode scss-mode seti-theme shrink-path simple-httpd
                skewer-mode slim-mode smeargle smyx-theme soft-charcoal-theme
                soft-morning-theme soft-stone-theme solarized-theme soothe-theme
                space-doc spacegray-theme spaceline spaceline-all-the-icons
                spacemacs-purpose-popwin spacemacs-whitespace-cleanup sphinx-doc
                string-edit-at-point string-inflection subatomic-theme
                subatomic256-theme sublime-themes sunny-day-theme swiper
                symbol-overlay symon tagedit tango-2-theme tango-plus-theme
                tangotango-theme tao-theme term-cursor tern toc-org toxi-theme
                treemacs-evil treemacs-icons-dired treemacs-magit treemacs-persp
                treemacs-projectile twilight-anti-bright-theme
                twilight-bright-theme twilight-theme typescript-mode ucs-utils
                ujelly-theme underwater-theme undo-fu undo-fu-session unfill
                unicode-fonts uv vi-tilde-fringe vim-powerline volatile-highlights
                vundo web-beautify web-completion-data web-mode wgrep
                white-sand-theme winum writeroom-mode ws-butler xcscope
                xterm-color yapfify yasnippet-snippets zen-and-art-theme
                zenburn-theme zonokai-emacs)))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )
