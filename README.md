# fzf-better-alt-c
A script that simulates fzf alt-c excluding directories from `./.ignore`

there is something different for deifferent shells, so this script is only for zsh. You can modified it since it's so easy to fit yours.

## Intro:

[fzf](https://github.com/junegunn/fzf) uses `find` command to list directories and changes working directory into it.

However, `find` command doesn't have some features like `rg` which reading  ignored files/directories list in `./.ignore`

## Usage:

### bash/zsh

1. Download script `fzf-better-alt-c.sh`

2. Add one line in  `.zshrc` for zsh, `.bashrc` for bash;

   ```shell
   source path_to_script/cddir.sh
   ```

   1. replace `path_to_your_script/cddir` to your own script path;

   2. run `showkey -a` to see the keybinding you want to use to replace `\et`   (`\et`  is <kbd>Alt</kbd>-<kbd>c</kbd>). **notice** that if you want to use <kbd>Alt</kbd>-<kbd>c</kbd> , you possibly need to disable the default `fzf` one.

      `cddir.sh`:

      ```shell
      bindkey '\et' better_alt_c		(zsh)
       bind -x '"\et"':better_alt_c	(bash)
      ```

3. update your shell configuration file

   `source .zshrc` for zsh, `source .bashrc` for bash;



### fish

1. Download script `fzf-better-alt-c.fish` to `~/.config/fish/function/`

2. run `showkey -a` to see the keybinding you want to use to replace `\ea`   (`\ea`  is <kbd>Alt</kbd>-<kbd>a</kbd>).

   add new line in `~/.config/fish/config.fish`

   ```shell
   bind  \ea fzf-better-alt-c
   ```

3. exit to reload fish.

   

## Note

I simply add `*` to the front and end string read from `./.ignore` to form patterns, so it **will not** act like `./.gitignore` or `rg` .

Also, this script only excludes patterns from current directory rather than scanning for `.ignore` for every directory.

More about the default `FZF_ALT_C_COMMAND`  (part of it)

```shell
find -L . -mindepth 1 \( *path(s) here* \) -prune -o -type d -print 2> /dev/null
```

eg:

```shell
find -L . -mindepth 1 \( -path '*/\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \) -prune -o -type d -print 2> /dev/null 
```

This script simply reads patterns from `./.ignore` and makes them like `-path '*pattern*' -o` . Then put them together and insert them into the command.

`find` command options:

```
-L		Follow symbolic links
-mount 	Don't descend directories on other filesystems.
```

note that I added the option `-mount`  **in this script.**

