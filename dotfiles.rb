module Dotfiles

  def files
    Dir['./dotfiles/*'].map {|file|  file }
  end

  def parsed_files
    files.map {|file| file.split('/').last }
  end

  def dotfiles_dialogue
    puts 'Would you like to install the .dotfiles? (y/N)'
    print '>> '
    gets.chomp.downcase
  end

  def prompt_for_dotfiles
    response = dotfiles_dialogue
    symlink_files if response.eql?('y')
  end
end
