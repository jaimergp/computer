# PATH modifications
set -gx PATH ~/.local/bin $PATH

# Anaconda support
. /opt/miniconda/etc/fish/conf.d/conda.fish

# Bob the Fish theme options
# Install with:
#   curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
#   fisher add oh-my-fish/theme-bobthefish
set -g default_user jaime
set -g theme_title_use_abbreviated_path no
set -g fish_prompt_pwd_dir_length 0
set -g theme_display_ruby no
set -g theme_display_virtualenv no
set -g theme_display_hg no
set -g theme_display_k8s_context no
set -g theme_display_docker_machine no
set -g theme_display_vagrant no