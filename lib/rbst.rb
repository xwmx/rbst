require 'open4'

class RbST
  
  def self.convert(*args)
    new(*args).convert
  end
  
  def self.latex_options
    new.print_options(:latex)
  end
  
  def self.html_options
    new.print_options(:html)
  end

  def initialize(*args)
    target = args.shift
    @target  = File.exists?(target) ? File.read(target) : target rescue target
    @options = args
  end

  def convert(writer = :html)
    execute "python #{RbST.executable(writer)}" + convert_options
  end
  alias_method :to_s, :convert
  
  def to_html
    convert(:html)
  end
  
  def to_latex
    convert(:latex)
  end
  
  def print_options(format)
    help = execute("python #{RbST.executable(format)} --help")
    help.gsub!(/(\-\-)([A-Za-z0-9]+)([=|\s])/, ':\2\3')
    help.gsub!(/(\-\-)([\w|\-]+)(\n)?[^$|^=|\]]?/, '\'\2\'\3')
    help.gsub!(/\=/, ' => ')
    help.gsub!(/([^\w])\-(\w)([^\w])/, '\1:\2\1')
    help.gsub!(/(:\w) </, '\1 => <')
    puts help
  end
  
private
  
  def self.executable(writer = :html)
    File.join(File.dirname(__FILE__), "rst2parts", "rst2#{writer}.py")
  end
  
  def execute(command)
    output = ''
    Open4::popen4(command) do |pid, stdin, stdout, stderr| 
      stdin.puts @target 
      stdin.close
      output = stdout.read.strip 
    end
    output
  end

  def convert_options
    @options.inject('') do |string, opt|
      string + if opt.respond_to?(:each_pair)
        opt.inject('') do |s, (flag, val)|
          s + if flag.to_s.length == 1
            " -#{flag} #{val}"
          else
            " --#{flag.to_s.gsub(/_/, '-')}=#{val}"
          end
        end
      else
        opt.to_s.length == 1 ? " -#{opt}" : " --#{opt.to_s.gsub(/_/, '-')}"
      end
    end
  end
end