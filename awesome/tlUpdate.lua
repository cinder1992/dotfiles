-- Custom Taglist update function
-- author: Cinder1992
local math = math
local type = type
local ipairs = ipairs
local pairs = pairs
local pcall = pcall
local setmetatable = setmetatable
local capi = { button = button }
local awful = require("awful")
local util = require("awful.util")
local wibox = require("wibox")
local imagebox = require("wibox.widget.imagebox")
local textbox = require("wibox.widget.textbox")
local common = require("awful.widget.common")
local beautiful = require("beautiful")

function updateTaglist(w, buttons, label, data, objects)
  -- code borrowed from common.list_update, modified to add an extra text seperator
  w:reset()
  local theme = beautiful.get()
  for i, o in ipairs(objects) do
    local cache = data[o]
    local ib, tb, bgb, bgbs, ls, m, l, mt, sb
    if cache then
      ib = cache.ib
      tb = cache.tb
      bgb = cache.bgb
      bgbs = cache.bgbs -- seperator background
      m = cache.m
      mt = cache.mt -- extra margin
      sb = cache.sb -- seperator
    else
      ib = wibox.widget.imagebox()
      tb = wibox.widget.textbox()
      sb = wibox.widget.textbox() -- seperator
      bgb = wibox.widget.background()
      bgbs = wibox.widget.background()
      m = wibox.layout.margin(tb, 0, 0)
      mt = wibox.layout.margin(sb, 0, 0)
      l = wibox.layout.fixed.horizontal()
      ls = wibox.layout.fixed.horizontal()

      l:fill_space(true)
      l:add(ib)
      l:add(m)
      ls:fill_space(true)
      ls:add(mt)

      bgb:set_widget(l)
      bgbs:set_widget(ls)

      bgb:buttons(common.create_buttons(buttons, o))
      bgbs:buttons(common.create_buttons(buttons, o))


      data[o] = {
        ib = ib,
        tb = tb,
        bgb = bgb,
        bgbs = bgbs,
        m = m,
        mt = mt,
        sb = sb,
      }
    end
    local text, bg, bg_image, icon = label(o)
    local bgl
    if objects[i+1] ~= nil then
      _, bgl, _ = label(objects[i+1])
    end
    if bg ~= nil then
      sb:set_markup("<span color='" .. bg .. "'>" .. theme.sep_foc .. "</span>")
      if bgl ~= nil then
        bgbs:set_bg(bgl)
      else
        bgbs:set_bg(theme.bg_normal)
      end
    elseif bgl ~= nil then
      local bgr = bg or theme.bg_normal
      sb:set_markup("<span color='" .. bgr .. "'>" .. theme.sep_foc .. "</span>")
      bgbs:set_bg(bgl)
    else
      sb:set_markup("<span color='" .. theme.fg_normal .. "'>" .. theme.sep_bak .. "</span>")
      bgbs:set_bg(theme.bg_normal)
    end

    if not pcall(tb.set_markup, tb, text) then
      tb:set_markup("<i>&lt;Invalid text&gt;</i>")
    end
    bgb:set_bg(bg)
    if type(bg_image) == "function" then
      bg_image = bg_image(tb, o, m, objects, i)
    end
    bgb:set_bgimage(bg_image)
    ib:set_image(icon)
    w:add(bgb)
    w:add(bgbs)
  end
end
