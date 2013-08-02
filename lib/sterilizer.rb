require "sterilizer/version"
require "rchardet19"

module Sterilizer
  def sterilize!

    return self unless !!defined?(Encoding)
    # return if encoding is valid and equal to default_internal
    return self if valid_when_default?

    # force to default encoding if valid when forced
    return self.force_encoding(Encoding.default_internal) if valid_when_forced?

    # At this point, we know the string is not valid encoding, it the encoding is UTF-8,
    # we must try a different encoding that is valid before forcefully encoding to UTF-8
    # Otherwise, the encoding type is non-default. If it is valid, encode it to UTF-8, otherwise
    # find an alternative before forcefully encoding to UTF-8
    if encoding_is_default?
      # Might have a situation where encoding is the same as default, but it's not valid
      # Force it to something else so we can String#encode
      non_default_encoding = find_a_valid_encoding
      force_encoding_with(non_default_encoding)
    else
      if valid_when_forced?(self.encoding)
        self.encode!(Encoding.default_internal, self.encoding, { :undef => :replace, :invalid => :replace})
      else
        alternative_encoding = find_a_valid_encoding(self.encoding)
        force_encoding_with(alternative_encoding)
      end
    end
  rescue
    self.force_encoding_with("ASCII")
  end

  def encoding_is_default?
    self.encoding == Encoding.default_internal
  end

  def valid_when_default?
    self.valid_encoding? && encoding_is_default?
  end

  def valid_when_forced?(encoding = Encoding.default_internal)
    self.dup.force_encoding(encoding).valid_encoding?
  end

  def find_a_valid_encoding(ignoring = [Encoding.default_internal], guessed_already = false)
    # If we've already tried to guess the encoding, resort to picking one at random until valid
    if guessed_already
      provisional_encoding = Encoding.list.detect{ |encoding| !ignoring.include?(encoding) }
    else # On first run, we'll try and guess the character encoding
      provisional_encoding = guess_encoding
    end

    # If the provisional encoding is valid when string is forced to it, select it otherwise continue to find one
    if valid_when_forced?(provisional_encoding)
      provisional_encoding
    else
      find_a_valid_encoding(ignoring << provisional_encoding, :guess_failed)
    end
  end

  # Use an external library to attempt to (silently) guess the encoding
  def guess_encoding(guesser = CharDet)
    Encoding.find(guesser.detect(self, :silent => true)["encoding"])
  end

  def force_encoding_with(encoding)
    self.force_encoding(encoding).encode(Encoding.default_internal, :invalid => :replace, :undef => :replace)
  end

end

# Add sterilize methods to a string if it is sterilized, saves clobbering every string!
class String
  def sterilize!
    self.extend(Sterilizer).sterilize!
  end
end