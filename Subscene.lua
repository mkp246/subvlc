local dialog = nil
local statusBar = nil
local subtitleList = nil
local userInput = {}

local languages = {
  {'alb', 'Albanian', 1},
  {'ara', 'Arabic', 2},
  {'arm', 'Armenian', 73},
  {'baq', 'Basque', 74},
  {'ben', 'Bengali', 54},
  {'bos', 'Bosnian'},
  {'bre', 'Breton'},
  {'bul', 'Bulgarian'},
  {'bur', 'Burmese'},
  {'cat', 'Catalan'},
  {'chi', 'Chinese'},
  {'hrv', 'Croatian'},
  {'cze', 'Czech'},
  {'dan', 'Danish', 10},
  {'dut', 'Dutch', 11},
  {'eng', 'English', 13},
  {'epo', 'Esperanto'},
  {'est', 'Estonian'},
  {'fin', 'Finnish', 17},
  {'fre', 'French'},
  {'glg', 'Galician'},
  {'geo', 'Georgian'},
  {'ger', 'German'},
  {'ell', 'Greek'},
  {'heb', 'Hebrew', 22},
  {'hin', 'Hindi'},
  {'hun', 'Hungarian'},
  {'ice', 'Icelandic'},
  {'ind', 'Indonesian', 44},
  {'ita', 'Italian'},
  {'jpn', 'Japanese'},
  {'kaz', 'Kazakh'},
  {'khm', 'Khmer'},
  {'kor', 'Korean'},
  {'lav', 'Latvian'},
  {'lit', 'Lithuanian'},
  {'ltz', 'Luxembourgish'},
  {'mac', 'Macedonian'},
  {'may', 'Malay', 50},
  {'mal', 'Malayalam'},
  {'mon', 'Mongolian'},
  {'nor', 'Norwegian', 30},
  {'oci', 'Occitan'},
  {'per', 'Persian', 46},
  {'pob', 'Brazilian Portuguese', 4},
  {'pol', 'Polish'},
  {'por', 'Portuguese'},
  {'rum', 'Romanian', 33},
  {'rus', 'Russian'},
  {'scc', 'Serbian'},
  {'sin', 'Sinhalese'},
  {'slo', 'Slovak'},
  {'slv', 'Slovenian'},
  {'spa', 'Spanish', 38},
  {'swa', 'Swahili'},
  {'swe', 'Swedish', 39},
  {'syr', 'Syriac'},
  {'tgl', 'Tagalog'},
  {'tel', 'Telugu'},
  {'tha', 'Thai'},
  {'tur', 'Turkish', 41},
  {'ukr', 'Ukrainian'},
  {'urd', 'Urdu'},
  {'vie', 'Vietnamese', 45}
}

function descriptor()
  return {
    title = "Subscene",
    version = "1.0",
    author = "mkp246",
    capabilities = {"menu"}
  }
end

local app = descriptor()

function activate()
  vlc.msg.dbg("[Subs] welcome")
  showMainDialog()
end

function deactivate()
  if dlg ~= nil then
    dialog:hide()
  end
  dialog = nil
  vlc.msg.dbg("[Subs] bye bye")
  vlc.deactivate()
end

function close()
  deactivate()
end

function menu()
  return {
    "Search",
    "Config",
    "Help"
  }
end

function showMainDialog()
  dialog = vlc.dialog(app.title.." "..app.version)
  
  dialog:add_label("Language:", 1, 1, 1, 1)
  dialog:add_label("Title:", 1, 2, 1, 1)
  dialog:add_label("Season:", 1, 3, 1, 1)
  dialog:add_label("Episode:", 1, 4, 1, 1)
  
  userInput["language"] = dialog:add_dropdown(2, 1, 2, 1)
  userInput["title"] = dialog:add_text_input("", 2, 2, 2, 1)
  userInput["season"] = dialog:add_text_input("", 2, 3, 2, 1)
  userInput["episode"] = dialog:add_text_input("", 2, 4, 2, 1)

  dialog:add_button("Search by hash", dummy, 4, 1, 1, 1)
  dialog:add_button("Search by name", dummy, 4, 2, 1, 1)
  dialog:add_dropdown(4, 3, 1, 1)
  dialog:add_button("Feeling Lucky", dummy, 4, 4, 1, 1)

  subtitleList = dialog:add_list(1, 5, 4, 8)

  statusBar = dialog:add_label(string.rep( "&nbsp;", 125), 1, 13, 4, 1)
  
  dialog:add_button("Help", dummy, 1, 14, 1, 1)
  dialog:add_button("Configuration", dummy, 2, 14, 1, 1)
  dialog:add_button("Download", dummy, 3, 14, 1, 1)
  dialog:add_button("Close", close, 4, 14, 1, 1)
  
  dialog:show()
end

function dummy()
end