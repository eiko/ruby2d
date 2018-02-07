require 'ruby2d'

set title: "Ruby 2D — Sprite", width: 425, height: 150


coin = Sprite.new(
  "coin.png",
  clip_width: 84,
  time: 300,
  loop: true
)
coin.play

boom = Sprite.new(
  "boom.png",
  x: 109,
  clip_width: 127,
  time: 75
)

hero = Sprite.new(
  "hero.png",
  x: 261,
  clip_width: 78,
  time: 250,
  animations: {
    walk: 1..2,
    climb: 3..4,
    cheer: 5..6
  }
)

on :key_down do |e|
  close if e.key == 'escape'

  case e.key
  when 'p'
    coin.play
    boom.play
  when 's'
    coin.stop
    hero.stop
  when 'right'
    hero.play :walk, :loop
  when 'up'
    hero.play :climb, :loop
  when 'down'
    hero.play :cheer
  end
end


show
