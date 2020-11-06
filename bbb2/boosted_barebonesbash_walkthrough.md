# Boosted (Bespoke)BareBonesBash(BroughtByBlissfullyBaffledBioinformaticians)

A basic Bash tutorial by [James A. Fellows Yates (@jfy133)](https://github.com/jfy133), [Thiseas C. Lamnidis (@TCLamnidis)](https://github.com/TCLamnidis) and [Aida Andrades Valtueña (@aidaanva)](https://github.com/aidaanva).

<p align="center">
<img title="Source: https://giphy.com/gifs/v58q1se3dZvag" src="https://media.giphy.com/media/3o7TKtVHfLeAWCTuh2/giphy.gif" width="40%"></p>

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><p align="center"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

🛠️ **UNDER CONSTRUCTION!** 🛠️

## Table of contents

<!-- TO INSERT WITH VSCODE -->

## Introduction

The aim of this tutorial is to advance your knowledge gained from [Basic BareBonesBash](https://barebonesbash.github.io/#/bbb1/README). Basic BBB introduced fundamental concepts on how to do basic navigation _[Thiseas still insists on that fancy word...]_, moving and reading files, and generating basic information statistics on these files. In this session, we will focus on more realistic/'useful' scenarios when it comes to the command line. We will be covering ways of speeding up and automating tasks using more 'abstract' but very common computing concepts. However, don't worry! We will be taking it slowly and gently, and of course, full of GIFs!

## tl;dr

If you want to know what you will learn in this tutorial, or are already too scared to read the rest of this tutorial, you can look at this table as a quick reference. To understand actually what each command does, carry on reading below!

| command    | description                                           | example                     | common flags or arguments                                          |
|------------|-------------------------------------------------------|-----------------------------|--------------------------------------------------------------------|
| `find`     | search for files or directories                       | `find -name 'pen'`          | -type f (search only for files)<br> -name '*JPG' (search for file names matching the pattern)         | 
| `"$var"`   | use double quotes to use contents of variable         | `pen=apple && echo "$pen"` |                                                                    |
| `rev`      | reverse the order of characters in a string               | `rev 'pineapple'`           |                                                                    |
| `cut`      | separate each line of a file into multiple pieces        | `cut -f ' ' -d`             | -f(ield, i.e piece to keep), -d(elimiter, which char. to split by) |
| `$()` | runs the command in parentheses and interprets its output as a string | `num_lines=$(wc -l my_file.txt | cut -f 1)` |
`${var}` | parameter expansion of variables | `echo ${pen#app}`<br>`echo ${pen%le}`<br>`echo ${pen/le/lication}` | `#`/`##` removes charcters from the start of the variable<br>`%`/`%%` removes characters from the end of a variable <br>`/X/Y` substitute string "X" in the variable for "Y". If Y is omitted, removes string X
`${#var}` | get the length of the contents of a variable | `echo ${#pen}` |
`rename` | apply a regex to the name of files to rename them | `rename 's/\.JPG$/.jpg/' *` | 
`<`<br>`>`<br>`2>` | redirects the standard input/output/error stream respectively into a file | `cat <file.txt >file_copy.txt 2>cat_file.err` |
`basename` |  gives you the file name, removing the path | `basename /path/to/my/file.txt` | 
`dirname` | gives you the path to a file, removing the filename | `dirname /path/to/my/file.txt` | 
`while` | begins 'while' loop, requires a condition, 'do' and 'done' | `while [[ "${pen}" == "apple" ]]; do echo "penpineapple${pen}pen"` | 
`[[`<br>`((` | conditions of conditionals. <br> `!` is a NOT<br>`||` is an OR <br> `&&` is an AND | `[[ ${pen} == "apple" ]]` <br> `(( 7 - 3 == 4 ))` | `-f` check if file exists <br> `-n` check if variable is set
`read` | takes the contents of the file and loads them into a specified variable. Often used with _while_ loops. | `while read line; do echo ${line}; done <file.txt`
`paste` | Pastes lines of multiple files side-by-side | `paste file1.txt file2.txt`| `-` can be used to refer to `stdin` 
`sed` | edits the contents of a file on the fly | `sed 's/A/dog/' Annotations.txt` | -e(xpression) can be provided multiple times to specify multiple expressions. <br> -i(n place)
`if` | begins conditional. Requires a condition, `then` and ends with `fi` | `if [[ ${pen} == "apple" ]]; then`<br>`echo "${pen}"`<br>`fi` | 
`#!`|  a shebang. used in scripts to make them executable | `#! /usr/bin/env bash` 
`${1}`<br>`${2}`<br>`${3}`<br>... | positional arguments of a script | `$ ./myscript.sh pen pineapple apple`<br> `echo ${1}${2}${3}${1}` |

### Regex basics
| expression    | meaning                                           | example                     |
|---------------|---------------------------------------------------|-----------------------------|
`.` | match any character | `grep '.ear' regex.txt`
`*` | match 0 or more of the preceding items | `grep 'be*r' regex.txt`
`\` | do not interpret next character | `grep 'be\*r' regex.txt`<br> (`*` is interpreted as an asterisk character)
`\?` | match 0 or 1 of the preceding items | `grep 'be\?r' regex.txt`
`\+` | match 1 or more of the preceding items | `grep 'be\+r' regex.txt`
`[]` | match range of characters within [] | `grep 'p[iea]r' regex.txt`
`[^]` | match range of characters except the ones in the bracket | `grep 'p[^iea]r' regex.txt`
`^` | the beginning of the line | `grep '^[rb]\+' regex.txt`
`$` | the end of the line | `grep 'r$' regex.txt`

## Preparation

Before we start, we need to get a few things onto your computer that we will be playing with today. All commands in this section have been introduced in _Basic_ BareBonesBash, so check there if anything is unfamiliar.

Firstly, lets make a new directory 

```bash
$ mkdir boosted_barebonesbash
```

> here we assuming you're in to your home directory, but feel free to put it somewhere else. Just make sure you check all subsequent paths in the rest of the walkthrough!

Now we download the first file, and rename it to something more informative

```bash
$ wget git.io/Boosted-BBB-meta
$ mv Boosted-BBB-meta boosted_barebonesbash/Boosted-BBB-meta.tsv
```

> **Tip**:If using a mac use 'curl -LO' instead!

We will now change into that directory and download a second file. This file is actually zipped, so we will also decompress this.

```bash
$ cd boosted_barebonesbash
$ wget git.io/Boosted-BBB-images
$ unzip Boosted-BBB-images

## and remove the original zip archive
$ rm Boosted-BBB-images
```

## Where is my stuff??

One of first things you want to do when working on the command line is to find out where the directories/files that you want to work with are. In these modern times, this can be hundreds or even thousands of files.

<p align="center">
  <img title="https://giphy.com/gifs/download-find-funsubstancea-XSJIE5xMWA9HO
" src="https://media.giphy.com/media/XSJIE5xMWA9HO/giphy.gif">
</p>

So, how can you search for files and directories hidden in layers and layers of (your of course very organised ;)) directories?

For this task, you can use the command `find`

Let's see how this command works with an example:

```bash
$ find Boosted-BBB/ -type f -name '*JPG'
```

The **first** part of the `find` command indicates **the place from which to start looking**, in the example above, this is the directory `Boosted-BBB`. You can also specify:

- `.` to look in here (the current directory)
- `~/` to look in your home directory
- Absolute path (i.e.`/home/james`). Note: This will print the absolute path and the found file/directory, it is useful when you want to use the output of `find` for other things

> Keep in mind that it will look in the directory specified and all of it's subdirectories unless indicated otherwise!

The **second** part of the `find` command indicates **what type of things you are looking for**

- Use `-type` to define the file type

    - **f**ile
    - **d**irectory

In the example above we are looking for files (`-type f`)

The **third** part of the `find` command is **what to look in**

- Use `-name` to say 'look in the *names* of things'

**Finally**, we provide the actual string to look for.

In the example above, we look for files that contain `JPG` in some part of their name (`'*JPG*'`).
- You can use wildcards (\*) for maximum laziness! 

Check what the output of the find command is by, running it:

```bash
$ find Boosted-BBB/ -type f -name '*JPG'
```

You can also store the string we are looking for in a variable instead! By doing this, you can change the string for another easily in the future (this will be useful when creating scripts, which we will cover later in the session), without having to modify the command itself. 

To do so, let's store our string `JPG` in a variable:

```bash
$ suffix="JPG"
```

Let's try now to call the variable in our find command as:

```bash
$ find Boosted-BBB -type f -name '*$suffix'
```

**BUT WAIT**! There was no output? It did not find any of the files!!?

But we know the files do exist (_trust us_)! Let's try the following command istead:

```
find Boosted-BBB -type f -name "*$suffix"
```

<p align="center">
    <img src="https://tenor.com/view/nagato-naruto-shippuden-nagato-kid-nani-apa-gif-12417317.gif" title="Source: https://tenor.com/view/nagato-naruto-shippuden-nagato-kid-nani-apa-gif-12417317.gif" width="70%">
</p>

🎉 It found your files! What is the difference between these commands?

That's right! The _quotes_!

## Concept: Quotes matter!

Which quotes you use plays an important role in how bash understands the message contained within them:

* Single quotes: the content is passed on as it is written
* Double quotes: the content is _interpreted_

In some cases, the way you write the statments does not matter, as in the following example:

```bash
$ echo "I like Greek Food"
$ echo 'I like Greek Food'
```
This two statements will result in the same (universally true) printed message:

```
I like Greek Food
I like Greek Food
```

Now let's consider the following example:

```bash
$ Arr=Banana
$ echo 'Pirates say $Arr'
$ echo "Minions say $Arr"
```

Here, the results are different:

```
Pirates say $Arr
Minions say Banana
```

<p align="center">
    <div class="row">
        <img src="https://media.giphy.com/media/NSqQkXJjnsVpZQezfg/giphy.gif" title="Source: https://media.giphy.com/media/NSqQkXJjnsVpZQezfg/" width="90%">
        <img src="https://media.giphy.com/media/bh4jzePjmd9iE/giphy.gif" title="Source: https://media.giphy.com/media/bh4jzePjmd9iE/" width="90%">
    </div>
</p>

As you can see in the case of single quotes, bash does not interpret the variable `$Arr` as Banana, since it is not being translated by the computer to the correct meaning. In the case of the double quotes, the program understands `$Arr` as a variable, and interprets it to mean the string contained within it which is`"Banana"`. 

Now, let's continue with your files!

## Cleaning up the filenames

So... you found your files, but it seems that whoever ave you files has (👀) completely mangled the file names (_[What is with this weird file extention `.JPG.MP3.TXT`???]_]

You know that already that these files are supposed to be images with the extension `.JPG` (_[clearly]_). So let's clean up the file names, and then we can sort them into categories. 

There are different ways to tackle this problem. First, we will show you an example that uses `cut` and `rev`.

Can you guess what these commands do?

* `rev`: reverses a character string
* `cut`: cuts a string into multiple pieces

<div class="row">
<p align="center">
  <img style="transform: scaleX(-1)" src="https://media.giphy.com/media/mUGRVgAkamLZe/giphy.gif" title="Source: https://giphy.com/gifs/pony-mUGRVgAkamLZe" width="90%">
</p>

<p align="center">
  <img style="transform: scaleX(-1)" src="https://media.giphy.com/media/2GdACZsbRnTmo/giphy.gif" title="Source: https://giphy.com/gifs/movie-photoset-2GdACZsbRnTmo" width="83%">
</p>
</div>

Let's try them out!

```bash
$ echo "aBcDeF 654321" | rev
```

This results in:

```text
123456 FeDcBa
```

Now let's see how `cut` work. This command needs some options to know how to deal with the string. Those are:

* `-d` specifies the field **d**elimiter we are using. Here it is space (" ").
* `-f` specifies which **f**ield we wish to cut out. We want to recover the numbers, so this will be the second field.
* 
> For more options, check the `man` page!

Let's write the command to obtain the number then:

```bash
$echo "aBcDeF 654321" | cut -d " " -f 2
```

And the result is:

```
654321
```

So let's combine these two tools to clean up our file names. 

You will use a `for` loop to change all the file names you have found with the `find` command to the desired ending (filename containing only the `.JPG` extension)

The `for` loop will look like this:

```bash
$ suffix=JPG
$ for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do
>    new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)
>    echo $file $new_name
> done
```

> **Tip**: Remember that the `>` at the beginning of a code block 
> indicates a multi-line command. You can replace these with `;` 
> to write the whole loop on a single line
 
You should use `echo` to make a 'dry-run', meaning that you can try your code without making any changes to files themselves. 

When you are happy with the output from the echo command, you can replace `echo` with the `mv` command, and re-run the `for` loop to change the name of the file for the `$new_name`.

```bash
$ suffix=JPG
$ for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do
>    new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)
>    mv $file $new_name
> done
```

But hold up...

**This code is cumbersome to write, read and understand.**

<p align="center"><img src="https://tenor.com/view/what-confused-ugh-blackadder-rowan-atkinson-gif-11050590.gif" title="Source: https://tenor.com/view/what-confused-ugh-blackadder-rowan-atkinson-gif-11050590.gif" width="40%">
</p>

### Wait, what just happened? 

Let's break the code in parts to understand what is going on:

* `for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do`: this starts the for loop. The `$()` tells bash to use the _output_ of the `find` command as the list to loop through. 
    * `new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)`: `$()` tells bash to run the commands within parenthesis and interpret the output as a string. The string is then assigned to the `new_name` variable
        * `echo $file`: print the filepath
    
        `~/boosted_barebonesbash/Boosted-BBB/Friday/night/and/the/lights/are/low/fanta.JPG.MP3.TXT`
    
        * `rev`: **rev**erses the file name:
        `TXT.3PM.GPJ.atnaf/wol/era/sthgil/eht/dna/thgin/yadirF/BBB-detsooB/hsabsenoberab_detsoob/~`
        * `cut -d "." -f 2-999`: **cut**s the string at each "." (the `-d`elimiter) and keeps everything after the first delimiter (`-f`ields `2-999`):
         `3PM.GPJ.atnaf/wol/era/sthgil/eht/dna/thgin/yadirF/BBB-detsooB/hsabsenoberab_detsoob/~`
        * `rev`: **rev**erses to the original file name: 
        `~/boosted_barebonesbash/Boosted-BBB/Friday/night/and/the/lights/are/low/fanta.JPG.MP3`
    * `mv`: Finally, we rename the file to `new_name` with `mv`
* `done`: complete the loop
    
### Writing pretty code

The code we just saw was long and unnecessary. It is a good idea to avoid clunky code, because often it can be slow but more importantly unreadable to yourself and others!


To simplify this code we can instead use bash's **parameter expansion**! (It's magic!)

<p align="center"><img src="https://tenor.com/view/fantastic-beasts-fantastic-beasts-and-where-to-find-them-strudel-magic-food-gif-7865320.gif" title="Source: https://tenor.com/view/fantastic-beasts-fantastic-beasts-and-where-to-find-them-strudel-magic-food-gif-7865320.gif" width="50%">
</p>

## Parameter expansion: Without the parameters

Parameter expansion is a feature in bash that allows you to manipulate _variables_. Let's explore some examples!

Given the variable:

```bash
$ foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"
```

You can expand the variable by using `${}`, like this:

```bash
$ echo ${foo}
```
"Expansion" of a variable is just "unpacking" of the variable to see its contents. So the code above will result into bash printing the variable's contents:

```bash
$ /home/thiseas/folder/subfolder/BBB.is.bae.txt
```

This expansion is implied whenever you omit the curly brackets (`$foo` instead of `${foo}`). However, it is still a good idea to include these curly brackets, as it helps to visually distinguish variable names in your code, and to remove any ambiguity as to which is the name of the variable you are trying to expand. 

### Parameter expansion: _with_ parameters!

By adding parameters inside the variable expansion curly brackets, it is also possible to change the way that the variable contents are expanded <ins>without changing the variable definition itself!</ins>. 

Here are some examples:

* `#string`: removes the string from the left side of the variable
    ```bash
    $ echo ${foo}
    $ echo ${foo#/home/}
    ```
    `
    /home/thiseas/folder/subfolder/BBB.is.bae.txt
    `
    `
    thiseas/folder/subfolder/BBB.is.bae.txt
    `
    
* `%string`: removes the string starting from the right side of the variable
    ```bash
    $ echo ${foo}
    $ echo ${foo%.txt}
    ```
    `
    /home/thiseas/folder/subfolder/BBB.is.bae.txt
    `
    `
    /home/thiseas/folder/subfolder/BBB.is.bae
    `
    
You can use wildcards within this parameterised expansions as below:

```bash
$ foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"

$ echo ${foo}    # No parameters in this expansion
$ echo ${foo#*/} # Removes everything before the first '/'
$ echo ${foo%.*} # Removes everything after the last '.'
```
Results in:

```
/home/thiseas/folder/subfolder/BBB.is.bae.txt
home/thiseas/folder/subfolder/BBB.is.bae.txt
/home/thiseas/folder/subfolder/BBB.is.bae
```

Additionally, to remove __all__ matches of the specified pattern, you can repeat the parameter specifier a second time (`##` or `%%`):

```bash
$ echo ${foo##*/} # Removes everything before any '/'
$ echo ${foo%%.*} # Removes everything after any '.'
```

`
BBB.is.bae.txt
`

`
/home/thiseas/folder/subfolder/BBB
`

### More parameters for expansion

Other than removing parts of the variable contents, parameters will allow you to substitute only parts of them as well!

* `/pattern/string`: substitutes the first occurrence of the pattern in the variable contents by the given string

```bash
$ foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"
$ echo ${foo}                    # No parameters
$ echo ${foo/BBB/BareBonesBash}  # Change "BBB" to "BareBonesBash"
```

`
/home/thiseas/folder/subfolder/BBB.is.bae.txt
`

`
/home/thiseas/folder/subfolder/BareBonesBash.is.bae.txt
`

<p align="center"><img src="https://media.giphy.com/media/8YpifFDs9Ux1VNQP1S/giphy.gif" title="Source: https://giphy.com/gifs/adweek-color-apple-8YpifFDs9Ux1VNQP1S/links" width="75%">
</p>

Omitting the string will remove the given pattern (i.e. replace it with an empty string).

*  `/pattern/`: substitutes the string with an empty string

```bash
$ echo ${foo/BBB}  # Remove BBB
```
`
/home/thiseas/folder/subfolder/.is.bae.txt
`

As before, repeating the parameter specifier (`/`) will apply the substitution to __all__ matches of the pattern!

```bash
$ echo ${foo}
$ echo ${foo//is/IS} ## Replace any occurance of 'is' to 'IS'
$ echo ${foo//is} ## Remove all occurances of 'is'
```
`/home/thiseas/folder/subfolder/BBB.is.bae.txt`
`/home/thISeas/folder/subfolder/BBB.IS.bae.txt`
`/home/theas/folder/subfolder/BBB..bae.txt`

### The last parameter, I swear!

Finally, you can check the length of the variable contents (how many characters long they are) by using a `#` BEFORE the variable name.

```bash
$ foo="/home/thiseas/folder/subfolder/BBB.is.bae.txt"
$ echo ${#foo}  # The length of the variable contents
```
`45`

So the filepath in `foo` is 45 characters long!

<p align="center">
  <img src="https://media.giphy.com/media/xUNd9DLukkavmhybAs/giphy.gif
" title="Source: https://media.giphy.com/media/xUNd9DLukkavmhybAs/giphy.gif
" width="40%">
</p>

This parameter will become more handy when when dealing with bash _arrays_ (i.e. lists of things), but these will not be introduced here.

<!-- THISEAS UP TO HERE -->

## Writing pretty code
We can now rewrite our complicated and convoluted code using `rev` and `cut`. DO NOT RUN THIS CODE!

```bash
$ for file in $(find Boosted-BBB/ -type f -name "*$suffix*"); do
>   new_name=$(echo $file | rev | cut -d "." -f 2-999 | rev)
>   echo $file $new_name
> done
```

To this:

```bash
$ for file in $(find Boosted-BBB/ -type f -name "*JPG*"); do
>   echo ${file} ${file%.*}
> done
```

Try running both codes using only the printing command `echo` before modifying the actual variable (dry-running) and check that the result is the same! Is there a difference in runtime?

Result: 0.051s versus 0.003s when running `echo`!

<p align="center">
  <img src="https://media.giphy.com/media/S9v6L1tFHk0pptZzCh/giphy.gif" title="Source: https://giphy.com/gifs/stickergiant-fast-zoom-on-my-way-S9v6L1tFHk0pptZzCh/links" width="50%">
</p>

When you are sure it works, again replace `echo` with `mv` in the 2nd codeblock to rename the files!

```bash
$ for file in $(find Boosted-BBB/ -type f -name "*JPG*"); do
>   mv ${file} ${file%.*}
> done
```

<!-- JAMES UP TO HERE - CONTINUE READING/CODE BLCOK FIXING/GIF ADDING -->

## Almost done!

We now have all the files named similarly, but some things are still a bit off. The file suffix JPG is conventionally written in lowercase characters (jpg).

So, let's change all filename suffixes to be in lowercase letters!

This operation can be done with parameter expansion, but we can use regular expressions to do this without a for loop.

Regex is an important concept that you encounter in most programming languages.

The actual syntax may vary from language to language, but the concept is the same. We will show here's how they work in bash.

## Concept: Regular expressions
Regex are special strings and characters that define a 'search pattern'. They are normally used in 'Search' or 'Search/Replace' functions e.g. in excel! And: **You have already used them!**


Three regex special character 'categories' that must be kept in mind:

* `.`, `*`, `^`, `$` (etc.): special characters that are translated to regex function first. You can stop bash translating those by typing `\` before them, this will find the literal symbol)
* `\t`, `\w`, `\D` (etc.): letter-based special characters that must have \ to be 'translated'
* `[]`, `()`, (etc.): range, grouping, or 'capturing' matching regex within brackets

We will showcase them by applying some search function in a file. For this, download the following file
```
wget git.io/Boosted-BBB-regex
mv Boosted-BBB-regex regex.txt
```
Let's also look at the contents.

```
cat regex.txt
```
Now let's see which 'parameters' we can use to try to find different words using grep:

* `.` : match any character. Let's find strings containing: "any character + ear"

```
grep '.ear' regex.txt
```

* []: match range of characters within
* [^]: match range of characters except the ones in the bracket
* *: match 0 or more of the preceding items
* \: do not interpret next character
* \+: match 1 or more of the preceding items
* \?: match 0 or 1 of the preceding items
* ^: the beginning of the line
* $: the end of the line