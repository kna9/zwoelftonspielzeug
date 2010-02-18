# encoding: UTF-8

require 'test/unit'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'hauer/utils'

class TestUtils < Test::Unit::TestCase
  def test_note2midi
    klaviatur = [%w(c), %w(cis des),  %w(d), %w(dis es), %w(e fes), %w(eis f), %w(fis ges), %w(g), %w(gis as), %w(a), %w(ais b), %w(h ces)]
    klaviatur.each_with_index { |namen, midi|
      namen.each { |note| assert_equal(midi, Hauer::Utils.note2midi(note)) }      
    }    
  end
  
  def test_note2midi_2
    midis = %w(c fis ges a h).map{|n| Hauer::Utils.note2midi(n) }
    assert_equal([0, 6, 6, 9, 11], midis)
  end
end
