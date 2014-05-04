emacs.d
======

My .emacs.d settings & setup for Scala & Haskell with Dirtree for ease of navigation.
Props to the following repos& People:
* http://tim.dysinger.net/posts/2014-02-18-haskell-with-emacs.html
* https://github.com/rtircher/dirtree
* https://github.com/hvesalai/scala-mode2
* https://github.com/aemoncannon/ensime

## Setup
This assumes you are in your home directory and have no previous emacs settings (clean install of emacs & haskell-platform):
    
    git clone https://github.com/wfaler/.emacs.d.git
    git clone -b haskell --depth=1 git://github.com/dysinger/el-get ~/.emacs.d/el-get-haskell
    cabal update
    cabal install cabal-install
    #add ~/.cabal/bin to your $PATH variable
    . ~/.profile
    cabal install happy 
    cabal install alex
    cabal install ghci-ng 
    cabal install ghc-mod 
    cabal install structured-haskell-mode 
    cabal install stylish-haskell
    
Now start emacs and be patient with emacs downloading all the pre-requisite emacs packages!
Once done, you will have various Haskell goodies, scala-mode2 & ensime setup for emacs.
If you want to comment in the commented out parts of the init.el, do the following in emacs (for javascript dev and nice looking solarized theme):

    #install node and npm on your platform
    # install jslint on your platform by doing "npm install jslint" 
    package-install solarized-theme
    el-get-install js2-mode
    el-get-install flymake-jslint
    el-get-install flycheck
