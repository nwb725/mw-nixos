# ~/.config/fish/functions/fish_prompt.fish
#
# Rust × Helix "One Dark" prompt.
# Everything is muted gray except the git branch, which sits in a
# bright rust-orange block so it's impossible to lose track of.
#
# The ⎇ branch glyph below is plain Unicode and works in any font.
# If you use a Nerd Font you can swap it for the prettier  (\uE0A0).

function fish_prompt
    set -l last_status $status

    # ── Path: muted gray, stays out of the way ──────────────────
    set_color 828997
    echo -n (prompt_pwd)

    # ── Git: the one bright thing on the line ───────────────────
    set -l branch (command git branch --show-current 2>/dev/null)
    if test -z "$branch"
        # detached HEAD → show short SHA instead
        set branch (command git rev-parse --short HEAD 2>/dev/null)
        and set branch "➦ $branch"
    end

    if test -n "$branch"
        # clean ✓ / dirty ✗ (porcelain covers staged, unstaged, untracked)
        set -l mark ' ✓'
        set -l changes (command git status --porcelain 2>/dev/null)
        test -n "$changes"; and set mark ' ✗'

        # ahead ↑ / behind ↓ relative to upstream (skipped if none)
        set -l ab ''
        set -l counts (command git rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null | string split \t)
        if test (count $counts) -eq 2
            test "$counts[1]" -gt 0; and set ab "$ab ↓$counts[1]"
            test "$counts[2]" -gt 0; and set ab "$ab ↑$counts[2]"
        end

        echo -n ' '
        set_color E07B39 # rust text, no background
        echo -n "⎇ $branch$mark$ab"
        set_color normal
    end

    # ── Prompt char: rust, turns red after a failed command ─────
    echo -n ' '
    if test $last_status -eq 0
        set_color E07B39
    else
        set_color e06c75
    end
    echo -n '❯ '
    set_color normal
end
