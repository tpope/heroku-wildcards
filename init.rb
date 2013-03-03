require 'heroku/command'

class << Heroku::Command

  alias boring_old_wildcard_free_run run
  def run(cmd, original_args=[])
    option = '--app'
    pattern = ENV['HEROKU_APP']
    args = original_args.dup
    args.each_with_index do |arg, i|
      case arg
      when '--'
        break
      when /^-(?:a|-app=)(.*)$/
        pattern = $1
        args.delete_at(i)
        break
      when /^-(?:a|-app)$/
        pattern = args.delete_at(i+1)
        args.delete_at(i)
        break
      when /^-(?:r|-remote=)(.*)$/
        pattern = $1
        args.delete_at(i)
        option = '--remote'
        break
      when /^-(?:r|-remote)$/
        pattern = args.delete_at(i+1)
        args.delete_at(i)
        option = '--remote'
        break
      end
    end

    if !pattern
      option = '--remote'
      pattern = git("config heroku.remote")[/.+/]
    end

    if pattern.to_s.include?('*') || pattern.to_s.include?(',')
      found = false
      if option == '--remote'
        Heroku::Command::Base.allocate.send(:git_remotes).to_a
      else
        Heroku::Auth.api.get_apps.body.map { |a| [a['name'], a['name']] }
      end.each do |candidate, app|
        if pattern.split(',').any? { |glob| File.fnmatch?(glob, candidate) }
          found = true
          if $stdout.tty? && ENV['TERM'] != 'dumb'
            display("\e[01m# #{app}\e[00m")
          else
            display("# #{app}")
          end
          system($0, cmd, option, candidate, *args)
        end
      end
      unless found
        error("You do not have access to any apps matching #{pattern}.")
      end
    else
      boring_old_wildcard_free_run(cmd, original_args)
    end
  end

end
