# sprite.rb

module Ruby2D
  class Sprite
    include Renderable

    attr_accessor :x, :y, :width, :height,
                  :clip_x, :clip_y, :clip_width, :clip_height, :data

    def initialize(path, opts = {})

      unless RUBY_ENGINE == 'opal'
        unless File.exists? path
          raise Error, "Cannot find sprite image file `#{path}`"
        end
      end

      @path = path
      @x = opts[:x] || 0
      @y = opts[:y] || 0
      @z = opts[:z] || 0
      # @width  = opts[:width]  || nil
      # @height = opts[:height] || nil
      @image_width  = 504
      @image_height = 84

      @clip_x = 0
      @clip_y = 0
      @clip_width  = opts[:clip_width] || nil
      @clip_height = @image_height

      @time = opts[:time] || nil
      @loop = opts[:loop] || false

      @animations = {}
      @playing = false
      @current_frame = 0

      ext_init(@path)
      add
    end

    def play
      @playing = true
    end

    def update
      if @clip_x >= (@image_width - @clip_width)
        puts "@clip_x >="
        @clip_x = 0
      else
        @clip_x = @clip_x + @clip_width
      end
      puts "@clip_x: #{@clip_x}"
    end

    private

  end
end
