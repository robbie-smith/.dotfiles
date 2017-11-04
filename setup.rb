require './dotfiles.rb'

class Setup
  include Dotfiles

  def initialize
    prompt_for_neovim
    prompt_for_dotfiles
    rbenv_rehash
    install_pip_gems_for_neovim
    install_powerline_fonts
    goodbye
  end

  def symlink_bash_profile
    `ln -s ~/.dotfiles/bash/bash_profile.sh ~/.bash_profile`
  end

  def rbenv_rehash
    `rbenv rehash`
  end

  def install_pip_gems_for_neovim
    puts "Installing pip2 for neovim..."
    `pip2 install neovim`
    puts "Installing pip3 for neovim..."
    `pip3 install neovim`
    puts "Installing ruby gem for neovim..."
    `sudo gem install neovim`
  end

  def symlink_pgclirc
    `ln -s ~/.dotfiles/dotfiles/config ~/.config/pgcli/config`
  end

  def symlink_files
    parsed_files.each { |file| `ln -s ~/.dotfiles/dotfiles/#{file} ~/.#{file}` }
    symlink_bash_profile
    symlink_pgclirc
  end

  def symlink_colors_for_neovim
    `rm -rf /usr/local/Cellar/neovim/0.2.0_1/share/nvim/runtime/colors`
    `ln -s ~/.dotfiles/neovim/colors /usr/local/Cellar/neovim/0.2.0_1/share/nvim/runtime/colors`
  end

  def symlink_init_for_neovim
    `mkdir ~/.config/`
    `mkdir ~/.config/nvim/`
    `ln -s ~/.dotfiles/neovim/init.vim ~/.config/nvim/init.vim`
  end

  def prompt_for_neovim
    response = neovim_dialogue
    symlink_init_for_neovim if response.eql?('y')
  end

  def neovim_dialogue
    puts 'Would you like to install the neovim init file? (y/N)'
    print '>> '
    gets.chomp.downcase
  end

  def install_powerline_fonts
    `git clone https://github.com/powerline/fonts.git --depth=1`
    `cd fonts`
    `./install.sh`
    `cd .. && rm -rf fonts`
  end

  def goodbye
    puts "Don't half ass two things, whole ass one thing. - R. Swanson"
  end
end

Setup.new
