# Add coreutils to path if it exists
set gnubin /usr/local/opt/coreutils/libexec/gnubin
if test -d $gnubin
  set -g PATH $gnubin $PATH
end

set -g PATH "/usr/local/opt/mozjpeg/bin" $PATH

set -g fish_user_paths "/usr/local/opt/libxml2/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/libxml2/lib"
set -gx CPPFLAGS "-I/usr/local/opt/libxml2/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/libxml2/lib/pkgconfig"
