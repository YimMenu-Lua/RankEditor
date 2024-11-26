local rank_editor_tab = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Rank Editor")

local rank_input       = 1
local lscm_tier_input  = 1
local arena_tier_input = 1

rank_editor_tab:add_imgui(function()
    rank_input = ImGui.InputInt("Rank", rank_input)
    rank_input = math.min(math.max(rank_input, 1), 8000)
    
    if ImGui.Button("Set Rank") then
        script.run_in_fiber(function()
            local rp_value = scr_function.call_script_function("freemode", "GTRV", "2D 01 05 00 00 38 00 25 64", "int", {
                { "int", rank_input }
            })
            stats.set_int("MPPLY_GLOBALXP", rp_value)
            stats.set_int("MPX_CHAR_XP_FM", rp_value)
            stats.set_int("MPX_CHAR_SET_RP_GIFT_ADMIN", rp_value)
        end)
    end

    lscm_tier_input = ImGui.InputInt("LSCM Tier", lscm_tier_input)
    lscm_tier_input = math.min(math.max(lscm_tier_input, 1), 1000)
    
    if ImGui.Button("Set LSCM Tier") then
        script.run_in_fiber(function()
            local rep_value = scr_function.call_script_function("freemode", "GCCRTFT", "2D 01 03 00 00 38 00 72 5C 07 00 71 2E 01 01 55 1E", "int", {
                { "int", lscm_tier_input }
            })
            stats.set_int("MPX_CAR_CLUB_REP", rep_value)
            scr_function.call_script_function("freemode", "UCCRR", "2D 02 07 00 00 38 00 3D 01", "void", {
                { "int", globals.get_int(1964471 + 8 + 2) },
                { "int", lscm_tier_input }
            })
        end)
    end

    arena_tier_input = ImGui.InputInt("Arena War Tier", arena_tier_input)
    arena_tier_input = math.min(math.max(arena_tier_input, 1), 2147483647)
    
    if ImGui.Button("Set Arena War Tier") then
        script.run_in_fiber(function()
            stats.set_int("MPX_ARENAWARS_AP_TIER", arena_tier_input)
            -- TO-DO: Unlock tier rewards using function 2D 04 09 00 00 38 01 74
        end)
    end
end)