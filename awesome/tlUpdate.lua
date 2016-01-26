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
  --print("Ran update!")
  local theme = beautiful.get()
  for i, o in ipairs(objects) do
    local cache = data[o]
    local ib, tb, bgb, bgbs, bgbl, m, mt, ml, sb, sbl, l, ls, ll
    if cache then
      ib = cache.ib
      tb = cache.tb
      bgb = cache.bgb
      bgbs = cache.bgbs -- seperator background
      bgbl = cache.bgbl
      m = cache.m
      mt = cache.mt -- extra margin
      ml = cache.ml
      sb = cache.sb -- seperator
      sbl = cache.sbl
    else
      ib = wibox.widget.imagebox()
      tb = wibox.widget.textbox()
      sb = wibox.widget.textbox() -- seperator
      sbl = wibox.widget.textbox() -- left seperator for first tag
      bgbl = wibox.widget.background() -- left seperator background
      bgb = wibox.widget.background()
      bgbs = wibox.widget.background()
      m = wibox.layout.margin(tb, 0, 0)
      mt = wibox.layout.margin(sb, 0, 0)
      ml = wibox.layout.margin(sbl, 0, 0)
      l = wibox.layout.fixed.horizontal()
      ls = wibox.layout.fixed.horizontal()
      ll = wibox.layout.fixed.horizontal()

      l:fill_space(true)
      l:add(ib)
      l:add(m)
      ls:fill_space(true)
      ls:add(mt)
      ll:fill_space(true)
      ll:add(ml)

      bgb:set_widget(l)
      bgbs:set_widget(ls)
      bgbl:set_widget(ll)

      bgb:buttons(common.create_buttons(buttons, o))
      bgbs:buttons(common.create_buttons(buttons, o))
      bgbl:buttons(common.create_buttons(buttons, o))


      data[o] = {
        ib = ib,
        tb = tb,
        bgbl = bgbl,
        bgb = bgb,
        bgbs = bgbs,
        m = m,
        mt = mt,
        ml = ml,
        sb = sb,
        sbl = sbl
      }
    end

    local text, bg, bg_image, icon = label(o)
    local bgl
    if objects[i+1] ~= nil then
      _, bgl, _ = label(objects[i+1])
    end
    if (bg ~= nil and bg ~= theme.bg_normal) then
      sb:set_markup("<span color='" .. bg .. "'>" .. theme.sep_foc .. "</span>")
      if bgl ~= nil then
        bgbs:set_bg(bgl)
      else
        bgbs:set_bg(theme.bg_normal)
      end
    elseif (bgl ~= nil and bgl ~= theme.bg_normal) then
      local bgr = bg or theme.bg_normal
      sb:set_markup("<span color='" .. bgr .. "'>" .. theme.sep_foc .. "</span>")
      bgbs:set_bg(bgl)
    else
      sb:set_markup("<span color='" .. theme.fg_normal .. "'>" .. theme.sep_bak .. "</span>")
      bgbs:set_bg(theme.bg_normal)
    end

    if i == 1 then
      if (bg ~= nil and bg ~= theme.bg_normal) then
        sbl:set_markup("<span color='" .. theme.bg_normal .. "'>" .. theme.sep_foc .. "</span>")
        bgbl:set_bg(bg)
      else
        sbl:set_markup("<span color='" .. theme.fg_normal .. "'>" .. theme.sep_bak .. "</span>")
        bgbl:set_bg(theme.bg_normal)
      end
      w:add(bgbl)
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
