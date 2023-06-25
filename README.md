# vs-overlay

A collection of packages (mostly plugins) related to using VapourSynth with Nix.

Fork of https://github.com/tadeokondrak/vs-overlay

I made this for personal use and basically only fix/commit sth when I use vapoursynth and it breaks for me or I need a new plugin.
But feel free to open issues when sth breaks (updated nixpkgs broke things often in the past) I will try to fix it.


# Notable stuff of this fork
- pinned vapoursynth
- Alot more (uptodate) plugins and tools
- vspreview: vspreview.withPlugins
- MPV with vapoursynth support: mpv_vs_wrapped plugin_list
- python stubs for vapoursynth plugins: generate_vapoursynth_stubs plugin_list
- Buildtime check for binary vapoursynth plugins, if they load
