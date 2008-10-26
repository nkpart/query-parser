module QP
  class QueryParser
    SINGLE = "\\\'[\\w|\\s]+\\\'"
    DOUBLE = "\\\"[\\w|\\s]+\\\""
    WORD = "\\w+"
    TOKEN_RE = "(#{WORD}|#{SINGLE}|#{DOUBLE})"
    ASSOC_RE = "(#{WORD}):#{TOKEN_RE}"
    THE_RE = Regexp.new("(#{ASSOC_RE}|#{TOKEN_RE})") 
    
    def parse string
      # There must be a better way
      tokens = []
      assocs = []
      string.scan(THE_RE) do |grp|
        tokens << unquote(grp.last) unless grp.last.nil?
        assocs << [grp[1], unquote(grp[2])] unless !grp[1..2].all?
      end
      return [tokens, assocs]
    end
    
    def unquote str
      str.gsub(/\'|\"/, '')
    end
  end
end