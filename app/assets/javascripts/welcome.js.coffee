# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

canvas = ->
  document.getElementById('screen');

get_ctx = ->
  ctx = canvas().getContext('2d')

clear_screen = ->
  ctx = get_ctx()
  ctx.clearRect(0, 0, 800, 400)
  return

is_sleepy = ->
  return time > 30

count_time = ->
  dt = Interval * 0.001
  time += dt
  unless is_sleepy()
    setTimeout count_time, Interval

class CharacterImage
  constructor: (n, x, y) ->
    @n = n ? 0
    @x = x ? 0
    @y = y ? 0
    @scale = 2.5
    @anm_ct = 0
    @is_loaded = false
    @img = new Image()
    @img.src = "http://dgames.jp/misc/images/$Actor#{@n}.png?" + new Date().getTime()
    #@img.src = "http://dgames.jp/misc/images/Actor#{@n}.png?" + new Date().getTime()
    @img.onload = ->
      @is_loaded = true

  update: (dt) ->
    @anm_ct += 1
    @anm_ct %= 4

  render: ->
    ctx = get_ctx()
    w = 32 * 1
    h = 32 * 1
    ctx.drawImage(@img, w * [0, 1, 2, 1][@anm_ct], h * 1, w, h, @x, @y, w * @scale, h * @scale)

Interval = 120
time = 0
characters = []
for i in [0..8]
  characters.push new CharacterImage(i + 4, i * 72, Math.random() * 200 - 32)


main_loop = ->
  clear_screen()
  for c in characters
    c.update()
    c.render()
  unless is_sleepy()
    setTimeout main_loop, Interval

@start_main = ->
  #target = canvas();
  #target.onmousemove = (e) ->
  #  balls[0].x = e.layerX
  #  balls[0].y = e.layerY
  #  balls[0].mv.active = true
  count_time()
  main_loop()
