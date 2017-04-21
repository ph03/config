# theme-bobthefish
set -g theme_nerd_fonts yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_date no

set -g theme_color_scheme user

set -g __color_initial_segment_exit  ffffff ce000f --bold
set -g __color_initial_segment_su    ffffff 189303 --bold
set -g __color_initial_segment_jobs  ffffff 255e87 --bold

set -g __color_path                  333333 999999
set -g __color_path_basename         333333 ffffff --bold
set -g __color_path_nowrite          660000 cc9999
set -g __color_path_nowrite_basename 660000 cc9999 --bold

set -g __color_repo                  189303 3a2a03
set -g __color_repo_work_tree        189303 3a2a03 --bold
set -g __color_repo_dirty            ce000f 3a2a03
set -g __color_repo_staged           f6b117 3a2a03

set -g __color_vi_mode_default       999999 333333 --bold
set -g __color_vi_mode_insert        189303 333333 --bold
set -g __color_vi_mode_visual        f6b117 3a2a03 --bold

set -g __color_vagrant               48b4fb ffffff --bold
set -g __color_username              cccccc 255e87
set -g __color_rvm                   af0000 cccccc --bold
set -g __color_virtualfish           005faf cccccc --bold
