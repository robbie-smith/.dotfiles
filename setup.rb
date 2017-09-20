require './dotfiles.rb'

class Setup
  include Dotfiles

  def initialize
    install_dependencies
    prompt_for_neovim
    prompt_for_dotfiles
    goodbye
  end

  def install_dependencies
    `cd ~`
    install_home_brew
    install_commandline_tools
    install_fzf
    install_ripgrep
    install_rbenv
    install_pgcli
    install_postgresql
    install_git
    install_python
  end

  def install_home_brew
    `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  end

  def install_commandline_tools
    `xcode-select --install`
  end

  def install_python
    `brew install python`
    `brew install python3`
  end

  def install_git
    `brew install git`
  end

  def install_fzf
    `brew install fzf`
    #Install shell extensions
    `/usr/local/opt/fzf/install`
  end

  def install_ripgrep
   `brew install ripgrep`
  end

  def install_rbenv
    `brew install rbenv`
    `rbenv init`
  end

  def install_pgcli
    `brew tap-pin dbcli/tap`
    `brew install pgcli`
  end

  def install_postgresql
    `brew install postgresql`
  end

  def symlink_files
    parsed_files.each { |file| `ln -s ~/.dotfiles/dotfiles/#{file} ~/.#{file}` }
  end

  def symlink_colors_for_neovim
    `ln -s ~/.dotfiles/neovim/colors ~/.config/nvim/colors`
  end

  def symlink_init_for_neovim
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

  def goodbye
    puts "Don't half ass two things, whole ass one thing. - R. Swanson"
  end
end

Setup.new
