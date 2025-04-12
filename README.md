Emacs Configuration
===================

Warning:

Most PATHS are given relative to ~/.emacs.d/!


Ideas
=====

The idea is to provide a simple setup for Emacs. However, the key
concept is to take it as a starting point and then (start to
re)configure everything from here on.

The reasons and ideas why I created this package like it is were:

   - I wanted to keep it simple and organized. And therefore,
   - Give a fuck about the starting time of Emacs (I got that 10
     seconds). This is also why I don't compile my *.el-files. That
     would decrease the start up time, but might cause trouble when
     changing the el files.
   - Make it possible to dig into Emacs for beginners without starting
     at zero. However, you will still need to understand the
     configuration mechanism. At least when there are problems!
   - Make it easy to spread this Emacs configuration to several
     machines with ease.


BTW there is no way around learning at least a little bit of (emacs)
lisp if you intend to use Emacs.


Included Packages
=================

This is a list of some of the most important packages you will get.

+ CEDET development version - semantic, EDE (Projects), etc.
+ ECB - windows displaying information (similar to eclipse windows)
+ ELDOC - mode-line information when cursor is on point
+ FLYCHECK -- automatic syntax checking on-the-fly for most programming languages
+ FLYSPELL -- automatic spell checking on-the-fly
+ HEADER 2 - Enter a header and footer in the files (try it with M-x make-header)
+ IDO - minibuffer helper
+ MULTIPLE CURSORS - use multiple cursors to edit the several lines at once
+ THESAURUS - choose synonym and replace
+ WINDOW NUMBER MODE - change windows by C-x C-j [NUMBER] or  META-[NUMBER]
+ YASNIPPET - snippets easily handled
+ JDEE Mode - Java helper mode (might be replaced by Cedet in the future)
+ ORG Mode - organize your life with Emacs: Calendar, Time Tracking, etc.
+ AUTO COMPLETE - completion
+ WHITESPACE MODE - mark 80th+ columns, show unneeded white-spaces, etc
+ MAKE BACKUPS - make backup each time you save the file
+ BACKUP-WALKER - diff through all your backups
+ MAGIT - git for emacs
+ DIRED - (standard in Emacs) file mangement for emacs
+ PAGER -- better scrolling
+ RAINBOW DELIMITERS - show parenthesis in different colors
+ RAINBOW MODE - background of color names in specified color
+ POWERLINE - better mod-line
+ ANDROID MODE - disabled and not yet tested!
+ GNUS - Newsreader and Email Client (you might want to disable it, when you are a beginner)
+ BBDB - Address-Book Management
+ LATEX/AUCTEX - latex support
+ COLOR THEME - change the colors of your emacs (see init.el)
+ EDBI - nice DB tool viewer (and bit of management)
+ UNDO TREE - check all undo/redo branches displayed in a tree (with multiple branches)
+ AUTOMATIC TAGS FILE GENERATION - automatic generation of tags files for various languages


Language Support
================

+ C/C++ (not fully integrated yet; not tested; that should happen the next couple months)
+ Haskell
+ Java (Check my Makefile for flymake support, see other github projects)
+ Emacs Lisp (of course)
+ OCaml (might be broke; hasn't been used for ages)
+ Makefile support
+ Latex support
+ all others built in to Emacs (no automatic TAGS generation)


Keys (READ the 5 paragraphs!):
==============================

Most main keys are left as it was. So I will not list them here.
However, changes were made of course. For example: C-w was set to
backward-kill-word (which deletes the word before cursor). This is the
standard Unix Terminal way. Kill region, which has originally was at
C-w, is not at C-x C-k.

Keys are set in 24/basic_keys.el and in the configuration files for
the packages (24/package_config/*) and languages
(24/language_configs/*).

Ensure you get used to the basic keys from 24/basic_keys.el!
Afterwards, when you start using a package you need to check the
specific package and language configuration. For example if you intend
to use the org mode (which is set default for text files), check out
24/packages_configs/org_mode_config.el for the specific configuration.


There is a prefix command for most user-defined key strokes. It can be
defined in the ~/.emacs.d/settings.el file, the default is C-x x.

Have a look at ~/.emacs.d/24/basic_keys.el for the main keys.

Example (with prefix being C-x x):

    | Key       | Function                | Description                                 |
    |-----------+-------------------------+---------------------------------------------|
    | C-x x C-q | save-buffers-kill-emacs | close emacs                                 |
    | C-x x c   | shell                   | a shell inside of emacs                     |
    | C-x x r   | replace-regexp          | find and replace using a REGular EXpression |
    | ...       |                         | check out the files and get used to them    |


Nifty Tricks:
-------------

+ Use TAGS:
  After saving a source code file (TAGS get automatically generated)
  try C-. or M-. for jumping to interesting tags.

+ Use Info:
  Try it with C-h i. You can get a lot of information about packages and related
  stuff from it!

+ Use ORG mode:
  Use the org mode for several things. Time tracking, calendar, todo lists,
  brainstorming or just normal text files. It is awesome when you know how to
  use it.

+ ...

How to Install
==============

You need to have Emacs 24. Either check what Emacs version your
distribution delivers or download it from http://www.gnu.org/software/emacs/.

For some distribution the commands are listed below this section.

1. Get the git repository

2. install all (needed) packages listed below. Command might be found below.

3. you need to create a settings.el file in ./emacs.d/settings.el (see
   settings.el.example)

4. you might want to disable (comment) the Gnus package for the first
   real start-up, see 24/emacs.el and search for gnus. Otherwise you
   definitely need configure it, see ~/.emacs.d/gnus.el and/or
   ~/.gnus!

5. you need to fire up emacs - all emacs melpa packages will be
   downloaded

    emacs -mm       # -mm for maximized

6. it should automatically compile cedet. Check if that worked out!

7. if you want to use mpc/mpd music player: setup mpd (music server)
   in ~/.mpdconf (a default setup is delivered with this setup and
   might already be copied to ~/.mpdconf, otherwise it can be found at
   ~/.emacs.d/.mpdconf).

8. you need to restart emacs (cedet doesn't like it, when new packages
   get installed)


    C-x C-c         # to close emacs when an error occured


Pacman Command:
---------------

Steps 1 + 2 + 3 + 5 + 7 (4 not included!). You must have Aura (see AUR) installed:

    mv ~/.emacs.d ~/.emacs.d.bak; true &&                                             # backup \
    git clone https://github.com/schnecki/dot-emacs.d ~/.emacs.d &&                   # download \
    mv ~/.emacs.d/settings.el.example ~/.emacs.d/settings.el &&                       # copy settings.el \
    su -c "pacman -S emacs ctags-etags gnuplot emacs graphviz wget                    # main tools \
    w3m curl                                                                          # browser for links \
    mpd                                                                               # install mpd music server \
    python-jedi python-virtualenv                                                     # Python completion \
    texlive evince" &&                                                                # LaTeX \
    su -c "aura -A eclim" &&                                                          # for Java using aura \
    cabal install hasktags hdevtools structured-haskell-mode stylish-haskell stack && # Haskell \
    cabal install hindent ghc-mod hoogle hlint HaRe                                && # Haskell cont'd \
    perl-CPAN mariadb-devel && cpan -fi Module::Build::Compat &&                      # database tools \
    cpan -fi RPC::EPC::Service DBI DBD::SQLite DBD::Pg DBD::mysql" &&                 # database tools \
    echo "(load-file \"~/.emacs.d/gnus.el\")" > ~/.gnus.el &&                         # create gnus file \
    mv ~/.emacs.d/settings.el.example ~/.emacs.d/settings.el;true &&                  # settings.el \
    mv ~/.mpd ~/.mpd.bak; true && mv ~/.mpdconf ~/.mpdconf.bak;true &&                # backup mpd config \
    mkdir -p ~/.mpd && mkdir -p ~/.mpd/playlists/ && touch ~/.mpd/log &&              # mpd config part 1 \
    touch ~/.mpd/database && mv ~/.emacs.d/.mpdconf ~/.mpdconf; true  &&              # mpd config part 2 \
    emacs -mm                                                                         # start emacs maximized

    # check step 2, 3, 4, 6 from How To Install menu above!


Windows 8:
----------

1. Get Emacs: https://www.gnu.org/software/emacs/
2. Get and install Git: http://git-scm.com/download/win
3. Install aspell and then at least one language: http://aspell.net/win32/

   Set ispell command in
   ~/.emacs.d/24/packages_configs/flyspell_config.el (if you did not
   change the default installation path during aspell installation,
   you do not need to do anything!).


3. Start Git Bash and do:

    $ cd ~/AppData/Roaming
    $ echo "(load-file \"~/.emacs.d/init.el\")" > ~/.emacs                    # for emacs this is ~
    $ echo "(load-file \"~/.emacs.d/gnus.el\")" > ~/.gnus.el
    $ git clone https://github.com/schnecki/dot-emacs-4-everyone .emacs.d


4. Then start emacs (from the bin folder of the unzipped emacs download)

5. Optional: You might want to change the default bash command to
'eshell to have a more UNIX-like shell.

6. Optional:
 - If you want to use Gnus (I could not get nnimap running in a
   short test, you might need to invest a little bit of time here):
   Install cygwin: http://cygwin.com/install.html
 - If you want to use mpc/mpd:
   Install mpd: http://www.musicpd.org/download.html
 - If you want to use magit, you need to get it running. I could not
   get it running with the first try and then had no more time to
   checkout the problem.


Dependencies:
-------------

+ Main dependencies
  - emacs
  - wget
  - ctags-etags

+ C/C++
  - cppcheck (for flycheck support)

+ Python
  - python-pip (for pylint)
  - pylint (for flycheck support)
  - python-jedi (for auto completion support)
  - python-virtualenv (for auto completion support)

+ Flycheck support for other languages
  - see http://flycheck.readthedocs.org/en/latest/guide/languages.html

+ Java
  - w3m (Javadoc Lookup inside of Emacs)

+ Gnus
  - curl (fetch html stuff)
  - w3m (display html mails)

+ Org Mode
  - gnuplot (optional)
  - graphviz

+ Latex:
  - evince (change latex_config.el to use other pdf-viewer)
  - texlive

+ Haskell
  - cabal (of course)
  - hdevtools
  - stack (needs libtinfo for Arch Linux from AUR)
    We highly encourage you to use stack, as it plays well together with
    flycheck and keeps your systems clean.
  - hasktags ($ cabal install hasktags)
  - hindent ($ stack install hindent)
  - stylish-haskell (format source code nicely)
  - structured-haskell-mode ($ cabal install structured-haskell-mode)
  - ghc-mod ($ cabal install ghc-mod)
  - hoogle ($ cabal install hoogle)
  - hindent ($ stack install hident)
  - hlint ($ cabal install hlint): code suggestions
  - HaRe ($ cabal install HaRe)
  - haskell-language-server ($ yay -S haskell-language-server-static hlint-bin stylish-haskell-bin)
  - sudo pacman -S python-lsp-server python-pycodestyle python-pydocstyle python-pylint python-rope autopep8

+ R
  - AIR Code Formatter ($ curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh)
  - see https://posit-dev.github.io/air/cli.html and https://francoismichonneau.net/2025/02/air-with-emacs-ess/


+ PHP
  - phpmd ($ sudo aura -As phpmd)
  - phpcf ($ wget http://pear.php.net/go-pear.phar && php go-pear.phar && pear install PHP_CodeSniffer-3.3.2)

+ Database Viewer: edbi
  - perl-CPAN
  - and cpan modules:
     - RPC::EPC::Service
     - DBI
     - DBI driver and (using DB depending on):
          - DBD::SQLite        ( SQLite )
          - DBD::Pg            ( Postgresql )
          - DBD::mysql         ( MySQL )
  - therefore: cpan -fi RPC::EPC::Service DBI DBD::SQLite DBD::Pg DBD::mysql
  - connection parameters for edbi:
     sqlite : dbi:SQLite:dbname=/path/to/database.sqlite
     postgresql : dbi:Pg:dbname=mydb
     mysql : dbi:mysql:mydb
  - more information: https://github.com/kiwanami/emacs-edbi

+ mpc (Music client for mpd)
  - mpd of course

If you got any questions, don't hesitate to contact me at "manuel.schneckiXYZgmail.com[@/XYZ]".


How is this package built up?
=============================

    .emacs.d
        README.md               This file.
        snippets                Snippets folder.
            ...                 Folders for different modes (programming languages).
        .tmp                    Backup and flymake (for Java) files.
            ...
        init.el                 The start point of the config. Sets package list.
        gnus.el                 Configuration file for news and mail-client named Gnus.
        24                      or any other emacs version
            emacs.el            The start point inside of this folder, loads following:
            basics.el           Some basic functions and settings (mostly for built in tools).
            basic_keys.el       Basic key sequences (mostly for built in functions).
            package_configs     Contains configuration files for packages (loaded by emacs.el).
               ...              Check it out!
            packages            All additional packages (not available from Pamela).
               ...              Check it out!
            language_configs    Own configuration for each (programming) language.
               ...              Check it out!


OK, when starting up Emacs following chain is used for loading the
configuration files: (Emacs automatically starts ~/.emacs.d/init.el)


    init.el    ->    24/emacs.el
     \                \
      \ settings.el    \ basics.el
                        \ 24/package_config/*.el    ->     24/packages/*
                         \ basic_keys.el
                          \ language_configs/*.el


This means init.el is started and load settings.el, afterwards it
loads 24/emacs.el. This file then loads basics.el, the package
configurations, the basic keys and finally the language configuration
files.


I got some Problems...
======================

Well, if you got a problem with one package. Then you go to
24/emacs.el and disable the package before you try to find out what
caused the problem.


If you dig a little bit around in the config files you will be able to
find out quite a lot.


Interesting to Know
===================


 - Automatic Tag generation:

   Tags file are created automatically and set. Configured is this
   behavior in each language configuration file. It looks for a folder
   named "src" and places the TAGS file right above it. This means if
   you got a project folder that looks like this:

    + ProjectFolder
       + src
          - ...    (Your source code.)
       - ...       (then a TAGS file will be placed right here)
       - TAGS

   However, there is one exception: If you edit .el files, the TAGS
   file is placed in ~./emacs.d/TAGS.

 - Have a look at my Makefiles: github.com/schnecki

   They work quite well with the configuration.

 - There is a Firefox plugin for Emacs users:

   https://github.com/mooz/keysnail/wiki

   Furthermore, you might want to install some plugins:
   https://github.com/mooz/keysnail/wiki/plugin
