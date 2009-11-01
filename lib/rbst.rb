require 'open4'

class RbST

  def self.convert(*args)
    new(*args).convert
  end

  def initialize(*args)
    target = args.shift
    @target  = File.exists?(target) ? File.read(target) : target rescue target
    @options = args
  end

  def convert
    executable = File.join(File.dirname(__FILE__), 'rest2parts.py')
    execute "python #{executable}" + convert_options
  end
  alias_method :to_s, :convert
  
  def to_html
    @options << {:writer_name => :html}
    convert
  end
  
private

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
          s + (flag.to_s.length == 1 ? " -#{flag} #{val}" : " --#{flag}=#{val}")
        end
      else
        opt.to_s.length == 1 ? " -#{opt}" : " --#{opt}"
      end
    end
  end
end