require './dotfiles.rb'

class Setup
  include Dotfiles

  def initialize
    prompt_for_neovim
    prompt_for_dotfiles
    set_permissions_for_install_script
    install_powerline_fonts
    goodbye
  end

  def set_permissions_for_install_script
    `chmod +x ~/.dotfiles/install.sh`
  end

  def symlink_bash_profile
    `ln -s ~/.dotfiles/bash/bash_profile.sh ~/.bash_profile`
  end

  def symlink_pgclirc
    `mkdir ./config/pgcli/`
    `ln -s ~/.dotfiles/dotfiles/config ~/.config/pgcli/config`
  end

  def symlink_files
    parsed_files.each { |file| `ln -s ~/.dotfiles/dotfiles/#{file} ~/.#{file}` }
    symlink_bash_profile
    symlink_pgclirc
  end

  def symlink_init_for_neovim
    `rm -rf /usr/local/Cellar/neovim/0.2.0_1/share/nvim/runtime/colors`
    `mkdir ~/.config/`
    `ln -s ~/.dotfiles/nvim ~/.config/`
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

  def prompt_for_powerline
    puts 'Would you like to install powerline fonts? (y/N)'
    print '>> '
    gets.chomp.downcase
  end

  def install_powerline_fonts
    response = prompt_for_powerline
    if response.eql?('y')
      `git clone https://github.com/powerline/fonts.git --depth=1`
      `cd fonts`
      `./install.sh`
      `cd .. && rm -rf fonts`
    end
  end

  def goodbye
    puts "Don't half ass two things, whole ass one thing. - R. Swanson"
  end
end

Setup.new
