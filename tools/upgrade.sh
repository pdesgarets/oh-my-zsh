# Use colors, but only if connected to a terminal, and that terminal
# supports them.
tput=$(which tput)
if [ -n "$tput" ]; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi
function update {
if git pull origin master && git pull --rebase --stat upstream master && git push origin master --force
then
        printf '%s' "$GREEN"
        printf '%s\n' '         __                                     __   '
        printf '%s\n' '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
        printf '%s\n' ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
        printf '%s\n' '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
        printf '%s\n' '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
        printf '%s\n' '                        /____/                       '
        printf "${BLUE}%s\n" "Hooray! Oh My Zsh has been updated and/or is at the current version."
        printf "${BLUE}${BOLD}%s${NORMAL}\n" "To keep up on the latest news and updates, follow us on twitter: https://twitter.com/ohmyzsh"
        printf "${BLUE}${BOLD}%s${NORMAL}\n" "Get your Oh My Zsh swag at:  http://shop.planetargon.com/"
else
        printf "${RED}%s${NORMAL}\n" 'There was an error updating. Try again later?'
fi
}

printf "${BLUE}%s${NORMAL}\n" "Upgrading Oh My Zsh"
cd "$ZSH"
if git remote show upstream
        then update
else
        git remote add upstream https://github.com/robbyrussell/oh-my-zsh.git
        git fetch upstream
        git checkout master
        update
fi

