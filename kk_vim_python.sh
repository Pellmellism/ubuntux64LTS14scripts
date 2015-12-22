
#TODO: virtual env setup, etc

cp conf_files/DOTpythonrc ~/.pythonrc
cp conf_files/DOTvimrc ~/.vimrc

echo 'export PYTHONSTARTUP=~/.pythonrc\n' >>>~/.bashrc

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
