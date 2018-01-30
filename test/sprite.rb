require 'ruby2d'

set title: "Ruby 2D — Sprite", width: 320, height: 240


coin = Sprite.new(
  "coin.png",
  clip_width: 84,
  time: 300,
  loop: true
)


on :key_down do |e|
  close if e.key == 'escape'

  if e.key == 'space'
    coin.play
    coin.update
  end
end


show
