work=$PWD

cd ~
echo "TODO make an interactive menu here"
echo "cloning bash-git-prompt"
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
echo "Cloned and installed!"

unlink .bashrc
unlink .git-prompt.sh
unlink .clarinet.bash
unlink .config/nvim
unlink .config/tmux

ln -s $work/bashrc .bashrc
ln -s $work/git-prompt.sh .git-prompt.sh
ln -s $work/clarinet.bash .clarinet.bash
ln -s $work/config/nvim/ .config/nvim
ln -s $work/config/tmux .config/tmux

echo 'Listo!'
