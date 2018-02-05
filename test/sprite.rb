require 'ruby2d'

set title: "Ruby 2D — Sprite", width: 500, height: 400


coin = Sprite.new(
  "coin.png",
  clip_width: 84,
  time: 300,
  loop: true
)

coin.play


boom = Sprite.new(
  "boom.png",
  x: 100,
  clip_width: 127,
  time: 75
)


on :key_down do |e|
  close if e.key == 'escape'

  case e.key
  when 'p'
    coin.play
    boom.play
  when 's'
    coin.stop
  end
end


show
