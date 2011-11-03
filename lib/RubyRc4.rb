class RubyRc4
  def initialize(str)
    @q1, @q2 = 0, 0
    @key = []
    str.each_byte {|elem| @key << elem} while @key.size < 256
    @key.slice!(256..@key.size-1) if @key.size >= 256
    @s = (0..255).to_a
    j = 0 
    0.upto(255) do |i| 
      j = (j + @s[i] + @key[i] )%256
      @s[i], @s[j] = @s[j], @s[i]
    end    
  end
    
  def encrypt!(text)
    process text
  end  
  
  def encrypt(text)
    process text.dup
  end 
  
  private

  def process(text)
    0.upto(text.length-1) {|i| text[i] = text[i] ^ round}
    text
  end
  
  def round
    @q1 = (@q1 + 1)%256
    @q2 = (@q2 + @s[@q1])%256
    @s[@q1], @s[@q2] = @s[@q2], @s[@q1]
    @s[(@s[@q1]+@s[@q2])%256]  
  end
end
