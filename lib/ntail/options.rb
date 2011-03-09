module NginxTail
  module Options

    def parse_options(argv, defaults = {})
      
      options = OpenStruct.new(defaults)

      OptionParser.new do |opts|

        opts.banner = "Usage: ntail {options} {file(s)}"
        opts.separator ""
        opts.separator "Options are ..."

        opts.on '--verbose', '-v', "Run verbosely (log messages to STDERR)." do |value|
          options.verbose = true
        end

        opts.on '--filter',  '-f CODE', "Ruby code block for filtering (parsed) lines - needs to return true or false." do |value|
          options.filter = eval "Proc.new #{value}"
        end

        opts.on '--execute',  '-e CODE', "Ruby code block for processing each (parsed) line." do |value|
          options.code = eval "Proc.new #{value}"
        end

        opts.on '--line-number', '-l LINE_NUMBER', "Only process the line with the given line number" do |value|
          options.line_number = value.to_i
        end

        opts.on '--dry-run', '-n', "Dry-run: process files, but don't actually parse the lines" do |value|
          options.dry_run = true
        end

        opts.on '--parse-only', '-p', "Parse only: parse all lines, but don't actually process them" do |value|
          options.parse_only = true
        end

        opts.on '--version', '-V', "Display the program version." do |value|
          puts "#{NTAIL_NAME}, version #{NTAIL_VERSION}"
          options.running = false
        end

        opts.on_tail("-h", "--help", "-H", "Display this help message.") do
          puts opts
          options.running = false
        end

      end.parse!(argv)

      return options

    end

  end # module Options
end # module NginxTail